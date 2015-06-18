;
; Copyright (c) 2005-2015 by Xiaoye Meng.
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;

(defun insertion-sort (a)
  (let ((n (length a)))
    (do ((i 1 (+ i 1)))
        ((>= i n))
      (let ((j (- i 1))
            (key (svref a i)))
        (do ()
            ((or (< j 0) (<= (svref a j) key)) (setf (svref a (+ j 1)) key))
          (setf (svref a (+ j 1)) (svref a j))
          (decf j))))))

; Loop invariant: at the start of each iteration of the for loop, the subarray
; a[1..i - 1] consists of the elements originally in a[1..i - 1], but in sorted
; order.

