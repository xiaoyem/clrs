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
    n1, n2 := q - p + 1, r - q
    a1 := append([]int{}, a[p:q + 1]...)
    a2 := append([]int{}, a[q + 1:r + 1]...)
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

// Loop invariant: at the start of each iteration of the for loop, the subarray
// a[p..k - 1] contains the k - p smallest elements of a1[0..n1 - 1] and
// a2[0..n2 - 1], in sorted order. Moreover, a1[i] and a2[j] are the smallest
// elements of their arrays that have not been copied back into a.

