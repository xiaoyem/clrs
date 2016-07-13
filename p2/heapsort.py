#
# Copyright (c) 2016 by Yuchao Zhao.
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

def heapsort(a) :
    build_max_heap(a)
    for i in range(len(a) - 1, 0, -1) :
        a[0], a[i] = a[i], a[0]
        max_heapify(a, 0, i - 1)

def parent(i) : return (i - 1) / 2
def left  (i) : return i * 2 + 1
def right (i) : return i * 2 + 2

def max_heapify(a, i, z) :
    l, r, largest = left(i), right(i), i
    if l <= z and a[l] > a[i] :
        largest = l
    if r <= z and a[r] > a[largest] :
        largest = r
    if largest != i :
        a[i], a[largest] = a[largest], a[i]
        max_heapify(a, largest, z)

def build_max_heap(a) :
    n = len(a)
    for i in range(n / 2 - 1, -1, -1) :
        max_heapify(a, i, n - 1)

def heap_maximum(a) : return a[0]

def heap_extract_max(a) :
    n = len(a)
    if n < 1:
        return "heap underflow"
    max = a[0]
    a[0] = a[n - 1]
    a.pop()
    max_heapify(a, 0, len(a) - 1)
    return max

def heap_increase_key(a, i, key) :
    if key < a[i] :
        return "new key is smaller than current key"
    a[i] = key
    while i > 0 and a[parent(i)] < a[i] :
        a[i], a[parent(i)] = a[parent(i)], a[i]
        i = parent(i)

def max_heap_insert(a, key) :
    n = len(a)
    if n == 0 :
        a.append(key)
    else :
        a.append(min(a[parent(n)], key))
        heap_increase_key(a, n, key)

