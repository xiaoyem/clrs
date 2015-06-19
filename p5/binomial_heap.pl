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

struct node => {
    p       => '$',
    key     => '$',
    degree  => '$',
    child   => '$',
    sibling => '$'
};

struct binomial_heap => {
    head             => '$'
};

sub binomial_heap_minimum {
    my $h = shift;
    my $x = $h->head;
    my ($y, $min) = ($x, $x->key);
    $x = $x->sibling;
    while (defined $x) {
        ($min, $y) = ($x->key, $x) if $x->key < $min;
        $x = $x->sibling;
    }
    $y;
}

sub binomial_heap_merge {
    my ($h1, $h2) = @_;
    my ($x, $y, $z, $head) = ($h1->head, $h2->head);
    return $y if !(defined $x);
    return $x if !(defined $y);
    $x->degree < $y->degree ? ($z, $head, $x) = ($x, $x, $x->sibling) :
        (($z, $head, $y) = ($y, $y, $y->sibling));
    while (defined $x && defined $y) {
        if ($x->degree < $y->degree) {
            $z->sibling($x);
            ($z, $x) = ($z->sibling, $x->sibling);
        } else {
            $z->sibling($y);
            ($z, $y) = ($z->sibling, $y->sibling);
        }
    }
    $z->sibling($x) if defined $x;
    $z->sibling($y) if defined $y;
    $head;
}

sub binomial_link {
    my ($y, $z) = @_;
    $y->p($z);
    $y->sibling($z->child);
    $z->child($y);
    $z->degree($z->degree + 1);
}

sub binomial_heap_union {
    my ($h1, $h2) = @_;
    my $h = binomial_heap->new();
    $h->head(binomial_heap_merge($h1, $h2));
    $h1->head(undef);
    $h2->head(undef);
    return undef if !(defined $h->head);
    my $prev;
    my $x = $h->head;
    my $next = $x->sibling;
    while (defined $next) {
        if ($x->degree != $next->degree ||
            (defined $next->sibling && $next->sibling->degree == $x->degree)) {
            ($prev, $x) = ($x, $next);
        } elsif ($x->key <= $next->key) {
            $x->sibling($next->sibling);
            binomial_link($next, $x);
        } else {
            !(defined $prev) ? $h->head($next) : $prev->sibling($next);
            binomial_link($x, $next);
            $x = $next;
        }
        $next = $x->sibling;
    }
    $h->head;
}

sub binomial_heap_insert {
    my ($h, $x) = @_;
    my $h2 = binomial_heap->new();
    $x->p(undef);
    $x->degree(0);
    $x->child(undef);
    $x->sibling(undef);
    $h2->head($x);
    $h->head(binomial_heap_union($h, $h2));
}

sub binomial_heap_extract_min {
    my $h = shift;
    return undef if !(defined $h->head);
    my ($x, $y) = (binomial_heap_minimum($h), $h->head);
    if ($y == $x) {
        $h->head($x->sibling);
    } else {
        $y = $y->sibling while $y->sibling != $x;
        $y->sibling($x->sibling);
    }
    $x->sibling(undef);
    my ($h2, $p) = (binomial_heap->new(), $x->child);
    if (defined $p) {
        for (my $q = $p->sibling; defined $q; $q = $p->sibling) {
            $p->sibling($q->sibling);
            $q->sibling($x->child);
            $x->child($q);
        }
        $h2->head($x->child);
        $p = $x->child;
        while (defined $p) {
            $p->p(undef);
            $p = $p->sibling;
        }
        $x->child(undef);
    }
    $h->head(binomial_heap_union($h, $h2));
    $x;
}

sub binomial_heap_decrease_key {
    my ($h, $x, $k) = @_;
    die "new key is greater than current key\n" if $k > $x->key;
    $x->key($k);
    my $y = $x;
    my $z = $y->p;
    while (defined $z && $y->key < $z->key) {
        my $tmp = $y->key;
        $y->key($z->key);
        $z->key($tmp);
        $y = $z;
        $z = $y->p;
    }
}

sub binomial_heap_delete {
    my ($h, $x) = @_;
    my $k = binomial_heap_minimum($h)->key - 1;
    binomial_heap_decrease_key($h, $x, $k);
    binomial_heap_extract_min($h);
}

