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
      (let ((key (aref a i))
            (j (- i 1)))
        (do ()
            ((or (< j 0) (<= (aref a j) key)) (setf (aref a (+ j 1)) key))
          (setf (aref a (+ j 1)) (aref a j))
          (decf j))))))

(defun bucket-sort (a)
  (let* ((n (length a))
         (b (make-array n)))
    (dotimes (i n)
      (setf (svref b i)
            (make-array 0 :adjustable t :fill-pointer t :initial-contents '())))
    (dotimes (i n)
      (vector-push-extend (svref a i)
                          (svref b (floor (* (svref a i) n)))))
    (dotimes (i n)
      (insertion-sort (svref b i)))
    (let ((c))
      (dotimes (i n)
        (setf c (concatenate 'vector c (svref b i))))
      (dotimes (i n)
        (setf (svref a i) (svref c i))))))

