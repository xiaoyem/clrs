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

import "math/rand"

func Quicksort(a []int, p, r int) {
    if p < r {
        q := partition(a, p, r)
        Quicksort(a, p, q - 1)
        Quicksort(a, q + 1, r)
    }
}

func partition(a []int, p, r int) int {
    i := p - 1
    for j := p; j < r; j++ {
        if a[j] <= a[r] {
            i++
            a[i], a[j] = a[j], a[i]
        }
    }
    a[i + 1], a[r] = a[r], a[i + 1]
    return i + 1
}

func randomizedPartition(a []int, p, r int) int {
    i := rand.Intn(r - p + 1) + p
    a[r], a[i] = a[i], a[r]
    return partition(a, p, r)
}

func RandomizedQuicksort(a []int, p, r int) {
    if p < r {
        q := randomizedPartition(a, p, r)
        RandomizedQuicksort(a, p, q - 1)
        RandomizedQuicksort(a, q + 1, r)
    }
}

func hoarePartition(a []int, p, r int) int {
    i, j, x := p, r, a[p]
    for true {
        for a[i] < x {
            i++
        }
        for a[j] > x {
            j--
        }
        if i < j {
            a[i], a[j] = a[j], a[i]
        } else {
            break
        }
    }
    return j
}

