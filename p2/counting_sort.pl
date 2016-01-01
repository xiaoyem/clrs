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

sub counting_sort {
    my ($a, $b, $k) = @_;
    my @c;
    for my $i (0..$k) {
        $c[$i] = 0;
    }
    for my $x (@$a) {
        ++$c[$x];
    }
    for my $i (1..$k) {
        $c[$i] += $c[$i - 1];
    }
    for (my $i = $#$a; $i >= 0; --$i) {
        $b->[$c[$a->[$i]]-- - 1] = $a->[$i];
    }
}

