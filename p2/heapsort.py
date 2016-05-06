
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

def left(i) :
    return 2 * i + 1
def right(i) :
    return 2 * i + 2
def parent(i) :
    return int((i - 1) / 2)

def max_heapify(a, i, aheapsize) :
    l = left(i)
    r = right(i)
    if l <= aheapsize and a[l] > a[i] :
        largest = l
    else :
        largest = i
    if r <= aheapsize and a[r] > a[largest] :
        largest = r
    if largest != i :
        a[i], a[largest] = a[largest], a[i]
        max_heapify(a, largest, aheapsize)

def build_max_heap(a) :
    aheapsize = len(a)
    for i in range(len(a) / 2, - 1, - 1) :
        max_heapify(a, i, aheapsize - 1)

def heapsort(a) :
    build_max_heap(a)
    aheapsize = len(a)
    for i in range(len(a) - 1, 0, - 1) :
        a[0], a[i] = a[i], a[0]
        aheapsize = aheapsize - 1
        max_heapify(a, 0, aheapsize - 1 )
        
def heap_maximum(a) :
    return a[0]

def heap_extract_max(a) :
    aheapsize = len(a)
    if aheapsize < 1:
        print"error: heap underflow"
    maxnum = a[0]
    a[0] = a[len(a) - 1]
    aheapsize -= 1
    max_heapify(a, 1, aheapsize)
    return maxnum

def heap_increase_key(a, i, key) :
    if key < a[i] :
        print "error: new key is smaller than current key"
    a[i] = key
    while i > 0 and a[parent(i)] < a[i] :
        a[i], a[parent(i)] = a[parent(i)], a[i]
        i = parent(i)

def max_heap_insert(a, key) :
    a.append(-float("inf"))
    heap_increase_key(a, len(a) - 1, key)
