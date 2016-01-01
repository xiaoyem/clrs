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
    char    => '$',
    freq    => '$',
    left    => '$',
    right   => '$'
};

sub parent { my $i = shift; int(($i - 1) / 2); }
sub left   { my $i = shift; $i * 2 + 1; }
sub right  { my $i = shift; $i * 2 + 2; }

sub min_heapify {
    my ($a, $i, $z) = @_;
    my ($l, $r, $smallest) = (left($i), right($i), $i);
    $smallest = $l if $l <= $z && $a->[$l]->freq < $a->[$i]->freq;
    $smallest = $r if $r <= $z && $a->[$r]->freq < $a->[$smallest]->freq;
    if ($smallest != $i) {
        @$a[$i, $smallest] = @$a[$smallest, $i];
        min_heapify($a, $smallest, $z);
    }
}

sub build_min_heap {
    my $a = shift;
    for (my $i = int(($#$a - 1) / 2); $i >= 0; --$i) {
        min_heapify($a, $i, $#$a);
    }
}

sub heap_extract_min {
    my $a = shift;
    die "heap underflow\n" if @$a < 1;
    my $min = $a->[0];
    $a->[0] = $a->[$#$a];
    pop @$a;
    min_heapify($a, 0, $#$a);
    $min;
}

sub heap_decrease_key {
    my ($a, $i, $key) = @_;
    die "new key is larger than current key\n" if $key > $a->[$i]->freq;
    $a->[$i]->freq($key);
    while ($i > 0 && $a->[parent($i)]->freq > $a->[$i]->freq) {
        @$a[$i, parent($i)] = @$a[parent($i), $i];
        $i = parent($i);
    }
}

sub min_heap_insert {
    my ($a, $node) = @_;
    if (@$a == 0) {
        push @$a, $node;
    } else {
        my $key = $node->freq;
        push @$a, $node;
        if ($a->[parent($#$a)]->freq > $node->freq) {
            $node->freq($a->[parent($#$a)]->freq);
            heap_decrease_key($a, $#$a, $key);
        }
    }
}

sub huffman {
    my $c = shift;
    build_min_heap($c);
    my $n = @$c;
    for my $i (0..$n - 2) {
        my $x = heap_extract_min($c);
        my $y = heap_extract_min($c);
        my $z = node->new();
        $z->freq($x->freq + $y->freq);
        $z->left($x);
        $z->right($y);
        min_heap_insert($c, $z);
    }
    heap_extract_min($c);
}

