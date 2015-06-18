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
  color
  left
  right)

(defparameter *dummy* (make-node :color #\B))

(defstruct (rbt (:print-function print-rbt))
  (root *dummy*))

(defun print-node (node stream depth)
  (declare (ignore depth))
  (format stream "#<NODE ~A(~A)>" (node-key node) (node-color node)))

(defun rbt->list (root)
  (if (not (eql root *dummy*))
      (append (list (format nil "~A(~A)" (node-key root) (node-color root)))
              (rbt->list (node-left root))
              (rbt->list (node-right root)))
      (node-key *dummy*)))

(defun print-rbt (rbt stream depth)
  (declare (ignore depth))
  (format stream "#<RBT ~A>" (rbt->list (rbt-root rbt))))

(defun tree-minimum (x)
  (do ()
      ((eql (node-left x) *dummy*) x)
    (setf x (node-left x))))

(defun tree-successor (x)
  (when (not (eql (node-right x) *dummy*))
    (return-from tree-successor (tree-minimum (node-right x))))
  (let ((y (node-parent x)))
    (do ()
        ((or (eql y *dummy*) (not (eql x (node-right y)))) y)
      (setf x y)
      (setf y (node-parent y)))))

(defun left-rotate (r x)
  (let ((y (node-right x)))
    (setf (node-right x) (node-left y))
    (when (not (eql (node-left y) *dummy*))
      (setf (node-parent (node-left y)) x))
    (setf (node-parent y) (node-parent x))
    (if (eql (node-parent x) *dummy*)
        (setf (rbt-root r) y)
        (if (eql x (node-left (node-parent x)))
            (setf (node-left (node-parent x)) y)
            (setf (node-right (node-parent x)) y)))
    (setf (node-left y) x)
    (setf (node-parent x) y)))

(defun right-rotate (r y)
  (let ((x (node-left y)))
    (setf (node-left y) (node-right x))
    (when (not (eql (node-right x) *dummy*))
      (setf (node-parent (node-right x)) y))
    (setf (node-parent x) (node-parent y))
    (if (eql (node-parent y) *dummy*)
        (setf (rbt-root r) x)
        (if (eql y (node-left (node-parent y)))
            (setf (node-left (node-parent y)) x)
            (setf (node-right (node-parent y)) x)))
    (setf (node-right x) y)
    (setf (node-parent y) x)))

(defun rb-insert-fixup (r z)
  (do ()
      ((not (char= (node-color (node-parent z)) #\R)))
    (if (eql (node-parent z) (node-left (node-parent (node-parent z))))
        (let ((y (node-right (node-parent (node-parent z)))))
          (if (char= (node-color y) #\R)
              (progn
                (setf (node-color (node-parent z)) #\B)
                (setf (node-color y) #\B)
                (setf (node-color (node-parent (node-parent z))) #\R)
                (setf z (node-parent (node-parent z))))
              (progn
                (when (eql z (node-right (node-parent z)))
                  (setf z (node-parent z))
                  (left-rotate r z))
                (setf (node-color (node-parent z)) #\B)
                (setf (node-color (node-parent (node-parent z))) #\R)
                (right-rotate r (node-parent (node-parent z))))))
        (let ((y (node-left (node-parent (node-parent z)))))
          (if (char= (node-color y) #\R)
              (progn
                (setf (node-color (node-parent z)) #\B)
                (setf (node-color y) #\B)
                (setf (node-color (node-parent (node-parent z))) #\R)
                (setf z (node-parent (node-parent z))))
              (progn
                (when (eql z (node-left (node-parent z)))
                  (setf z (node-parent z))
                  (right-rotate r z))
                (setf (node-color (node-parent z)) #\B)
                (setf (node-color (node-parent (node-parent z))) #\R)
                (left-rotate r (node-parent (node-parent z))))))))
  (setf (node-color (rbt-root r)) #\B))

(defun rb-insert (r z)
  (let ((x (rbt-root r))
        (y *dummy*))
    (do ()
        ((eql x *dummy*) (setf (node-parent z) y))
      (setf y x)
      (if (< (node-key z) (node-key x))
          (setf x (node-left x))
          (setf x (node-right x))))
    (if (eql y *dummy*)
        (setf (rbt-root r) z)
        (if (< (node-key z) (node-key y))
            (setf (node-left y) z)
            (setf (node-right y) z)))
    (setf (node-left z) *dummy*)
    (setf (node-right z) *dummy*)
    (setf (node-color z) #\R)
    (rb-insert-fixup r z)))

(defun rb-delete-fixup (r x)
  (do ()
      ((or (eql x (rbt-root r)) (not (char= (node-color x) #\B))))
    (if (eql x (node-left (node-parent x)))
        (let ((w (node-right (node-parent x))))
          (when (char= (node-color w) #\R)
            (setf (node-color w) #\B)
            (setf (node-color (node-parent x)) #\R)
            (left-rotate r (node-parent x))
            (setf w (node-right (node-parent x))))
          (if (and (char= (node-color (node-left w)) #\B)
                   (char= (node-color (node-right w)) #\B))
              (progn
                (setf (node-color w) #\R)
                (setf x (node-parent x)))
              (progn
                (when (char= (node-color (node-right w)) #\B)
                  (setf (node-color (node-left w)) #\B)
                  (setf (node-color w) #\R)
                  (right-rotate r w)
                  (setf w (node-right (node-parent x))))
                (setf (node-color w) (node-color (node-parent x)))
                (setf (node-color (node-parent x)) #\B)
                (setf (node-color (node-right w)) #\B)
                (left-rotate r (node-parent x))
                (setf x (rbt-root r)))))
        (let ((w (node-left (node-parent x))))
          (when (char= (node-color w) #\R)
            (setf (node-color w) #\B)
            (setf (node-color (node-parent x)) #\R)
            (right-rotate r (node-parent x))
            (setf w (node-left (node-parent x))))
          (if (and (char= (node-color (node-left w)) #\B)
                   (char= (node-color (node-right w)) #\B))
              (progn
                (setf (node-color w) #\R)
                (setf x (node-parent x)))
              (progn
                (when (char= (node-color (node-left w)) #\B)
                  (setf (node-color (node-right w)) #\B)
                  (setf (node-color w) #\R)
                  (left-rotate r w)
                  (setf w (node-left (node-parent x))))
                (setf (node-color w) (node-color (node-parent x)))
                (setf (node-color (node-parent x)) #\B)
                (setf (node-color (node-left w)) #\B)
                (right-rotate r (node-parent x))
                (setf x (rbt-root r)))))))
  (setf (node-color x) #\B))

(defun rb-delete (r z)
  (let ((x) (y))
    (if (or (eql (node-left z) *dummy*) (eql (node-right z) *dummy*))
        (setf y z)
        (setf y (tree-successor z)))
    (if (not (eql (node-left y) *dummy*))
        (setf x (node-left y))
        (setf x (node-right y)))
    (setf (node-parent x) (node-parent y))
    (if (eql (node-parent y) *dummy*)
        (setf (rbt-root r) x)
        (if (eql y (node-left (node-parent y)))
            (setf (node-left (node-parent y)) x)
            (setf (node-right (node-parent y)) x)))
    (when (not (eql y z))
      (rotatef (node-key z) (node-key y)))
    (when (char= (node-color y) #\B)
      (rb-delete-fixup r x))
    (setf (node-parent y) nil)
    (setf (node-left y) nil)
    (setf (node-right y) nil)
    y))

