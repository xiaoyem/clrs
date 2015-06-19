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

(defun greedy-activity-selector (s f)
  (let ((n (length s))
        (i 0)
        (a '("a0")))
    (do ((m 1 (+ m 1)))
        ((>= m n) (nreverse a))
      (when (>= (svref s m) (svref f i))
        (push (format nil "a~A" m) a)
        (setf i m)))))

