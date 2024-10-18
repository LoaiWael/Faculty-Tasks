def selectionSort(li):
    n=len(li)
    for i in range(n-1):
        min=i
        for j in range(i+1,n):
            if li[min]>li[j]:
                min=j
        li[min],li[i]=li[i],li[min]
    return li
        


li=[4,7,8,9,6,5,2,3,1]
print(selectionSort(li))