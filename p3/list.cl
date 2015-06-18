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

(defstruct (element (:print-function print-element))
  prev
  key
  next)

(defstruct (dlist (:print-function print-dlist))
  head)

(defun print-element (element stream depth)
  (declare (ignore depth))
  (format stream "#<ELEMENT ~A>"(element-key element)))

(defun dlist->list (head)
  (if head
      (cons (element-key head) (dlist->list (element-next head)))
      nil))

(defun print-dlist (dlist stream depth)
  (declare (ignore depth))
  (format stream "#<DLIST ~A>" (dlist->list (dlist-head dlist))))

(defun list-search (l k)
  (let ((x (dlist-head l)))
    (do ()
        ((or (null x) (= (element-key x) k)) x)
      (setf x (element-next x)))))

(defun list-insert (l x)
  (setf (element-next x) (dlist-head l))
  (when (dlist-head l)
    (setf (element-prev (dlist-head l)) x))
  (setf (dlist-head l) x))

(defun list-delete (l x)
  (if (element-prev x)
      (setf (element-next (element-prev x)) (element-next x))
      (setf (dlist-head l) (element-next x)))
  (when (element-next x)
    (setf (element-prev (element-next x)) (element-prev x)))
  (setf (element-prev x) nil)
  (setf (element-next x) nil))

