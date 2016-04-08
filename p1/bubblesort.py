#!/usr/bin/env python
# -*- coding:utf-8 -*-
#Author : ZhaoYuchao
#2016-04-08 16:23:16
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
def bubblesort(A):
    for i in range(0,len(A)):
        for j in range(len(A)-1,i,-1):
            if(A[j]<A[j-1]):
                A[j],A[j-1]=A[j-1],A[j]
    return A

print bubblesort([9,3,1,0,1,6,3,8,4,5])

