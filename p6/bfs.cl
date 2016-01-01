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

(defstruct (vertex (:print-function print-vertex))
  pi
  d
  color
  alist)

(defun print-vertex (vertex stream depth)
  (declare (ignore depth))
  (format stream "#<VERTEX ~A>" (vertex-d vertex)))

(defun make-queue ()
  (cons nil nil))

(defun enqueue (x q)
  (if (null (car q))
      (setf (cdr q) (setf (car q) (list x)))
      (progn
        (setf (cdr (cdr q)) (list x))
        (setf (cdr q) (cdr (cdr q)))))
  (car q))

(defun dequeue (q)
  (pop (car q)))

(defun bfs (g s)
  (dolist (u g)
    (setf (vertex-color u) #\W))
  (setf (vertex-d s) 0)
  (setf (vertex-color s) #\G)
  (let ((q (make-queue)))
    (enqueue s q)
    (do ()
        ((null (car q)))
      (let ((u (dequeue q)))
        (dolist (v (vertex-alist u) (setf (vertex-color u) #\B))
          (when (char= (vertex-color v) #\W)
            (setf (vertex-pi v) u)
            (setf (vertex-d v) (+ (vertex-d u) 1))
            (setf (vertex-color v) #\G)
            (enqueue v q)))))))

(defun print-path (g s v)
  (if (eql v s)
      (format t "~A~%" s)
      (if (null (vertex-pi v))
          (format t "no path from ~A to ~A exists~%" s v)
          (progn
            (print-path g s (vertex-pi v))
            (format t "~A~%" v)))))

