# function
def vowelCounter(var: str):
    var.lower
    count=0
    vowels=['a','e','i','o','u']
    for character in var:
        for vowel in vowels:
            if character == vowel:
                count+=1
    return count

# test
inp=input("please enter a word:")
print(vowelCounter(inp))