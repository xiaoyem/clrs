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

do "p1/insertion_sort.pl";

sub bucket_sort {
    my $a = shift;
    my @b;
    for my $x (@$a) {
        push @{$b[int($x * @$a)]}, $x;
    }
    for my $x (@b) {
        insertion_sort($x);
    }
    undef @$a;
    for my $x (@b) {
        push @$a, @$x if defined $x;
    }
}

