#!/usr/bin/env python
# -*- coding:utf-8 -*-
#Author : ZhaoYuchao
#2016-04-07 18:54:43


def insertion_sort(A) :
    for j  in range(1,len(A)) :
        key=A[j]
        i=j-1
        while(i>=0 and A[i]>key) :
            A[i+1]=A[i]
            i=i-1
        A[i+1]=key
    return A


    
    
