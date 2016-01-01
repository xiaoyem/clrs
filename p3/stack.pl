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

sub stack_empty {
    my $s = shift;
    @$s == 0 ? 1 : 0;
}

sub push2 {
    my ($s, $x) = @_;
    push @$s, $x;
}

sub pop2 {
    my $s = shift;
    die "underflow\n" if stack_empty($s);
    pop @$s;
}

