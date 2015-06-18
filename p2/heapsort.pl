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

sub parent { my $i = shift; int(($i - 1) / 2); }
sub left   { my $i = shift; $i * 2 + 1; }
sub right  { my $i = shift; $i * 2 + 2; }

sub max_heapify {
    my ($a, $i, $z) = @_;
    my ($l, $r, $largest) = (left($i), right($i), $i);
    $largest = $l if $l <= $z && $a->[$l] > $a->[$i];
    $largest = $r if $r <= $z && $a->[$r] > $a->[$largest];
    if ($largest != $i) {
        @$a[$i, $largest] = @$a[$largest, $i];
        max_heapify($a, $largest, $z);
    }
}

sub build_max_heap {
    my $a = shift;
    for (my $i = int(($#$a - 1) / 2); $i >= 0; --$i) {
        max_heapify($a, $i, $#$a);
    }
}

sub heapsort {
    my $a = shift;
    build_max_heap($a);
    for (my $i = $#$a; $i > 0; --$i) {
        @$a[0, $i] = @$a[$i, 0];
        max_heapify($a, 0, $i - 1);
    }
}

sub heap_maximum { my $a = shift; $a->[0]; }

sub heap_extract_max {
    my $a = shift;
    die "heap underflow\n" if @$a < 1;
    my $max = $a->[0];
    $a->[0] = $a->[$#$a];
    pop @$a;
    max_heapify($a, 0, $#$a);
    $max;
}

sub heap_increase_key {
    my ($a, $i, $key) = @_;
    die "new key is smaller than current key\n" if $key < $a->[$i];
    $a->[$i] = $key;
    while ($i > 0 && $a->[parent($i)] < $a->[$i]) {
        @$a[$i, parent($i)] = @$a[parent($i), $i];
        $i = parent($i);
    }
}

sub min {
    my $x = shift;
    for my $y (@_) {
        $x = $y if $y < $x;
    }
    $x;
}

sub max_heap_insert {
    my ($a, $key) = @_;
    if (@$a == 0) {
        push @$a, $key;
    } else {
        push @$a, min($a->[parent(@$a + 0)], $key);
        heap_increase_key($a, $#$a, $key);
    }
}

