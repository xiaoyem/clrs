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

(defun print-lcs (b x i j)
  (when (or (= i 0) (= j 0))
    (return-from print-lcs))
  (if (= (aref b i j) 7)
      (progn
        (print-lcs b x (- i 1) (- j 1))
        (format t "~A" (svref x (- i 1))))
      (if (= (aref b i j) 0)
          (print-lcs b x (- i 1) j)
          (print-lcs b x i (- j 1)))))

(defun lcs-length (x y)
  (let* ((m (length x))
         (n (length y))
         (a (make-array (list (+ m 1) (+ n 1))))
         (b (make-array (list (+ m 1) (+ n 1)))))
    (dotimes (i (+ m 1))
      (setf (aref a i 0) 0))
    (do ((i 1 (+ i 1)))
        ((> i n))
      (setf (aref a 0 i) 0))
    (do ((i 1 (+ i 1)))
        ((> i m) (print-lcs b x m n))
      (do ((j 1 (+ j 1)))
          ((> j n))
        (if (eql (svref x (- i 1)) (svref y (- j 1)))
            (progn
              (setf (aref a i j) (+ (aref a (- i 1) (- j 1)) 1))
              (setf (aref b i j) 7))
            (if (>= (aref a (- i 1) j) (aref a i (- j 1)))
                (progn
                  (setf (aref a i j) (aref a (- i 1) j))
                  (setf (aref b i j) 0))
                (progn
                  (setf (aref a i j) (aref a i (- j 1)))
                  (setf (aref b i j) 6))))))))

