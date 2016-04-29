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

type BucketArray [][]float64

func Bucket_sort(a *[]float64) {
    n := len(*a)
    B := make(BucketArray, n)
    for i := range *a {
        B[int(float64(n) * (*a)[i])] = append(B[int(float64(n) * (*a)[i])], (*a)[i])
    }
    for i := range B {
        insertionSort(B[i])
    }
    *a = nil
    for i := range B {
        if len(B[i]) > 0 {
            *a = append(*a, B[i]...)
        }
    }
}

func insertionSort(a []float64) {
    n := len(a)
    for i := 1; i < n; i++ {
        j, key := i - 1, a[i]
        for j >= 0 && a[j] > key {
            a[j + 1] = a[j]
            j--
        }
        a[j + 1] = key
    }
}

