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

(defstruct (node (:print-function print-node))
  parent
  key
  degree
  child
  sibling)

(defstruct (binomial-heap (:print-function print-binomial-heap))
  head)

(defun print-node (node stream depth)
  (declare (ignore depth))
  (format stream "#<NODE ~A(~A)>" (node-key node) (node-degree node)))

(defun binomial-heap->list (head)
  (if head
      (append (list (format nil "~A(~A)" (node-key head) (node-degree head)))
              (binomial-heap->list (node-child head))
              (binomial-heap->list (node-sibling head)))
      nil))

(defun print-binomial-heap (binomial-heap stream depth)
  (declare (ignore depth))
  (format stream "#<BINOMIAL-HEAP ~A>"
          (binomial-heap->list (binomial-heap-head binomial-heap))))

(defun binomial-heap-minimum (h)
  (let* ((x (binomial-heap-head h))
         (y x)
         (min (node-key x)))
    (setf x (node-sibling x))
    (do ()
        ((null x) y)
      (when (< (node-key x) min)
        (setf min (node-key x))
        (setf y x))
      (setf x (node-sibling x)))))

(defun binomial-heap-merge (h1 h2)
  (let ((x (binomial-heap-head h1))
        (y (binomial-heap-head h2))
        (z)
        (head))
    (when (null x)
      (return-from binomial-heap-merge y))
    (when (null y)
      (return-from binomial-heap-merge x))
    (if (< (node-degree x) (node-degree y))
        (progn
          (setf head (setf z x))
          (setf x (node-sibling x)))
        (progn
          (setf head (setf z y))
          (setf y (node-sibling y))))
    (do ()
        ((or (null x) (null y)))
      (if (< (node-degree x) (node-degree y))
          (progn
            (setf (node-sibling z) x)
            (setf z (node-sibling z))
            (setf x (node-sibling x)))
          (progn
            (setf (node-sibling z) y)
            (setf z (node-sibling z))
            (setf y (node-sibling y)))))
    (when x
      (setf (node-sibling z) x))
    (when y
      (setf (node-sibling z) y))
    head))

(defun binomial-link (y z)
  (setf (node-parent y) z)
  (setf (node-sibling y) (node-child z))
  (setf (node-child z) y)
  (incf (node-degree z)))

(defun binomial-heap-union (h1 h2)
  (let ((h (make-binomial-heap)))
    (setf (binomial-heap-head h) (binomial-heap-merge h1 h2))
    (setf (binomial-heap-head h1) nil)
    (setf (binomial-heap-head h2) nil)
    (when (null (binomial-heap-head h))
      (return-from binomial-heap-union nil))
    (let* ((prev)
           (x (binomial-heap-head h))
           (next (node-sibling x)))
      (do ()
          ((null next) (binomial-heap-head h))
        (if (or (/= (node-degree x) (node-degree next))
                (and (node-sibling next)
                     (= (node-degree (node-sibling next)) (node-degree x))))
            (progn
              (setf prev x)
              (setf x next))
            (if (<= (node-key x) (node-key next))
                (progn
                  (setf (node-sibling x) (node-sibling next))
                  (binomial-link next x))
                (progn
                  (if (null prev)
                      (setf (binomial-heap-head h) next)
                      (setf (node-sibling prev) next))
                  (binomial-link x next)
                  (setf x next))))
        (setf next (node-sibling x))))))

(defun binomial-heap-insert (h x)
  (let ((h2 (make-binomial-heap)))
    (setf (node-parent x) nil)
    (setf (node-degree x) 0)
    (setf (node-child x) nil)
    (setf (node-sibling x) nil)
    (setf (binomial-heap-head h2) x)
    (setf (binomial-heap-head h) (binomial-heap-union h h2))))

(defun binomial-heap-extract-min (h)
  (when (null (binomial-heap-head h))
    (return-from binomial-heap-extract-min nil))
  (let ((x (binomial-heap-minimum h))
        (y (binomial-heap-head h)))
    (if (eql y x)
        (setf (binomial-heap-head h) (node-sibling x))
        (do ()
            ((eql (node-sibling y) x) (setf (node-sibling y) (node-sibling x)))
          (setf y (node-sibling y))))
    (setf (node-sibling x) nil)
    (let ((h2 (make-binomial-heap))
          (p (node-child x)))
      (when p
        (do ((q (node-sibling p) (node-sibling p)))
            ((null q) (setf (binomial-heap-head h2) (node-child x)))
          (setf (node-sibling p) (node-sibling q))
          (setf (node-sibling q) (node-child x))
          (setf (node-child x) q))
        (setf p (node-child x))
        (do ()
            ((null p) (setf (node-child x) nil))
          (setf (node-parent p) nil)
          (setf p (node-sibling p))))
      (setf (binomial-heap-head h) (binomial-heap-union h h2))
      x)))

(defun binomial-heap-decrease-key (h x k)
  (when (> k (node-key x))
    (return-from binomial-heap-decrease-key
                 "new key is greater than current key"))
  (setf (node-key x) k)
  (let* ((y x)
         (z (node-parent y)))
    (do ()
        ((or (null z) (>= (node-key y) (node-key z))))
      (rotatef (node-key y) (node-key z))
      (setf y z)
      (setf z (node-parent y)))))

(defun binomial-heap-delete (h x)
  (let ((k (- (node-key (binomial-heap-minimum h)) 1)))
    (binomial-heap-decrease-key h x k)
    (binomial-heap-extract-min h)))

