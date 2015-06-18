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
    color   => '$',
    left    => '$',
    right   => '$'
};

my $dummy = node->new(color => 'B');

struct rbt => {
    root   => '$'
};

sub rb_new {
    rbt->new(root => $dummy);
}

sub tree_minimum {
    my $x = shift;
    $x = $x->left while $x->left != $dummy;
    $x;
}

sub tree_successor {
    my $x = shift;
    return tree_minimum($x->right) if $x->right != $dummy;
    my $y = $x->p;
    ($x, $y) = ($y, $y->p) while $y != $dummy && $x == $y->right;
    $y;
}

sub left_rotate {
    my ($r, $x) = @_;
    my $y = $x->right;
    $x->right($y->left);
    $y->left->p($x) if $y->left != $dummy;
    $y->p($x->p);
    $x->p == $dummy ? $r->root($y) : ($x == $x->p->left ? $x->p->left($y) :
        $x->p->right($y));
    $y->left($x);
    $x->p($y);
}

sub right_rotate {
    my ($r, $y) = @_;
    my $x = $y->left;
    $y->left($x->right);
    $x->right->p($y) if $x->right != $dummy;
    $x->p($y->p);
    $y->p == $dummy ? $r->root($x) : ($y == $y->p->left ? $y->p->left($x) :
        $y->p->right($x));
    $x->right($y);
    $y->p($x);
}

sub rb_insert_fixup {
    my ($r, $z) = @_;
    while ($z->p->color eq 'R') {
        if ($z->p == $z->p->p->left) {
            my $y = $z->p->p->right;
            if ($y->color eq 'R') {
                $z->p->color('B');
                $y->color('B');
                $z->p->p->color('R');
                $z = $z->p->p;
            } else {
                if ($z == $z->p->right) {
                    $z = $z->p;
                    left_rotate($r, $z);
                }
                $z->p->color('B');
                $z->p->p->color('R');
                right_rotate($r, $z->p->p);
            }
        } else {
            my $y = $z->p->p->left;
            if ($y->color eq 'R') {
                $z->p->color('B');
                $y->color('B');
                $z->p->p->color('R');
                $z = $z->p->p;
            } else {
                if ($z == $z->p->left) {
                    $z = $z->p;
                    right_rotate($r, $z);
                }
                $z->p->color('B');
                $z->p->p->color('R');
                left_rotate($r, $z->p->p);
            }
        }
    }
    $r->root->color('B');
}

sub rb_insert {
    my ($r, $z) = @_;
    my ($x, $y) = ($r->root, $dummy);
    while ($x != $dummy) {
        $y = $x;
        $z->key < $x->key ? $x = $x->left : ($x = $x->right);
    }
    $z->p($y);
    $y == $dummy ? $r->root($z) : ($z->key < $y->key ? $y->left($z) :
        $y->right($z));
    $z->left($dummy);
    $z->right($dummy);
    $z->color('R');
    rb_insert_fixup($r, $z);
}

sub rb_delete_fixup {
    my ($r, $x) = @_;
    while ($x != $r->root && $x->color eq 'B') {
        if ($x == $x->p->left) {
            my $w = $x->p->right;
            if ($w->color eq 'R') {
                $w->color('B');
                $x->p->color('R');
                left_rotate($r, $x->p);
                $w = $x->p->right;
            }
            if ($w->left->color eq 'B' && $w->right->color eq 'B') {
                $w->color('R');
                $x = $x->p;
            } else {
                if ($w->right->color eq 'B') {
                    $w->left->color('B');
                    $w->color('R');
                    right_rotate($r, $w);
                    $w = $x->p->right;
                }
                $w->color($x->p->color);
                $x->p->color('B');
                $w->right->color('B');
                left_rotate($r, $x->p);
                $x = $r->root;
            }
        } else {
            my $w = $x->p->left;
            if ($w->color eq 'R') {
                $w->color('B');
                $x->p->color('R');
                right_rotate($r, $x->p);
                $w = $x->p->left;
            }
            if ($w->left->color eq 'B' && $w->right->color eq 'B') {
                $w->color('R');
                $x = $x->p;
            } else {
                if ($w->left->color eq 'B') {
                    $w->right->color('B');
                    $w->color('R');
                    left_rotate($r, $w);
                    $w = $x->p->left;
                }
                $w->color($x->p->color);
                $x->p->color('B');
                $w->left->color('B');
                right_rotate($r, $x->p);
                $x = $r->root;
            }
        }
    }
    $x->color('B');
}

sub rb_delete {
    my ($r, $z) = @_;
    my ($x, $y);
    $z->left == $dummy || $z->right == $dummy ? $y = $z :
        ($y = tree_successor($z));
    $y->left != $dummy ? $x = $y->left : ($x = $y->right);
    $x->p($y->p);
    $y->p == $dummy ? $r->root($x) : ($y == $y->p->left ? $y->p->left($x) :
        $y->p->right($x));
    if ($y != $z) {
        my $tmp = $y->key;
        $y->key($z->key);
        $z->key($tmp);
    }
    rb_delete_fixup($r, $x) if $y->color eq 'B';
    $y->p(undef);
    $y->left(undef);
    $y->right(undef);
    $y;
}

