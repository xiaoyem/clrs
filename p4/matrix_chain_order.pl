#
# Copyright (c) 2005-2016 by Xiaoye Meng.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

sub print_optimal_parens {
    my ($s, $i, $j) = @_;
    if ($i == $j) {
        print "A", $i;
    } else {
        print "(";
        print_optimal_parens($s, $i, $s->[$i]->[$j]);
        print_optimal_parens($s, $s->[$i]->[$j] + 1, $j);
        print ")";
    }
}

sub matrix_chain_order {
    my $p = shift;
    my ($n, @m, @s) = @$p - 1;
    for my $i (0..$n - 1) {
        $m[$i]->[$i] = 0;
    }
    for my $l (2..$n) {
        for my $i (0..$n - $l) {
            my $j = $i + $l - 1;
            $m[$i]->[$j] = $m[$i]->[$i] + $m[$i + 1]->[$j] +
                $p->[$i] * $p->[$i + 1] * $p->[$j + 1];
            $s[$i]->[$j] = $i;
            for my $k ($i + 1..$j - 1) {
                my $q = $m[$i]->[$k] + $m[$k + 1]->[$j] +
                    $p->[$i] * $p->[$k + 1] * $p->[$j + 1];
                if ($q < $m[$i]->[$j]) {
                    $m[$i]->[$j] = $q;
                    $s[$i]->[$j] = $k;
                }
            }
        }
    }
    print_optimal_parens(\@s, 0, $n - 1);
}

sub recursive_matrix_chain {
    my ($p, $i, $j) = @_;
    my ($n, @m) = @$p - 1;
    return 0 if $i == $j;
    $m[$i]->[$j] = recursive_matrix_chain($p, $i, $i) +
        recursive_matrix_chain($p, $i + 1, $j) +
        $p->[$i] * $p->[$i + 1] * $p->[$j + 1];
    for my $k ($i + 1..$j - 1) {
        my $q = recursive_matrix_chain($p, $i, $k) +
            recursive_matrix_chain($p, $k + 1, $j) +
            $p->[$i] * $p->[$k + 1] * $p->[$j + 1];
        $m[$i]->[$j] = $q if $q < $m[$i]->[$j];
    }
    $m[$i]->[$j];
}

sub lookup_chain {
    my ($p, $m, $i, $j) = @_;
    return $m->[$i]->[$j] if defined $m->[$i]->[$j];
    if ($i == $j) {
        $m->[$i]->[$j] = 0;
    } else {
        $m->[$i]->[$j] = lookup_chain($p, $m, $i, $i) +
            lookup_chain($p, $m, $i + 1, $j) +
            $p->[$i] * $p->[$i + 1] * $p->[$j + 1];
        for my $k ($i + 1..$j - 1) {
            my $q = lookup_chain($p, $m, $i, $k) +
                lookup_chain($p, $m, $k + 1, $j) +
                $p->[$i] * $p->[$k + 1] * $p->[$j + 1];
            $m->[$i]->[$j] = $q if $q < $m->[$i]->[$j];
        }
    }
    $m->[$i]->[$j];
}

sub memoized_matrix_chain {
    my $p = shift;
    my ($n, @m) = @$p - 1;
    lookup_chain($p, \@m, 0, $n - 1);
}

