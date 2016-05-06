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
# -*- coding:utf-8 -*-

def insertion_sort(a) :
    n = len(a)
    for i in range(1, n) :
        j, key = i - 1, a[i];
        while j >= 0 and a[j] > key :
            a[j + 1] = a[j]
            j -= 1
        a[j + 1] = key

def bucket_sort(a) :
    n = len(a)
    b = []
    for i in range(n) :
        b.append([])
    for i in range(n) :
        b[int(n * a[i])].append(a[i])
    for i in range(n):
        insertion_sort(b[i])
    c = []
    for i in range(n) :
        if len(b[i]) > 0 :
            for j in b[i] :
                c.append(j)
    return c


