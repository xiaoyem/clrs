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
  parent
  rank)

(defun print-node (node stream depth)
  (declare (ignore depth))
  (format stream "#<NODE ~A>" (node-rank node)))

(defstruct (graph (:print-function print-graph))
  v
  e)

(defun print-graph (graph stream depth)
  (declare (ignore depth))
  (format stream "#<GRAPH ~A>" (graph-v graph)))

(defun make-set (x)
  (setf (node-parent x) x)
  (setf (node-rank x) 0))

(defun find-set (x)
  (when (not (eql x (node-parent x)))
    (setf (node-parent x) (find-set (node-parent x))))
  (node-parent x))

(defun link (x y)
  (if (> (node-rank x) (node-rank y))
      (setf (node-parent y) x)
      (progn
        (setf (node-parent x) y)
        (when (= (node-rank x) (node-rank y))
          (incf (node-rank y))))))

(defun union2 (x y)
  (link (find-set x) (find-set y)))

(defun connected-components (g)
  (dolist (v (graph-v g))
    (make-set v))
  (dolist (e (graph-e g))
    (when (not (eql (find-set (car e)) (find-set (cadr e))))
      (union2 (car e) (cadr e)))))

(defun same-component (u v)
  (if (eql (find-set u) (find-set v))
      t
      nil))

