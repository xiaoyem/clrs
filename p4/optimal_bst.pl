#
# Copyright (c) 2005-2015 by Xiaoye Meng.
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

sub optimal_bst {
    my ($p, $q, $n) = @_;
    my (@w, @e, @r);
    for my $i (0..$n) {
        $w[$i]->[$i] = $q->[$i];
        $e[$i]->[$i] = $q->[$i];
    }
    for my $l (1..$n) {
        for my $i (0..$n - $l) {
            my $j = $i + $l;
            $w[$i]->[$j] = $w[$i]->[$j - 1] + $p->[$j - 1] + $q->[$j];
            $e[$i]->[$j] = $e[$i]->[$i] + $e[$i + 1]->[$j] + $w[$i]->[$j];
            $r[$i]->[$j] = $i;
            for my $k ($i + 1..$j - 1) {
                my $q = $e[$i]->[$k] + $e[$k + 1]->[$j] + $w[$i]->[$j];
                if ($q < $e[$i]->[$j]) {
                    $e[$i]->[$j] = $q;
                    $r[$i]->[$j] = $k;
                }
            }
        }
    }
    (@e, @r);
}

