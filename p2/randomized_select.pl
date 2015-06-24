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

do "p2/quicksort.pl";

sub randomized_select {
    my ($a, $p, $r, $i) = @_;
    return $a[$p] if $p == $r;
    my $q = randomized_partition($a, $p, $r);
    my $k = $q - $p + 1;
    $i == $k ? $a->[$q] : ($i < $k ? randomized_select($a, $p, $q - 1, $i) :
        randomized_select($a, $q + 1, $r, $i - $k));
}

