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

sub merge {
    my ($a, $p, $q, $r) = @_;
    my ($n1, $n2, @a1, @a2) = ($q - $p + 1, $r - $q);
    for my $i (0..$n1 - 1) {
        $a1[$i] = $a->[$p + $i];
    }
    for my $i (0..$n2 - 1) {
        $a2[$i] = $a->[$q + $i + 1];
    }
    my ($i, $j) = (0, 0);
    for my $k ($p..$r) {
        $a->[$k] = $j >= $n2 || $a1[$i] <= $a2[$j] ? $a1[$i++] : $a2[$j++]
            if $i < $n1;
    }
}

sub merge_sort {
    my ($a, $p, $r) = @_;
    if ($p < $r) {
        my $q = int(($p + $r) / 2);
        merge_sort($a, $p, $q);
        merge_sort($a, $q + 1, $r);
        merge($a, $p, $q, $r);
    }
}

# Loop invariant: at the start of each iteration of the for loop, the subarray
# a[p..k - 1] contains the k - p smallest elements of a1[0..n1 - 1] and
# a2[0..n2 - 1], in sorted order. Moreover, a1[i] and a2[j] are the smallest
# elements of their arrays that have not been copied back into a.

