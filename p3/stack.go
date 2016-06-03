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

package p3

import "errors"

func StackEmpty(a []int) bool {
    if len(a) == 0 {
        return true
    } else {
        return false
    }
}

func Push(a *[]int, n int) {
    *a = append(*a, n)
}

func Pop(a *[]int) (int, error) {
    n := len(*a)
    if n < 1 {
        return -1, errors.New("underflow")
    }
    top := (*a)[n - 1]
    *a = (*a)[:n - 1]
    return top, nil
}

