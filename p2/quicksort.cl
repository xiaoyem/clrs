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

(defun partition (a p r)
  (let ((i (- p 1)))
    (do ((j p (+ j 1)))
        ((>= j r) (rotatef (aref a (+ i 1)) (aref a r)))
      (when (<= (aref a j) (aref a r))
        (incf i)
        (rotatef (aref a i) (aref a j))))
    (+ i 1)))

(defun quicksort (a p r)
  (when (< p r)
    (let ((q (partition a p r)))
      (quicksort a p (- q 1))
      (quicksort a (+ q 1) r))))

(defun randomized-partition (a p r)
  (rotatef (aref a r) (aref a (+ (random (+ (- r p) 1)) p)))
  (partition a p r))

(defun randomized-quicksort (a p r)
  (when (< p r)
    (let ((q (randomized-partition a p r)))
      (randomized-quicksort a p (- q 1))
      (randomized-quicksort a (+ q 1) r))))

(defun hoare-partition (a p r)
  (let ((i p)
        (j r)
        (x (aref a p)))
    (do ()
        (nil)
      (do ()
          ((>= (aref a i) x))
        (incf i))
      (do ()
          ((<= (aref a j) x))
        (decf j))
      (if (< i j)
          (rotatef (aref a i) (aref a j))
          (return j)))))

