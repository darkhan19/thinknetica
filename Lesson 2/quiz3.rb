array = [0]
first = 0
second = 1
fibonacci = 0
    until fibonacci > 88 
      fibonacci = first + second
      first = second
      second = fibonacci
      array.push fibonacci
    end
print array
