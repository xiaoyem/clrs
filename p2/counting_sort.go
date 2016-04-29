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

func CountingSort(a []int, b []int, k int) {
    c := make([]int, k + 1) // value default 0
    for i := range a {
        c[a[i]]++
    }
    for i := 1; i <= k; i++ {
        c[i] += c[i - 1]
    }
    for i := len(a) - 1; i >= 0; i-- {
        b[c[a[i]] - 1] = a[i]
        c[a[i]]--
    }
}

