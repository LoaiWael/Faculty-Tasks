import ctypes

# function
def creatArray(lengh , start):
    try:
        int(lengh)
        int(start)
    except:
        return "invalid input type!"
    array=(ctypes.c_int*lengh)()
    array[0]=start
    print(array[0], end=" ")
    for i in range(len(array)):
        if i == 0:
            continue
        array[i]=start+i
        print(array[i], end=" ")


# test
creatArray(10, 6)