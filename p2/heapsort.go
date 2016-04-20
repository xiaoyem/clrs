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
    "fmt"
    "math"
    "errors"
)

func parent(i int) int { return (i - 1) / 2 }
func left(i int) int { return i * 2 + 1 }
func right(i int) int { return i * 2 + 2 }

func HeapSort(a []int) {
    buildMaxHeap(a)
    for i := len(a) - 1; i > 0; i-- {
        a[0], a[i] = a[i], a[0]
        maxHeapify(a, 0, i - 1)
    }
}

func maxHeapify(a []int, i, z int) {
    l, r, largest := left(i), right(i), i
    if l <= z && a[l] > a[i] {
        largest = l
    }
    if r <= z && a[r] > a[largest] {
        largest = r
    }
    if largest != i {
        a[i], a[largest] = a[largest], a[i]
        maxHeapify(a, largest, z)
    }
}

func buildMaxHeap(a []int) {
    for i := ((len(a) - 1) / 2) - 1; i >= 0; i-- {
        maxHeapify(a, i, len(a) - 1)
    }
}

func HeapMaximum(a []int) int { return a[0] }

func HeapExtractMax(a []int) (int, []int) {
    n := len(a)
    if len(a) < 1 {
        err := errors.New("heap underflow")
        if err != nil {
            fmt.Println(err)
        }
    }
    max := a[0]
    a[0] = a[n - 1]
    a = a[:n - 1]
    maxHeapify(a, 0, n - 2)
    return max, a
}

func HeapIncreaseKey(a []int, i, key int) {
    if key < a[i] {
        err := errors.New("new key is smaller than current key")
        if err != nil {
            fmt.Println(err)
        }
    }
    a[i] = key
    for i > 0 && a[parent(i)] < a[i] {
        a[i], a[parent(i)] = a[parent(i)], a[i]
        i = parent(i)
    }
}

func MaxHeapInsert(a []int, key int) []int {
    if len(a) == 0 {
        a = append(a, key)
    } else {
        a = append(a, int(math.Min(float64(a[parent(len(a) + 0)]), float64(key))))
        HeapIncreaseKey(a, len(a) - 1, key)
    }
    return a
}

