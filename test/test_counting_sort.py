
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
from p2.counting_sort import *
a = [2, 5, 3, 0, 2, 3, 0, 3]
print(counting_sort(a))

