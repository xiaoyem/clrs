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
    mark    => '$',
    child   => '$',
    left    => '$',
    right   => '$'
};

struct fib_heap => {
    min         => '$',
    n           => '$'
};

sub fib_heap_new {
    fib_heap->new(n => 0);
}

sub fib_heap_insert {
    my ($h, $x) = @_;
    $x->p(undef);
    $x->degree(0);
    $x->mark(undef);
    $x->child(undef);
    my $min = $h->min;
    if (!(defined $min)) {
        $x->left($x);
        $x->right($x);
        $h->min($x);
    } else {
        my $left = $min->left;
        $min->left($x);
        $x->right($min);
        $x->left($left);
        $left->right($x);
        $h->min($x) if $x->key < $min->key;
    }
    $h->n($h->n + 1);
}

sub fib_heap_union {
    my ($h1, $h2) = @_;
    my $h = fib_heap_new();
    $h->min($h1->min);
    my ($min, $min2) = ($h->min, $h2->min);
    if (!(defined $min)) {
        $h->min($min2);
    } elsif (defined $min2) {
        my ($left, $left2) = ($min->left, $min2->left);
        $min->left($left2);
        $left2->right($min);
        $min2->left($left);
        $left->right($min2);
        $h->min($min2) if $min2->key < $min->key;
    }
    $h->n($h1->n + $h2->n);
    $h1->min(undef);
    $h2->min(undef);
    $h1->n(0);
    $h2->n(0);
    $h->min;
}

sub fib_heap_link {
    my ($h, $y, $x) = @_;
    my ($left, $right) = ($y->left, $y->right);
    $right->left($left);
    $left->right($right);
    my $child = $x->child;
    if (!(defined $child)) {
        $y->left($y);
        $y->right($y);
        $x->child($y);
    } else {
        my $left = $child->left;
        $child->left($y);
        $y->right($child);
        $y->left($left);
        $left->right($y);
    }
    $y->p($x);
    $y->mark(undef);
    $x->degree($x->degree + 1);
}

sub consolidate {
    my $h = shift;
    my $next = $h->min;
    my ($s, %a) = $next->left;
    my ($w, $x, $d);
    do {
        $w = $next;
        $x = $w;
        $d = $x->degree;
        $next = $w->right;
        while (defined $a{$d}) {
            my $y = $a{$d};
            ($x, $y) = ($y, $x) if $x->key > $y->key;
            fib_heap_link($h, $y, $x);
            $a{$d} = undef;
            ++$d;
        }
        $a{$d} = $x;
    } until $w == $s;
    $h->min(undef);
    for my $k (keys %a) {
        my $v = $a{$k};
        if (defined $v) {
            my $min = $h->min;
            if (!(defined $min)) {
                $v->left($v);
                $v->right($v);
                $h->min($v);
            } else {
                my $left = $min->left;
                $min->left($v);
                $v->right($min);
                $v->left($left);
                $left->right($v);
                $h->min($v) if $v->key < $min->key;
            }
        }
    }
}

sub fib_heap_extract_min {
    my $h = shift;
    my $z = $h->min;
    if (defined $z) {
        my $child = $z->child;
        if (defined $child) {
            $child->p(undef);
            for (my $x = $child->right; $x != $child; $x = $x->right) {
                $x->p(undef);
            }
            $z->child(undef);
            my ($left, $left2) = ($z->left, $child->left);
            $z->left($left2);
            $left2->right($z);
            $child->left($left);
            $left->right($child);
        }
        my ($left, $right) = ($z->left, $z->right);
        $right->left($left);
        $left->right($right);
        if ($z == $right) {
            $h->min(undef);
        } else {
            $h->min($right);
            consolidate($h);
        }
        $h->n($h->n - 1);
        $z->left(undef);
        $z->right(undef);
    }
    $z;
}

sub cut {
    my ($h, $x, $y) = @_;
    my ($left, $right) = ($x->left, $x->right);
    $right->left($left);
    $left->right($right);
    $x->p(undef);
    $x->mark(undef);
    $y->degree($y->degree - 1);
    $y->degree == 0 ? $y->child(undef) :
        $y->child($x->right) if $y->child == $x;
    my $min = $h->min;
    if (!(defined $min)) {
        $x->left($x);
        $x->right($x);
        $h->min($x);
    } else {
        my $left = $min->left;
        $min->left($x);
        $x->right($min);
        $x->left($left);
        $left->right($x);
    }
}

sub cascading_cut {
    my ($h, $y) = @_;
    my $z = $y->p;
    if (defined $z) {
        if (!(defined $y->mark)) {
            $y->mark(1);
        } else {
            cut($h, $y, $z);
            cascading_cut($h, $z);
        }
    }
}

sub fib_heap_decrease_key {
    my ($h, $x, $k) = @_;
    die "new key is greater than current key\n" if $k > $x->key;
    $x->key($k);
    my $y = $x->p;
    if (defined $y && $x->key < $y->key) {
        cut($h, $x, $y);
        cascading_cut($h, $y);
    }
    $h->min($x) if $x->key < $h->min->key;
}

sub fib_heap_delete {
    my ($h, $x) = @_;
    my $k = $h->min->key - 1;
    fib_heap_decrease_key($h, $x, $k);
    fib_heap_extract_min($h);
}

