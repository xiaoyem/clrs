//
// Copyright (c) 2016 by Qiang Meng.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

package p3

type Element struct {
    Prev *Element
    Key   int
    Next *Element
}

type Dlist struct {
    Head *Element
}

func listSearch(l *Dlist, k int) Element {
    x := l.Head
    for x != nil && x.Key != k {
        x = x.Next
    }
    return *x
}

func ListInsert(l *Dlist, x *Element) {
    x.Next = l.Head
    if l.Head != nil {
        l.Head.Prev = x
    }
    l.Head = x
}

func ListDelete(l *Dlist, x *Element) {
    if x.Prev != nil {
        x.Prev.Next = x.Next
    } else {
        l.Head = x.Next
    }
    if x.Next != nil {
        x.Next.Prev = x.Prev
    }
    x.Prev, x.Next = nil, nil
}

