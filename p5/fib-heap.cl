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
  degree
  mark
  child
  left
  right)

(defstruct (fib-heap (:print-function print-fib-heap))
  min
  (n 0))

(defun print-node (node stream depth)
  (declare (ignore depth))
  (format stream "#<NODE ~A(~A)>" (node-key node) (node-degree node)))

(defun fib-heap->list (node head)
  (if node
      (append (list (format nil "~A(~A)" (node-key node) (node-degree node)))
              (let ((child (node-child node)))
                (if child
                    (fib-heap->list child child)
                    nil))
              (let ((right (node-right node)))
                (if (not (eql right head))
                    (fib-heap->list right head)
                    nil)))
      nil))

(defun print-fib-heap (fib-heap stream depth)
  (declare (ignore depth))
  (let ((min (fib-heap-min fib-heap)))
    (format stream "#<FIB-HEAP ~A>" (fib-heap->list min min))))

(defun fib-heap-insert (h x)
  (setf (node-parent x) nil)
  (setf (node-degree x) 0)
  (setf (node-mark x) nil)
  (setf (node-child x) nil)
  (let ((min (fib-heap-min h)))
    (if (null min)
        (progn
          (setf (node-left x) x)
          (setf (node-right x) x)
          (setf (fib-heap-min h) x))
        (let ((left (node-left min)))
          (setf (node-left min) x)
          (setf (node-right x) min)
          (setf (node-left x) left)
          (setf (node-right left) x)
          (when (< (node-key x) (node-key min))
            (setf (fib-heap-min h) x)))))
  (incf (fib-heap-n h)))

(defun fib-heap-union (h1 h2)
  (let ((h (make-fib-heap)))
    (setf (fib-heap-min h) (fib-heap-min h1))
    (let ((min (fib-heap-min h))
          (min2 (fib-heap-min h2)))
      (if (null min)
          (setf (fib-heap-min h) min2)
          (when min2
            (let ((left (node-left min))
                  (left2 (node-left min2)))
              (setf (node-left min) left2)
              (setf (node-right left2) min)
              (setf (node-left min2) left)
              (setf (node-right left) min2)
              (when (< (node-key min2) (node-key min))
                (setf (fib-heap-min h) min2))))))
    (setf (fib-heap-n h) (+ (fib-heap-n h1) (fib-heap-n h2)))
    (setf (fib-heap-min h1) nil)
    (setf (fib-heap-min h2) nil)
    (setf (fib-heap-n h1) 0)
    (setf (fib-heap-n h2) 0)
    (fib-heap-min h)))

(defun fib-heap-link (h y x)
  (let ((left (node-left y))
        (right (node-right y)))
    (setf (node-left right) left)
    (setf (node-right left) right))
  (let ((child (node-child x)))
    (if (null child)
        (progn
          (setf (node-left y) y)
          (setf (node-right y) y)
          (setf (node-child x) y))
        (let ((left (node-left child)))
          (setf (node-left child) y)
          (setf (node-right y) child)
          (setf (node-left y) left)
          (setf (node-right left) y))))
  (setf (node-parent y) x)
  (setf (node-mark y) nil)
  (incf (node-degree x)))

(defun consolidate (h)
  (let* ((next (fib-heap-min h))
         (s (node-left next))
         (a (make-hash-table)))
    (loop
      (let* ((w next)
             (x w)
             (d (node-degree x)))
        (setf next (node-right w))
        (do ()
            ((null (gethash d a)) (setf (gethash d a) x))
          (let ((y (gethash d a)))
            (when (> (node-key x) (node-key y))
              (rotatef x y))
            (fib-heap-link h y x))
          (setf (gethash d a) nil)
          (incf d))
        (when (eql w s)
          (return))))
    (setf (fib-heap-min h) nil)
    (with-hash-table-iterator (it a)
      (loop
        (multiple-value-bind (entry-p k v) (it)
          (if entry-p
              (when v
                (let ((min (fib-heap-min h)))
                  (if (null min)
                      (progn
                        (setf (node-left v) v)
                        (setf (node-right v) v)
                        (setf (fib-heap-min h) v))
                      (let ((left (node-left min)))
                        (setf (node-left min) v)
                        (setf (node-right v) min)
                        (setf (node-left v) left)
                        (setf (node-right left) v)
                        (when (< (node-key v) (node-key min))
                          (setf (fib-heap-min h) v))))))
              (return)))))))

(defun fib-heap-extract-min (h)
  (let ((z (fib-heap-min h)))
    (when z
      (let ((child (node-child z)))
        (when child
          (setf (node-parent child) nil)
          (do ((x (node-right child) (node-right x)))
              ((eql x child))
            (setf (node-parent x) nil))
          (setf (node-child z) nil)
          (let ((left (node-left z))
                (left2 (node-left child)))
            (setf (node-left z) left2)
            (setf (node-right left2) z)
            (setf (node-left child) left)
            (setf (node-right left) child))))
      (let ((left (node-left z))
            (right (node-right z)))
        (setf (node-left right) left)
        (setf (node-right left) right)
        (if (eql z right)
            (setf (fib-heap-min h) nil)
            (progn
              (setf (fib-heap-min h) right)
              (consolidate h))))
      (decf (fib-heap-n h))
      (setf (node-left z) nil)
      (setf (node-right z) nil))
    z))

(defun cut (h x y)
  (let ((left (node-left x))
        (right (node-right x)))
    (setf (node-left right) left)
    (setf (node-right left) right))
  (setf (node-parent x) nil)
  (setf (node-mark x) nil)
  (decf (node-degree y))
  (if (= (node-degree y) 0)
      (setf (node-child y) nil)
      (when (eql (node-child y) x)
        (setf (node-child y) (node-right x))))
  (let ((min (fib-heap-min h)))
    (if (null min)
        (progn
          (setf (node-left x) x)
          (setf (node-right x) x)
          (setf (fib-heap-min h) x))
        (let ((left (node-left min)))
          (setf (node-left min) x)
          (setf (node-right x) min)
          (setf (node-left x) left)
          (setf (node-right left) x)))))

(defun cascading-cut (h y)
  (let ((z (node-parent y)))
    (when z
      (if (null (node-mark y))
          (setf (node-mark y) t)
          (progn
            (cut h y z)
            (cascading-cut h z))))))

(defun fib-heap-decrease-key (h x k)
  (when (> k (node-key x))
    (return-from fib-heap-decrease-key "new key is greater than current key"))
  (setf (node-key x) k)
  (let ((y (node-parent x)))
    (when (and y (< (node-key x) (node-key y)))
      (cut h x y)
      (cascading-cut h y))
    (when (< (node-key x) (node-key (fib-heap-min h)))
      (setf (fib-heap-min h) x))))

(defun fib-heap-delete (h x)
  (let ((k (- (node-key (fib-heap-min h)) 1)))
    (fib-heap-decrease-key h x k)
    (fib-heap-extract-min h)))

