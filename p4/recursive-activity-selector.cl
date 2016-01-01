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

(defun recursive-activity-selector (s f i j)
  (let ((m (+ i 1)))
    (do ()
        ((or (> m j) (>= (svref s m) (svref f i))))
      (incf m))
    (if (<= m j)
        (cons (format nil "a~A" m) (recursive-activity-selector s f m j))
        nil)))

