
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
from p2.quicksort import *
a = [4, 1, 3, 2, 16, 9, 10, 14, 8, 7]
quicksort(a, 0, 9)
print a
b = [2, 1, 3, 6, 4, 8, 5, 7]
randomized_quicksort(b, 0, 7)
print b
c =[4, 2, 8, 9, 1, 3, 10, 6]
hoare_quicksort(c, 0, 7)
print c
