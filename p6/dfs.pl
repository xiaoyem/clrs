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

use Class::Struct;

struct vertex => {
    pi        => '$',
    d         => '$',
    f         => '$',
    color     => '$',
    alist     => '@'
};

my $time;

sub dfs_visit {
    my $u = shift;
    $u->d(++$time);
    $u->color('G');
    for my $v (@{$u->alist}) {
        if ($v->color eq 'W') {
            $v->pi($u);
            dfs_visit($v);
        }
    }
    $u->f(++$time);
    $u->color('B');
}

sub dfs {
    my $g = shift;
    for my $u (@$g) {
        $u->color('W');
    }
    $time = 0;
    for my $u (@$g) {
        dfs_visit($u) if $u->color eq 'W';
    }
}

