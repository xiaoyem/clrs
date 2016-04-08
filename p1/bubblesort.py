#!/usr/bin/env python
# -*- coding:utf-8 -*-
#Author : ZhaoYuchao
#2016-04-08 16:23:16
def bubblesort(A):
    for i in range(0,len(A)):
        for j in range(len(A)-1,i,-1):
            if(A[j]<A[j-1]):
                A[j],A[j-1]=A[j-1],A[j]
    return A

print bubblesort([9,3,1,0,1,6,3,8,4,5])

