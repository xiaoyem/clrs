#!/usr/bin/env python
# -*- coding:utf-8 -*-
#Author : ZhaoYuchao
#2016-04-08 17:13:19

def MERGE(A,p,q,r):
    L=A[p:q+1]
    R=A[q+1:r+1]
    infi=[float("inf")]
    L.extend(infi)
    R.extend(infi)
    i=0
    j=0
    for k in range(p,r+1):
        if L[i]<=R[j]:
            A[k]=L[i]
            i+=1
        else:
            A[k]=R[j]
            j+=1
    return A
def MERGESORT(A,p,r):
    if p<r:
        q=int((p+r)/2)
        MERGESORT(A,p,q)
        MERGESORT(A,q+1,r)
        MERGE(A,p,q,r)
    return A
print MERGESORT([2,4,3,1,6,7,8,2],0,7)


