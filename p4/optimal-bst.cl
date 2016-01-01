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

(defun optimal-bst (p q n)
  (let ((w (make-array (list (+ n 1) (+ n 1))))
        (e (make-array (list (+ n 1) (+ n 1))))
        (r (make-array (list (+ n 1) (+ n 1)))))
    (dotimes (i (+ n 1))
      (setf (aref w i i) (svref q i))
      (setf (aref e i i) (svref q i)))
    (do ((l 1 (+ l 1)))
        ((> l n) (values e r))
      (dotimes (i (+ (- n l) 1))
        (let ((j (+ i l)))
          (setf (aref w i j)
                (+ (aref w i (- j 1)) (svref p (- j 1)) (svref q j)))
          (setf (aref e i j) (+ (aref e i i) (aref e (+ i 1) j) (aref w i j)))
          (setf (aref r i j) i)
          (do ((k (+ i 1) (+ k 1)))
              ((>= k j))
            (let ((q (+ (aref e i k) (aref e (+ k 1) j) (aref w i j))))
              (when (< q (aref e i j))
                (setf (aref e i j) q)
                (setf (aref r i j) k)))))))))

