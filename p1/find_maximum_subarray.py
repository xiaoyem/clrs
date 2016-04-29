#
# Copyright (c) 2016 by Zhao Yuchao.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

def find_maximum_subarray(a, low, high) :
    if high is low :
        return (low, high, a[high - 1])
    else :
        mid = (low + high) / 2
        (left_low, left_high, left_sum)    = find_maximum_subarray(a, low, mid)
        (right_low, right_high, right_sum) = find_maximum_subarray(a, mid + 1, high)
        (cross_low, cross_high, cross_sum) = find_max_crossing_subarray(a, low, mid, high)
        if left_sum >= right_sum & left_sum >= cross_sum :
            return (left_low, left_high, left_sum)
        elif right_sum >= left_sum & right_sum >= cross_sum :
            return (right_low, right_high, right_sum)
        else :
            return (cross_low, cross_high, cross_sum)

def find_max_crossing_subarray(a, low, mid, high) :
    left_sum, max_left, right_sum, max_right, sum = -float("inf"), mid, -float("inf"), mid + 1, 0
    for i in range(mid, low, -1) :
        sum = sum + a[i]
        if sum > left_sum :
            left_sum = sum
            max_left = i
    sum = 0
    for j in range(mid + 1, high) :
        sum = sum + a[j]
        if sum > right_sum :
            right_sum = sum
            max_right = j
    return (max_left, max_right, left_sum + right_sum)

