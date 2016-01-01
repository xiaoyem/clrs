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

sub insertion_sort {
    my $a = shift;
    for my $i (1..$#$a) {
        my ($j, $key) = ($i - 1, $a->[$i]);
        $a->[$j-- + 1] = $a->[$j] while $j >= 0 && $a->[$j] > $key;
        $a->[$j + 1] = $key;
    }
}

# Loop invariant: at the start of each iteration of the for loop, the subarray
# a[0..i - 1] consists of the elements originally in a[0..i - 1], but in sorted
# order.

