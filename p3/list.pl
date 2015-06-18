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

use Class::Struct;

struct element => {
    prev       => '$',
    key        => '$',
    next       => '$'
};

struct dlist => {
    head     => '$'
};

sub list_search {
    my ($l, $k) = @_;
    my $x = $l->head;
    $x = $x->next while defined $x && $x->key != $k;
    $x;
}

sub list_insert {
    my ($l, $x) = @_;
    $x->next($l->head);
    $l->head->prev($x) if defined $l->head;
    $l->head($x);
}

sub list_delete {
    my ($l, $x) = @_;
    defined $x->prev ? $x->prev->next($x->next) : $l->head($x->next);
    $x->next->prev($x->prev) if defined $x->next;
    $x->prev(undef);
    $x->next(undef);
}

