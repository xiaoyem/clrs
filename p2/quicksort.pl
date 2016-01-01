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

sub partition {
    my ($a, $p, $r) = @_;
    my $i = $p - 1;
    for my $j ($p..$r - 1) {
        if ($a->[$j] <= $a->[$r]) {
            ++$i;
            @$a[$i, $j] = @$a[$j, $i];
        }
    }
    @$a[$i + 1, $r] = @$a[$r, $i + 1];
    $i + 1;
}

sub quicksort {
    my ($a, $p, $r) = @_;
    if ($p < $r) {
        my $q = partition($a, $p, $r);
        quicksort($a, $p, $q - 1);
        quicksort($a, $q + 1, $r);
    }
}

sub randomized_partition {
    my ($a, $p, $r) = @_;
    my $i = int(rand($r - $p + 1)) + $p;
    @$a[$r, $i] = @$a[$i, $r];
    partition($a, $p, $r);
}

sub randomized_quicksort {
    my ($a, $p, $r) = @_;
    if ($p < $r) {
        my $q = randomized_partition($a, $p, $r);
        randomized_quicksort($a, $p, $q - 1);
        randomized_quicksort($a, $q + 1, $r);
    }
}

sub hoare_partition {
    my ($a, $p, $r) = @_;
    my ($i, $j, $x) = ($p, $r, $a->[$p]);
    while (1) {
        ++$i while $a->[$i] < $x;
        --$j while $a->[$j] > $x;
        $i < $j ? @$a[$i, $j] = @$a[$j, $i] : return $j;
    }
}

