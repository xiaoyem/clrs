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

(load "p4/fastest-way.cl")

(let ((a  (make-array (list 2 6) :initial-contents '((7 9 3 4 8 4) (8 5 6 4 5 7))))
      (t* (make-array (list 2 5) :initial-contents '((2 3 1 3 4) (2 1 2 2 1))))
      (e  (make-array 2 :initial-contents '(2 4)))
      (x  (make-array 2 :initial-contents '(3 2))))
  (fastest-way a t* e x 6))

