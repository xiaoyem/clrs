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

package main

import (
    "fmt"
    . "../p3"
)

func main() {
    var l Dlist
    var a Element
    var b Element
    var c Element
    var d Element
    var e Element
    a.Key = 1
    b.Key = 4
    c.Key = 16
    d.Key = 9
    e.Key = 25
    ListInsert(&l, &a)
    ListInsert(&l, &b)
    ListInsert(&l, &c)
    ListInsert(&l, &d)
    for x := l.Head; x != nil; x = x.Next {
        fmt.Print(x.Key)
    }
    fmt.Print("\n")
    ListInsert(&l, &e)
    for x := l.Head; x != nil; x = x.Next {
        fmt.Print(x.Key)
    }
    fmt.Print("\n")
    ListDelete(&l, &b)
    for x := l.Head; x != nil; x = x.Next {
        fmt.Print(x.Key)
    }
    fmt.Print("\n")
}

