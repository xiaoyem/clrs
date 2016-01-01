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

(defmacro parent (i) `(floor (/ (- ,i 1) 2)))
(defmacro left   (i) `(+ (* ,i 2) 1))
(defmacro right  (i) `(+ (* ,i 2) 2))

(defun max-heapify (a i z)
  (let ((l (left i))
        (r (right i))
        (largest i))
    (when (and (<= l z) (> (aref a l) (aref a i)))
      (setf largest l))
    (when (and (<= r z) (> (aref a r) (aref a largest)))
      (setf largest r))
    (when (/= largest i)
      (rotatef (aref a i) (aref a largest))
      (max-heapify a largest z))))

(defun build-max-heap (a)
  (let ((n (length a)))
    (do ((i (floor (- (/ n 2) 1)) (- i 1)))
        ((< i 0))
      (max-heapify a i (- n 1)))))

(defun heapsort (a)
  (build-max-heap a)
  (do ((i (- (length a) 1) (- i 1)))
      ((< i 1))
    (rotatef (aref a 0) (aref a i))
    (max-heapify a 0 (- i 1))))

(defun heap-maximum (a) (aref a 0))

(defun heap-extract-max (a)
  (let ((n (length a)))
    (when (< n 1)
      (return-from heap-extract-max "heap underflow"))
    (let ((max (aref a 0)))
      (setf (aref a 0) (aref a (- n 1)))
      (vector-pop a)
      (max-heapify a 0 (- (length a) 1))
      max)))

(defun heap-increase-key (a i key)
  (when (< key (aref a i))
    (return-from heap-increase-key "new key is smaller than current key"))
  (setf (aref a i) key)
  (do ()
      ((or (< i 1) (>= (aref a (parent i)) (aref a i))))
    (rotatef (aref a i) (aref a (parent i)))
    (setf i (parent i))))

(defun max-heap-insert (a key)
  (let ((n (length a)))
    (if (= n 0)
        (vector-push-extend key a)
        (progn
          (vector-push-extend (min (aref a (parent n)) key) a)
          (heap-increase-key a n key)))))

