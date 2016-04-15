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

package p1

import (
    "sort"
    "math"
    "math/rand"
)
type MapSorter []Item

type Item struct {
    Key  int
    Val  int
}

func PermuteBySorting(ar []int) []int {
    n := len(ar)
    m := map[int]int{}
    br := []int{}

    for i := 0; i < n; i++ {
        key := rand.Intn(int(math.Pow(float64(n), 3))) + 1
        if _, ok := m[key]; ok {
            i--
        } else {
            m[key] = ar[i]
        }

    }
    ms := make(MapSorter, 0, len(m))
    for k, v := range m {
        ms = append(ms, Item{k, v})
    }
    sort.Sort(ms)
    for _, item := range ms {
        br = append(br, item.Val)
    }
    return br
}

func (ms MapSorter) Len() int {
    return len(ms)
}

func (ms MapSorter) Less(i, j int) bool {
    return ms[i].Key < ms[j].Key
}

func (ms MapSorter) Swap(i, j int) {
    ms[i], ms[j] = ms[j], ms[i]
}
