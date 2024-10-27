class Stack:

    def __init__(self,max):
        while type(max)!=int:
            print("Invalid size or input type. Please enter the size of the stack correctly.")
        self.stack=[0]*max
        self.top=-1

    def __str__(self):
        return str(self.stack)
    
    def __len__(self):
        return len(self.stack)
    
    def peek(self):
        return self.stack[self.top]
    
    def push(self,num):
        if self.top == len(self.stack)-1:
            return print("The stack is full!")
        else:
            self.top+=1
            self.stack[self.top]=num

    def pop(self):
        if self.top == -1:
            return print("The stack is empty!")
        else:
            temp=self.stack[self.top]
            self.stack[self.top]=0
            self.top-=1
            return temp
    

# testing
# x=Stack(5)
# x.push(5)
# x.push("loai")
# x.push(10)
# x.push('Wael')
# x.push('Hassan')
# x.push(1)
# x.pop()
# print(x)
# print(x.pop())
# print(x)
# x.pop()
# x.pop()
# x.pop()
# print(x)
# x.pop()
# print(len(x))
# print(x.peek())