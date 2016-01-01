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

struct node => {
    p       => '$',
    rank    => '$'
};

struct graph => {
    v        => '@',
    e        => '@'
};

sub make_set {
    my $x = shift;
    $x->p($x);
    $x->rank(0);
}

sub find_set {
    my $x = shift;
    $x->p(find_set($x->p)) if $x != $x->p;
    $x->p;
}

sub link2 {
    my ($x, $y) = @_;
    if ($x->rank > $y->rank) {
        $y->p($x);
    } else {
        $x->p($y);
        $y->rank($y->rank + 1) if $x->rank == $y->rank;
    }
}

sub union {
    my ($x, $y) = @_;
    link2(find_set($x), find_set($y));
}

sub mst_kruskal {
    my $g = shift;
    for my $v (@{$g->v}) {
        make_set($v);
    }
    my @tmp = sort { $a->[0] <=> $b->[0] } @{$g->e};
    $g->e(\@tmp);
    my @a;
    for my $e (@{$g->e}) {
        if (find_set($e->[1]) != find_set($e->[2])) {
            union($e->[1], $e->[2]);
            push @a, $e;
        }
    }
    @a;
}

