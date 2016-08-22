#
# Copyright (c) 2016 by Yuchao Zhao.
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

class element(object):
    def __init__(self, prev = None, key = None, next = None):
        self.prev = prev
        self.key  = key
        self.next = next

class dlist(object):
    def __init__(self, head = None):
        self.head = head

    def search(self, k):
        x = self.head
        while x is not None and x.key != k:
            x = x.next
        return x

    def insert(self, x):
        x.next = self.head
        if self.head is not None:
            self.head.prev = x
        self.head = x

    def remove(self, x):
        if x.prev is not None:
            x.prev.next = x.next
        else:
            self.head = x.next
        if x.next is not None:
            x.next.prev = x.prev
        x.prev, x.next = None, None

