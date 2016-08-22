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

from os import sys, path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from p3.list import *

l = dlist()
a = element()
b = element()
c = element()
d = element()
e = element()
a.key = 1
b.key = 4
c.key = 16
d.key = 9
e.key = 25
l.insert(a)
l.insert(b)
l.insert(c)
l.insert(d)
x = l.head
while x is not None:
    print x.key,
    x = x.next
print
l.insert(e)
x = l.head
while x is not None:
    print x.key,
    x = x.next
print
l.remove(b)
x = l.head
while x is not None:
    print x.key,
    x = x.next
print

