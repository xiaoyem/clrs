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

func Bubblesort(a []int) {
    n := len(a)
    for i := 0; i < n - 1; i++ {
        for j := n - 1; j > i; j-- {
            if a[j] < a[j - 1] {
                a[j], a[j - 1] = a[j - 1], a[j]
            }
        }
    }
}

