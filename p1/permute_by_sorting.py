#coding:utf-8
#
# Copyright (c) 2016 by Zhao Yuchao.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
import random
import operator
def permute_by_sorting(a) :
    p=[]
    for i in range(len(a)) :
         p.append( random.randint(1 , pow(len(a) , 3)))
    link = sorted(zip(a , p) , key=operator.itemgetter(1))
    randa = map(operator.itemgetter(0) , link)
    return randa



