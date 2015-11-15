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

(defun find-max-crossing-subarray (a low mid high)
  (let ((left-sum (aref a mid))
        (max-left mid)
        (right-sum (aref a (+ mid 1)))
        (max-right (+ mid 1))
        (sum 0))
    (do ((i mid (- i 1)))
        ((< i low))
      (setf sum (+ sum (aref a i)))
      (when (> sum left-sum)
        (setf left-sum sum)
        (setf max-left i)))
    (setf sum 0)
    (do ((j (+ mid 1) (+ j 1)))
        ((> j high))
      (setf sum (+ sum (aref a j)))
      (when (> sum right-sum)
        (setf right-sum sum)
        (setf max-right j)))
    (values max-left max-right (+ left-sum right-sum))))

(defun find-maximum-subarray (a low high)
  (if (= low high)
    (return-from find-maximum-subarray (values low high (aref a low)))
    (let ((mid (floor (/ (+ low high) 2)))
          (left-low) (left-high) (left-sum)
          (right-low) (right-high) (right-sum)
          (cross-low) (cross-high) (cross-sum))
      (setf (values left-low left-high left-sum)    (find-maximum-subarray a low mid))
      (setf (values right-low right-high right-sum) (find-maximum-subarray a (+ mid 1) high))
      (setf (values cross-low cross-high cross-sum) (find-max-crossing-subarray a low mid high))
      (if (and (>= left-sum right-sum) (>= left-sum cross-sum))
        (return-from find-maximum-subarray (values left-low left-high left-sum))
        (if (and (>= right-sum left-sum) (>= right-sum cross-sum))
          (return-from find-maximum-subarray (values right-low right-high right-sum))
          (return-from find-maximum-subarray (values cross-low cross-high cross-sum)))))))

