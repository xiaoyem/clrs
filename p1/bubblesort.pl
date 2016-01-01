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

sub bubblesort {
    my $a = shift;
    for my $i (0..$#$a) {
        for (my $j = $#$a; $j > $i; --$j) {
            @$a[$j, $j - 1] = @$a[$j - 1, $j] if $a->[$j] < $a->[$j - 1];
        }
    }
}

