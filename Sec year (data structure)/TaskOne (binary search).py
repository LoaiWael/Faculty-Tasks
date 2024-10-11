def binarySearch(li,x):
    low=0
    high=len(li)-1

    while low <= high:
        mid = (low + high) // 2
        if li[mid] == x:
            return f"the middle of number {x} is {mid}"
        elif li[mid] < x:
            low = mid + 1
        else:
            high = mid - 1
            
    return f"This number {x} is not included in the list."

li=[2,4,6,8,10,12,16]
#   0,1,2,3, 4, 5,6

x= int(input(f"choose a number in the list: {li}"))
print(binarySearch(li,x))
        