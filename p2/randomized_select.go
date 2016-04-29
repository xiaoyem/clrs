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

func RandomizedSelect(a []int, p, r, i int) int {
    if p == r {
        return a[p]
    }
    q := RandomizedPartition(a, p, r)
    k := q - p + 1
    if i == k {
        return a[q]
    } else if i < k {
        return RandomizedSelect(a, p, q - 1, i)
    } else {
        return RandomizedSelect(a, q + 1, r, i - k)
    }
}

