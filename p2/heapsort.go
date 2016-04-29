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
    "errors"
    "math"
)

func HeapSort(a []int) {
    buildMaxHeap(a)
    for i := len(a) - 1; i > 0; i-- {
        a[0], a[i] = a[i], a[0]
        maxHeapify(a, 0, i - 1)
    }
}

func parent(i int) int { return (i - 1) / 2 }
func left  (i int) int { return i * 2 + 1 }
func right (i int) int { return i * 2 + 2 }

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
    for i := (len(a) - 2) / 2; i >= 0; i-- {
        maxHeapify(a, i, len(a) - 1)
    }
}

func heapMaximum(a []int) int { return a[0] }

func heapExtractMax(a *[]int) (int, error) {
    n := len(*a)
    if n < 1 {
        return -1, errors.New("heap underflow")
    }
    max := (*a)[0]
    (*a)[0] = (*a)[n - 1]
    *a = (*a)[:n - 1]
    maxHeapify(*a, 0, n - 2)
    return max, nil
}

func heapIncreaseKey(a []int, i, key int) error {
    if key < a[i] {
        return errors.New("new key is smaller than current key")
    }
    a[i] = key
    for i > 0 && a[parent(i)] < a[i] {
        a[i], a[parent(i)] = a[parent(i)], a[i]
        i = parent(i)
    }
    return nil
}

func maxHeapInsert(a *[]int, key int) {
    if len(*a) == 0 {
        *a = append(*a, key)
    } else {
        *a = append(*a, int(math.Min(float64((*a)[parent(len(*a))]), float64(key))))
        heapIncreaseKey(*a, len(*a) - 1, key)
    }
}

