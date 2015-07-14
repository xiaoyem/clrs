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

(defun print-stations (l l* n)
  (let ((i l*))
    (format t "line ~A, station ~A~%" i n)
    (do ((j (- n 1) (- j 1)))
        ((< j 1))
      (setf i (aref l (- i 1) j))
      (format t "line ~A, station ~A~%" i j))))

(defun fastest-way (a tr e x n)
  (let ((f (make-array (list 2 n)))
        (f*)
        (l (make-array (list 2 n)))
        (l*))
    (setf (aref f 0 0) (+ (svref e 0) (aref a 0 0)))
    (setf (aref f 1 0) (+ (svref e 1) (aref a 1 0)))
    (do ((i 1 (+ i 1)))
        ((>= i n))
      (if (<= (+ (aref f 0 (- i 1)) (aref a 0 i))
              (+ (aref f 1 (- i 1)) (aref tr 1 (- i 1)) (aref a 0 i)))
          (progn
            (setf (aref f 0 i) (+ (aref f 0 (- i 1)) (aref a 0 i)))
            (setf (aref l 0 i) 1))
          (progn
            (setf (aref f 0 i)
                  (+ (aref f 1 (- i 1)) (aref tr 1 (- i 1)) (aref a 0 i)))
            (setf (aref l 0 i) 2)))
      (if (<= (+ (aref f 1 (- i 1)) (aref a 1 i))
              (+ (aref f 0 (- i 1)) (aref tr 0 (- i 1)) (aref a 1 i)))
          (progn
            (setf (aref f 1 i) (+ (aref f 1 (- i 1)) (aref a 1 i)))
            (setf (aref l 1 i) 2))
          (progn
            (setf (aref f 1 i)
                  (+ (aref f 0 (- i 1)) (aref tr 0 (- i 1)) (aref a 1 i)))
            (setf (aref l 1 i) 1))))
    (if (<= (+ (aref f 0 (- n 1)) (svref x 0))
            (+ (aref f 1 (- n 1)) (svref x 1)))
        (progn
          (setf f* (+ (aref f 0 (- n 1)) (svref x 0)))
          (setf l* 1))
        (progn
          (setf f* (+ (aref f 1 (- n 1)) (svref x 1)))
          (setf l* 2)))
    (print-stations l l* n)))

