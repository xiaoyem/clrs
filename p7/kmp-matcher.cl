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

(defun compute-prefix-function (p)
  (let* ((n (length p))
         (pi (make-array n))
         (k -1))
    (setf (svref pi 0) -1)
    (do ((q 1 (+ q 1)))
        ((>= q n) pi)
      (do ()
          ((or (<= k -1) (char= (char p (+ k 1)) (char p q))))
        (setf k (svref pi k)))
      (when (char= (char p (+ k 1)) (char p q))
        (incf k))
      (setf (svref pi q) k))))

(defun kmp-matcher (tx p)
  (let ((m (length tx))
        (n (length p))
        (q -1)
        (pi (compute-prefix-function p)))
    (dotimes (i m)
      (do ()
          ((or (<= q -1) (char= (char p (+ q 1)) (char tx i))))
        (setf q (svref pi q)))
      (when (char= (char p (+ q 1)) (char tx i))
        (incf q))
      (when (= q (- n 1))
        (format t "Pattern occurs with shift ~A~%" (+ (- i n) 1))
        (setf q (svref pi q))))))

