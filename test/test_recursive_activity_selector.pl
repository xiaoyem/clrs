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

do "p4/recursive_activity_selector.pl";

my @s = (0, 1, 3, 0, 5, 3, 5, 6, 8, 8, 2, 12);
my @f = (0, 4, 5, 6, 7, 9, 9, 10, 11, 12, 14, 16);
print recursive_activity_selector(\@s, \@f, 0, 11), "\n";

