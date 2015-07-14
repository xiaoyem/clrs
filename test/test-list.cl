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

(load "p3/list.cl")

(let ((l (make-dlist))
      (a (make-element :key 1))
      (b (make-element :key 4))
      (c (make-element :key 16))
      (d (make-element :key 9))
      (e (make-element :key 25)))
  (list-insert l a)
  (list-insert l b)
  (list-insert l c)
  (list-insert l d)
  (format t "~A~%" l)
  (list-insert l e)
  (format t "~A~%" l)
  (list-delete l b)
  (format t "~A~%" l))

