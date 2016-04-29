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

package p2

import (
    "sort"
    "strconv"
)

type H []Item

type Item struct {
    Key  string
    Val  int
}

func RadixSort(ar []int, d int) {
    for i := d - 1; i >= 0; i-- {
        h := make(H, 0, len(ar))
        for index, value := range ar {
            h = append(h, Item{strconv.Itoa(value)[i:i + 1], ar[index]})
        }
        sort.Sort(h)
        for i, item := range h {
            ar[i] = item.Val
        }
    }
}

func (h H) Len() int {
    return len(h)
}

func (h H) Less(i, j int) bool {
    return h[i].Key < h[j].Key
}

func (h H) Swap(i, j int) {
    h[i], h[j] = h[j], h[i]
}

