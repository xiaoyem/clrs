;
; Copyright (c) 2005-2016 by Xiaoye Meng.
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

(defun merge2 (a p q r)
  (let* ((n1 (+ (- q p) 1))
         (n2 (- r q))
         (a1 (make-array n1))
         (a2 (make-array n2)))
    (dotimes (i n1)
      (setf (aref a1 i) (aref a (+ p i))))
    (dotimes (i n2)
      (setf (aref a2 i) (aref a (+ (+ q i) 1))))
    (let ((i 0)
          (j 0))
      (do ((k p (+ k 1)))
          ((> k r))
        (when (< i n1)
          (if (or (>= j n2) (<= (aref a1 i) (aref a2 j)))
              (progn
                (setf (aref a k) (aref a1 i))
                (incf i))
              (progn
                (setf (aref a k) (aref a2 j))
                (incf j))))))))

(defun merge-sort (a p r)
  (when (< p r)
    (let ((q (floor (/ (+ p r) 2))))
      (merge-sort a p q)
      (merge-sort a (+ q 1) r)
      (merge2 a p q r))))

; Loop invariant: at the start of each iteration of the for loop, the subarray
; a[p..k - 1] contains the k - p smallest elements of a1[0..n1 - 1] and
; a2[0..n2 - 1], in sorted order. Moreover, a1[i] and a2[j] are the smallest
; elements of their arrays that have not been copied back into a.

