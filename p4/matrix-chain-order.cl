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

(defun print-optimal-parens (s i j)
  (if (= i j)
      (format t "A~A" i)
      (progn
        (format t "(")
        (print-optimal-parens s i (aref s i j))
        (print-optimal-parens s (+ (aref s i j) 1) j)
        (format t ")"))))

(defun matrix-chain-order (p)
  (let* ((n (- (length p) 1))
         (m (make-array (list n n)))
         (s (make-array (list n n))))
    (dotimes (i n)
      (setf (aref m i i) 0))
    (do ((l 2 (+ l 1)))
        ((> l n) (print-optimal-parens s 0 (- n 1)))
      (dotimes (i (+ (- n l) 1))
        (let ((j (- (+ i l) 1)))
          (setf (aref m i j)
                (+ (aref m i i) (aref m (+ i 1) j)
                   (* (svref p i) (svref p (+ i 1)) (svref p (+ j 1)))))
          (setf (aref s i j) i)
          (do ((k (+ i 1) (+ k 1)))
              ((>= k j))
            (let ((q (+ (aref m i k) (aref m (+ k 1) j)
                        (* (svref p i) (svref p (+ k 1)) (svref p (+ j 1))))))
              (when (< q (aref m i j))
                (setf (aref m i j) q)
                (setf (aref s i j) k)))))))))

(defun recursive-matrix-chain (p i j)
  (let* ((n (- (length p) 1))
         (m (make-array (list n n))))
    (when (= i j)
      (return-from recursive-matrix-chain 0))
    (setf (aref m i j)
          (+ (recursive-matrix-chain p i i) (recursive-matrix-chain p (+ i 1) j)
             (* (svref p i) (svref p (+ i 1)) (svref p (+ j 1)))))
    (do ((k (+ i 1) (+ k 1)))
        ((>= k j) (aref m i j))
      (let ((q (+ (recursive-matrix-chain p i k)
                  (recursive-matrix-chain p (+ k 1) j)
                  (* (svref p i) (svref p (+ k 1)) (svref p (+ j 1))))))
        (when (< q (aref m i j))
          (setf (aref m i j) q))))))

(defun lookup-chain (p m i j)
  (when (aref m i j)
    (return-from lookup-chain (aref m i j)))
  (if (= i j)
      (setf (aref m i j) 0)
      (progn
        (setf (aref m i j)
              (+ (lookup-chain p m i i) (lookup-chain p m (+ i 1) j)
                 (* (svref p i) (svref p (+ i 1)) (svref p (+ j 1)))))
        (do ((k (+ i 1) (+ k 1)))
            ((>= k j))
          (let ((q (+ (lookup-chain p m i k) (lookup-chain p m (+ k 1) j)
                      (* (svref p i) (svref p (+ k 1)) (svref p (+ j 1))))))
            (when (< q (aref m i j))
              (setf (aref m i j) q))))))
  (aref m i j))

(defun memoized-matrix-chain (p)
  (let* ((n (- (length p) 1))
         (m (make-array (list n n))))
    (lookup-chain p m 0 (- n 1))))

