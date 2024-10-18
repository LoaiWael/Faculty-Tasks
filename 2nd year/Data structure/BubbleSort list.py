def bubbleSort(li):
    n=len(li)
    for i in range(n):
        for j in range(n-1):
            if li[j]>li[j+1]:
                li[j],li[j+1]=li[j+1],li[j]
    return li

li=[9,5,7,8,2,1,3,4,6,10]
print(bubbleSort(li))