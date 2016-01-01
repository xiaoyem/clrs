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

(load "p1/insertion-sort.cl")

(defun bucket-sort (a)
  (let* ((n (length a))
         (b (make-array n)))
    (dotimes (i n)
      (setf (aref b i)
            (make-array 0 :adjustable t :fill-pointer t :initial-contents '())))
    (dotimes (i n)
      (vector-push-extend (aref a i)
                          (aref b (floor (* (aref a i) n)))))
    (dotimes (i n)
      (insertion-sort (aref b i)))
    (let ((c))
      (dotimes (i n)
        (setf c (concatenate 'vector c (aref b i))))
      (dotimes (i n)
        (setf (aref a i) (aref c i))))))

