
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
# -*- coding:utf-8 -*-
import random
def quicksort(a, p, r) :
    if p < r :
        q = partition(a, p, r)
        quicksort(a, p, q - 1)
        quicksort(a, q + 1, r)

def partition(a, p, r) :
    x = a[r]
    i = p - 1
    for j in range(p , r) :
        if a[j] <= x :
            i = i + 1
            a[i], a[j] = a[j], a[i]
    a[i + 1], a[r] = a[r], a[i + 1]
    return i + 1

def randomized_partition(a, p, r) :
    i = random.randint(p, r)
    a[r], a[i] = a[i], a[r]
    return partition(a, p, r)

def randomized_quicksort(a, p, r) :
    if p < r :
        q = randomized_partition(a, p, r)
        randomized_quicksort(a, p, q - 1)
        randomized_quicksort(a, q + 1, r)

def hoare_partition(a, p, r) :
    x = a[p]
    i = p
    j = r
    while 1 :
        if a[i] < x :
            i += 1
        if a[j] > x :
            j -= 1
        if i < j :
            a[i], a[j] = a[j], a[i]
        else :
            break
    return j

def hoare_quicksort(a, p, r) :
    if p < r :
        q = hoare_partition(a, p, r)
        hoare_quicksort(a, p, q - 1)
        hoare_quicksort(a, q + 1, r)



