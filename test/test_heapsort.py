
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

from os import sys, path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from p2.heapsort import *
a = [4, 1, 3, 2, 16, 9, 10, 14, 8, 7]
heapsort(a)
print a
b = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
print(heap_maximum(b))
print(heap_extract_max(b))
heap_increase_key(b, 8, 15)
print b
max_heap_insert(b, 17)
print b
