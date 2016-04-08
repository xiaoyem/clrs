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

func MergeSort(a []int, p, r int) {
    if p < r {
        q := (p + r) / 2
        MergeSort(a, p, q)
        MergeSort(a, q + 1, r)
        merge(a, p, q, r)
    }
}

func merge(a []int, p, q, r int) {
    n1 := q - p + 1
    n2 := r - q
    a1 := make([]int, n1 + 1)
    a2 := make([]int, n2 + 1)
    for i := 0; i < n1; i++ {
        a1[i] = a[p + i]
    }
    for i := 0; i < n2; i++ {
        a2[i] = a[q + i + 1]
    }
    i, j := 0, 0
    for k := p; k <= r; k++ {
        if i < n1 {
            if (j >= n2 || a1[i] <= a2[j]) {
                a[k] = a1[i]
                i++
            } else {
                a[k] = a2[j]
                j++
            }
        }
    }
}

