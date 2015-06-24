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

(defun to-string (x) (format nil "~A" x))

(defun radix-sort (a d)
  (let ((h (make-hash-table)))
    (do ((i (- d 1) (- i 1)))
        ((< i 0))
      (dotimes (j (length a))
        (setf (gethash (aref a j) h)
              (digit-char-p (char (to-string (aref a j)) i))))
      (stable-sort a #'(lambda (x y) (< (gethash x h) (gethash y h)))))))

