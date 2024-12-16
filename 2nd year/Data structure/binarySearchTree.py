class Node:
    def __init__(self,data):
        self.__data=data
        self.__leftChild=None
        self.__rightChild=None
        
    @property
    def getData(self):
        return self.__data
    @property
    def getLeft(self):
        return self.__leftChild
    @property
    def getRight(self):
        return self.__rightChild
    
    def setData(self,data):
        self.__data=data
        
    def setLeft(self,data):
        self.__leftChild=data
        
    def setRight(self,data):
        self.__rightChild=data
        
class binarySearchTree:
    def __init__(self):
        self.__root=None
    
    @property
    def isEmpty(self):
        return self.__root==None
    
    @property
    def getRoot(self):
        if self.isEmpty:
            raise Exception("The tree is empty.")
        return self.__root.getData
    
    def __find(self,data):
        current=self.__root
        parent=current
        while current != None and current.getData != data:
            parent=current
            current=(current.getLeft if data<current.getData else current.getRight)
        return (current,parent)
    
    def search(self,data):
        node,parent=self.__find(data)
        return node.getData if node else None 
    
    def insert(self,data):
        if self.__root is None:
            newNode=Node(data)
            self.__root=newNode
            return
        node,parent=self.__find(data)
        if node is None:
            newNode=Node(data)
            if data<parent.getData:
                parent.setLeft(newNode)
            else:
                parent.setRight(newNode)
        else:
            return "data is already exist"
            
    def inOrderT(self,function=print):
        self.__inOrderT(self.__root,function=function)
        
    def __inOrderT(self,node,function):
        current:Node=node
        if current is not None:
            self.__inOrderT(current.getLeft,function)
            function(current.getData)
            self.__inOrderT(current.getRight,function)
            
    def preOrderT(self,function=print):
        self.__preOrderT(self.__root,function=function)
        
    def __preOrderT(self,node,function):
        current:Node=node
        if current is not None:
            function(current.getData)
            self.__preOrderT(current.getLeft,function)
            self.__preOrderT(current.getRight,function)
            
    def postOrderT(self,function=print):
        self.__postOrderT(self.__root,function=function)
        
    def __postOrderT(self,node,function):
        current:Node=node
        if current is not None:
            self.__postOrderT(current.getLeft,function)
            self.__postOrderT(current.getRight,function)
            function(current.getData)
    
x=binarySearchTree()
x.insert(8)
x.insert(3)
x.insert(10)
x.insert(1)
x.insert(6)
x.insert(14)
x.insert(4)
x.insert(7)
x.insert(13)
x.postOrderT(print)
# print(x.isEmpty)