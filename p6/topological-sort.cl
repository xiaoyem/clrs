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

(defstruct (vertex (:print-function print-vertex))
  pi
  d
  f
  color
  alist)

(defvar *time* nil)
(defvar *list* nil)

(defun print-vertex (vertex stream depth)
  (declare (ignore depth))
  (format stream "#<VERTEX ~A/~A>" (vertex-d vertex) (vertex-f vertex)))

(defun dfs-visit (u)
  (setf (vertex-d u) (incf *time*))
  (setf (vertex-color u) #\G)
  (dolist (v (vertex-alist u))
    (when (char= (vertex-color v) #\W)
      (setf (vertex-pi v) u)
      (dfs-visit v)))
  (setf (vertex-f u) (incf *time*))
  (setf (vertex-color u) #\B)
  (push u *list*))

(defun topological-sort (g)
  (dolist (u g (setf *time* 0))
    (setf (vertex-color u) #\W))
  (setf *list* nil)
  (dolist (u g)
    (when (char= (vertex-color u) #\W)
      (dfs-visit u))))

