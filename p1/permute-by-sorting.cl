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

(defun permute-by-sorting (a)
  (let* ((n (length a))
         (b (make-array n))
         (h (make-hash-table)))
    (dotimes (i n)
      (let ((p (+ (random (expt n 3) (make-random-state t)) 1)))
        (do ()
            ((null (gethash p h)) (setf (gethash p h) t))
          (setf p (+ (random (expt n 3) (make-random-state t)) 1)))
        (setf (aref b i) (cons p (aref a i)))))
    (sort b #'(lambda (x y) (< (car x) (car y))))
    (dotimes (i n)
      (setf (aref b i) (cdr (aref b i))))
    b))

