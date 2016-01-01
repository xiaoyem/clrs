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

sub print_lcs {
    my ($b, $x, $i, $j) = @_;
    return if $i == 0 || $j == 0;
    if ($b->[$i]->[$j] == 7) {
        print_lcs($b, $x, $i - 1, $j - 1);
        print $x->[$i - 1];
    } elsif ($b->[$i]->[$j] == 0) {
        print_lcs($b, $x, $i - 1, $j);
    } else {
        print_lcs($b, $x, $i, $j - 1);
    }
}

sub lcs_length {
    my ($x, $y) = @_;
    my ($m, $n, @a, @b) = (@$x + 0, @$y + 0);
    for my $i (0..$m) {
        $a[$i]->[0] = 0;
    }
    for my $i (1..$n) {
        $a[0]->[$i] = 0;
    }
    for my $i (1..$m) {
        for my $j (1..$n) {
            if ($x->[$i - 1] eq $y->[$j - 1]) {
                $a[$i]->[$j] = $a[$i - 1]->[$j - 1] + 1;
                $b[$i]->[$j] = 7;
            } elsif ($a[$i - 1]->[$j] >= $a[$i]->[$j - 1]) {
                $a[$i]->[$j] = $a[$i - 1]->[$j];
                $b[$i]->[$j] = 0;
            } else {
                $a[$i]->[$j] = $a[$i]->[$j - 1];
                $b[$i]->[$j] = 6;
            }
        }
    }
    print_lcs(\@b, $x, $m, $n);
}

