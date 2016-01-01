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

(load "p4/greedy-activity-selector.cl")

(let ((s (make-array 12 :initial-contents '(0 1 3 0 5 3 5 6 8 8 2 12)))
      (f (make-array 12 :initial-contents '(0 4 5 6 7 9 9 10 11 12 14 16))))
  (format t "~A~%" (greedy-activity-selector s f)))

