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

sub find_max_crossing_subarray {
    my ($a, $low, $mid, $high) = @_;
    my ($left_sum, $max_left, $right_sum, $max_right, $sum)
        = ($a->[$mid], $mid, $a->[$mid + 1], $mid + 1, 0);
    for (my $i = $mid; $i >= $low; --$i) {
        $sum += $a->[$i];
        if ($sum > $left_sum) {
            $left_sum = $sum;
            $max_left = $i;
        }
    }
    $sum = 0;
    for (my $j = $mid + 1; $j <= $high; ++$j) {
        $sum += $a->[$j];
        if ($sum > $right_sum) {
            $right_sum = $sum;
            $max_right = $j;
        }
    }
    ($max_left, $max_right, $left_sum + $right_sum);
}

sub find_maximum_subarray {
    my ($a, $low, $high) = @_;
    if ($low == $high) {
        ($low, $high, $a->[$low]);
    } else {
        my $mid = int(($low + $high) / 2);
        my ($left_low, $left_high, $left_sum)
            = find_maximum_subarray($a, $low, $mid);
        my ($right_low, $right_high, $right_sum)
            = find_maximum_subarray($a, $mid + 1, $high);
        my ($cross_low, $cross_high, $cross_sum)
            = find_max_crossing_subarray($a, $low, $mid, $high);
        if ($left_sum >= $right_sum && $left_sum >= $cross_sum) {
            ($left_low, $left_high, $left_sum);
        } elsif ($right_sum >= $left_sum && $right_sum >= $cross_sum) {
            ($right_low, $right_high, $right_sum);
        } else {
            ($cross_low, $cross_high, $cross_sum);
        }
    }
}

