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
  key
  left
  right)

(defstruct (bst (:print-function print-bst))
  root)

(defun print-node (node stream depth)
  (declare (ignore depth))
  (format stream "#<NODE ~A>" (node-key node)))

(defun bst->list (root)
  (if root
      (append (list (node-key root))
              (bst->list (node-left root))
              (bst->list (node-right root)))
      nil))

(defun print-bst (bst stream depth)
  (declare (ignore depth))
  (format stream "#<BST ~A>" (bst->list (bst-root bst))))

(defun inorder-tree-walk (x)
  (when x
    (inorder-tree-walk (node-left x))
    (format t "~A~%" (node-key x))
    (inorder-tree-walk (node-right x))))

(defun tree-search (x k)
  (when (or (null x) (= k (node-key x)))
    (return-from tree-search x))
  (if (< k (node-key x))
      (tree-search (node-left x) k)
      (tree-search (node-right x) k)))

(defun iterative-tree-search (x k)
  (do ()
      ((or (null x) (= k (node-key x))) x)
    (if (< k (node-key x))
        (setf x (node-left x))
        (setf x (node-right x)))))

(defun tree-minimum (x)
  (do ()
      ((null (node-left x)) x)
    (setf x (node-left x))))

(defun tree-maximum (x)
  (do ()
      ((null (node-right x)) x)
    (setf x (node-right x))))

(defun tree-successor (x)
  (when (node-right x)
    (return-from tree-successor (tree-minimum (node-right x))))
  (let ((y (node-parent x)))
    (do ()
        ((or (null y) (not (eql x (node-right y)))) y)
      (setf x y)
      (setf y (node-parent y)))))

(defun tree-insert (b z)
  (let ((x (bst-root b))
        (y))
    (do ()
        ((null x) (setf (node-parent z) y))
      (setf y x)
      (if (< (node-key z) (node-key x))
          (setf x (node-left x))
          (setf x (node-right x))))
    (if (null y)
        (setf (bst-root b) z)
        (progn
          (if (< (node-key z) (node-key y))
              (setf (node-left y) z)
              (setf (node-right y) z))))))

(defun tree-delete (b z)
  (let ((x) (y))
    (if (or (null (node-left z)) (null (node-right z)))
        (setf y z)
        (setf y (tree-successor z)))
    (if (node-left y)
        (setf x (node-left y))
        (setf x (node-right y)))
    (when x
      (setf (node-parent x) (node-parent y)))
    (if (null (node-parent y))
        (setf (bst-root b) x)
        (if (eql y (node-left (node-parent y)))
            (setf (node-left (node-parent y)) x)
            (setf (node-right (node-parent y)) x)))
    (when (not (eql y z))
      (rotatef (node-key z) (node-key y)))
    (setf (node-parent y) nil)
    (setf (node-left y) nil)
    (setf (node-right y) nil)
    y))

