#coding:utf-8
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

def find_maximum_subarray(a, low, high) :
    if high is low :
        return(low, high, a[high - 1])
    else : 
        mid = ((low + high) / 2) 
        (leftlow, lefthigh, leftsum) = find_maximum_subarray(a, low, mid)
        (rightlow, righthigh, rightsum) = find_maximum_subarray(a ,mid + 1, high)
        (crosslow, crosshigh, crosssum) = find_max_crossing_subarray(a , low, mid, high)
        if leftsum >= rightsum & leftsum >= crosssum :
            return(leftlow, lefthigh, leftsum)
        elif rightsum >=leftsum & rightsum >= crosssum :
            return(rightlow, righthigh, rightsum)
        else :
            return(crosslow, crosshigh,  crosssum)


def find_max_crossing_subarray(a, low, mid, high) :
    leftsum = - float("inf")
    sum = 0
    maxleft = mid
    for i in range(mid, low , -1) :
        sum = sum + a[i]
        if sum > leftsum :
            leftsum = sum
            maxleft = i
    rightsum = -float("inf")
    sum = 0
    maxright = mid + 1
    for j in range(mid + 1, high) :
        sum = sum + a[j]
        if sum > rightsum :
            rightsum = sum
            maxright = j
    return(maxleft, maxright, leftsum + rightsum)


