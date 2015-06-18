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
        ((>= j r) (rotatef (svref a (+ i 1)) (svref a r)))
      (when (<= (svref a j) (svref a r))
        (incf i)
        (rotatef (svref a i) (svref a j))))
    (+ i 1)))

(defun quicksort (a p r)
  (when (< p r)
    (let ((q (partition a p r)))
      (quicksort a p (- q 1))
      (quicksort a (+ q 1) r))))

(defun randomized-partition (a p r)
  (rotatef (svref a r) (svref a (+ (random (+ (- r p) 1)) p)))
  (partition a p r))

(defun randomized-quicksort (a p r)
  (when (< p r)
    (let ((q (randomized-partition a p r)))
      (randomized-quicksort a p (- q 1))
      (randomized-quicksort a (+ q 1) r))))

(defun hoare-partition (a p r)
  (let ((i p)
        (j r)
        (x (svref a p)))
    (do ()
        (nil)
      (do ()
          ((>= (svref a i) x))
        (incf i))
      (do ()
          ((<= (svref a j) x))
        (decf j))
      (if (< i j)
          (rotatef (svref a i) (svref a j))
          (return j)))))

