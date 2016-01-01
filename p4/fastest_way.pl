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

sub print_stations {
    my ($l, $ls, $n) = @_;
    my $i = $ls;
    print "line ", $i, ", station ", $n, "\n";
    for (my $j = $n - 1; $j > 0; --$j) {
        $i = $l->[$i - 1]->[$j];
        print "line ", $i, ", station ", $j, "\n";
    }
}

sub fastest_way {
    my ($a, $t, $e, $x, $n) = @_;
    my (@f, $fs, @l, $ls);
    $f[0]->[0] = $e->[0] + $a->[0]->[0];
    $f[1]->[0] = $e->[1] + $a->[1]->[0];
    for my $i (1..$n - 1) {
        if ($f[0]->[$i - 1] + $a->[0]->[$i] <=
            $f[1]->[$i - 1] + $t->[1]->[$i - 1] + $a->[0]->[$i]) {
            $f[0]->[$i] = $f[0]->[$i - 1] + $a->[0]->[$i];
            $l[0]->[$i] = 1;
        } else {
            $f[0]->[$i] = $f[1]->[$i - 1] + $t->[1]->[$i - 1] + $a->[0]->[$i];
            $l[0]->[$i] = 2;
        }
        if ($f[1]->[$i - 1] + $a->[1]->[$i] <=
            $f[0]->[$i - 1] + $t->[0]->[$i - 1] + $a->[1]->[$i]) {
            $f[1]->[$i] = $f[1]->[$i - 1] + $a->[1]->[$i];
            $l[1]->[$i] = 2;
        } else {
            $f[1]->[$i] = $f[0]->[$i - 1] + $t->[0]->[$i - 1] + $a->[1]->[$i];
            $l[1]->[$i] = 1;
        }
    }
    if ($f[0]->[$n - 1] + $x->[0] <= $f[1]->[$n - 1] + $x->[1]) {
        $fs = $f[0]->[$n - 1] + $x->[0];
        $ls = 1;
    } else {
        $fs = $f[1]->[$n - 1] + $x->[1];
        $ls = 2;
    }
    print_stations(\@l, $ls, $n);
}

