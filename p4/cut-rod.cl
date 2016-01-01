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

(defun print-cut-rod-solution (s n)
  (do ()
      ((<= n 0))
    (format t "~A~%" (aref s n))
    (setf n (- n (aref s n)))))

(defun extended-bottom-up-cut-rod (p n)
  (let ((r (make-array (+ n 1)))
        (s (make-array (+ n 1))))
    (setf (aref r 0) 0)
    (do ((i 1 (+ i 1)))
        ((> i n) (print-cut-rod-solution s n))
      (let ((q 0))
        (do ((j 1 (+ j 1)))
            ((> j i) (setf (aref r i) q))
          (when (< q (+ (aref p (- j 1)) (aref r (- i j))))
            (setf q (+ (aref p (- j 1)) (aref r (- i j))))
            (setf (aref s i) j)))))))

