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

(load "p1/find-maximum-subarray.cl")

(let ((a #(13 -3 -25 20 -3 -16 -23 18 20 -7 12 -5 -22 15 -4 7)))
  (format t "~A~%" (multiple-value-bind (left right sum)
                                        (find-maximum-subarray a 0 (- (length a) 1))
                                        (vector left right sum))))

