#!/usr/bin/env python
# -*- coding:utf-8 -*-
#Author : ZhaoYuchao
#2016-04-07 18:54:43
#
#Copyright (c) 2005-2016 by Xiaoye Meng.
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

def insertion_sort(A) :
    for j  in range(1,len(A)) :
        key=A[j]
        i=j-1
        while(i>=0 and A[i]>key) :
            A[i+1]=A[i]
            i=i-1
        A[i+1]=key
    return A


    
    
