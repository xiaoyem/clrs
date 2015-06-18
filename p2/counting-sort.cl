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

(defun counting-sort (a b k)
  (let ((n (length a))
        (c (make-array (+ k 1) :initial-element 0)))
    (dotimes (i n)
      (incf (svref c (svref a i))))
    (do ((i 1 (+ i 1)))
        ((> i k))
      (setf (svref c i) (+ (svref c i) (svref c (- i 1)))))
    (do ((i (- n 1) (- i 1)))
        ((< i 0))
      (setf (svref b (- (svref c (svref a i)) 1)) (svref a i))
      (decf (svref c (svref a i))))))

