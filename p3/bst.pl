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
    left    => '$',
    right   => '$'
};

struct bst => {
    root   => '$'
};

sub inorder_tree_walk {
    my $x = shift;
    if (defined $x) {
        inorder_tree_walk($x->left);
        print $x->key, "\n";
        inorder_tree_walk($x->right);
    }
}

sub tree_search {
    my ($x, $k) = @_;
    return $x if !(defined $x) || $k == $x->key;
    $k < $x->key ? tree_search($x->left, $k) : tree_search($x->right, $k);
}

sub iterative_tree_search {
    my ($x, $k) = @_;
    $k < $x->key ? $x = $x->left : ($x = $x->right)
        while defined $x && $k != $x->key;
    $x;
}

sub tree_minimum {
    my $x = shift;
    $x = $x->left while defined $x->left;
    $x;
}

sub tree_maximum {
    my $x = shift;
    $x = $x->right while defined $x->right;
    $x;
}

sub tree_successor {
    my $x = shift;
    return tree_minimum($x->right) if defined $x->right;
    my $y = $x->p;
    ($x, $y) = ($y, $y->p) while defined $y && $x == $y->right;
    $y;
}

sub tree_insert {
    my ($b, $z) = @_;
    my ($x, $y) = $b->root;
    while (defined $x) {
        $y = $x;
        $z->key < $x->key ? $x = $x->left : ($x = $x->right);
    }
    $z->p($y);
    !(defined $y) ? $b->root($z) : ($z->key < $y->key ? $y->left($z) :
        $y->right($z));
}

#sub tree_delete {
#    my ($b, $z) = @_;
#    my ($x, $y);
#    !(defined $z->left) || !(defined $z->right) ? $y = $z :
#        ($y = tree_successor($z));
#    defined $y->left ? $x = $y->left : ($x = $y->right);
#    $x->p($y->p) if defined $x;
#    !(defined $y->p) ? $b->root($x) : ($y == $y->p->left ? $y->p->left($x) :
#        $y->p->right($x));
#    if ($y != $z) {
#        my $tmp = $z->key;
#        $z->key($y->key);
#        $y->key($tmp);
#    }
#    $y->p(undef);
#    $y->left(undef);
#    $y->right(undef);
#    $y;
#}

sub transplant {
    my ($b, $u, $v) = @_;
    !(defined $u->p) ? $b->root($v) : ($u == $u->p->left ? $u->p->left($v) :
        $u->p->right($v));
    $v->p($u->p) if defined $v;
}

sub tree_delete {
    my ($b, $z) = @_;
    if (!(defined $z->left)) {
        transplant($b, $z, $z->right);
    } elsif (!(defined $z->right)) {
        transplant($b, $z, $z->left);
    } else {
        my $y = tree_minimum($z->right);
        if ($y->p != $z) {
            transplant($b, $y, $y->right);
            $y->right($z->right);
            $y->right->p($y);
        }
        transplant($b, $z, $y);
        $y->left($z->left);
        $y->left->p($y);
    }
}

