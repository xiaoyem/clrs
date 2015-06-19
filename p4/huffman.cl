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

(defstruct (node (:print-function print-node))
  char
  freq
  left
  right)

(defun print-node (node stream depth)
  (declare (ignore depth))
  (format stream "#<NODE ~A:~A>" (node-char node) (node-freq node)))

(defmacro parent (i) `(floor (/ (- ,i 1) 2)))
(defmacro left   (i) `(+ (* ,i 2) 1))
(defmacro right  (i) `(+ (* ,i 2) 2))

(defun min-heapify (a i z)
  (let ((l (left i))
        (r (right i))
        (smallest i))
    (when (and (<= l z)
               (< (node-freq (aref a l)) (node-freq (aref a i))))
      (setf smallest l))
    (when (and (<= r z)
               (< (node-freq (aref a r)) (node-freq (aref a smallest))))
      (setf smallest r))
    (when (/= smallest i)
      (rotatef (aref a i) (aref a smallest))
      (min-heapify a smallest z))))

(defun build-min-heap (a)
  (let ((n (length a)))
    (do ((i (floor (- (/ n 2) 1)) (- i 1)))
        ((< i 0))
      (min-heapify a i (- n 1)))))

(defun heap-extract-min (a)
  (let ((n (length a)))
    (when (< n 1)
      (return-from heap-extract-min "heap underflow"))
    (let ((min (aref a 0)))
      (setf (aref a 0) (aref a (- n 1)))
      (vector-pop a)
      (min-heapify a 0 (- (length a) 1))
      min)))

(defun heap-decrease-key (a i key)
  (when (> key (node-freq (aref a i)))
    (return-from heap-decrease-key "new key is larger than current key"))
  (setf (node-freq (aref a i)) key)
  (do ()
      ((or (< i 1) (<= (node-freq (aref a (parent i))) (node-freq (aref a i)))))
    (rotatef (aref a i) (aref a (parent i)))
    (setf i (parent i))))

(defun min-heap-insert (a node)
  (let ((n (length a)))
    (if (= n 0)
        (vector-push-extend node a)
        (let ((key (node-freq node)))
          (vector-push-extend node a)
          (when (> (node-freq (aref a (parent n))) (node-freq node))
            (setf (node-freq node) (node-freq (aref a (parent n))))
            (heap-decrease-key a n key))))))

(defun huffman (c)
  (build-min-heap c)
  (let ((n (length c)))
    (do ((i 0 (+ i 1)))
        ((>= i (- n 1)) (heap-extract-min c))
      (let ((x (heap-extract-min c))
            (y (heap-extract-min c))
            (z (make-node)))
        (setf (node-freq z) (+ (node-freq x) (node-freq y)))
        (setf (node-left z) x)
        (setf (node-right z) y)
        (min-heap-insert c z)))))

