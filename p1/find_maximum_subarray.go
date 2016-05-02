//
// Copyright (c) 2016 by Qiang Meng.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

package p1

func FindMaximumSubarray(a []int, low, high int) (int, int, int) {
    if high == low {
        return low, high, a[low]
    } else {
        mid := (low + high) / 2
        left_low, left_high, left_sum    := FindMaximumSubarray(a, low, mid)
        right_low, right_high, right_sum := FindMaximumSubarray(a, mid + 1, high)
        cross_low, cross_high, cross_sum := findMaxCrossingSubarray(a, low, mid, high)
        if left_sum >= right_sum && left_sum >= cross_sum {
            return left_low, left_high, left_sum
        } else if right_sum >= left_sum && right_sum >= cross_sum {
            return right_low, right_high, right_sum
        } else {
            return cross_low, cross_high, cross_sum
        }
    }

}

func findMaxCrossingSubarray(a []int, low, mid, high int) (int, int, int) {
    left_sum, max_left, right_sum, max_right, sum := a[mid], mid, a[mid + 1], mid + 1, 0;
    for i := mid; i >= low; i-- {
        sum += a[i]
        if sum > left_sum {
            left_sum = sum
            max_left = i
        }
    }
    sum = 0
    for j := mid + 1; j <= high; j++ {
        sum += a[j]
        if sum > right_sum {
            right_sum = sum
            max_right = j
        }
    }
    return max_left, max_right, left_sum + right_sum
}

