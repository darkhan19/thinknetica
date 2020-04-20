array = [0]
dig = 1
    until dig > 100 
      array.push dig
      dig = array[-1] + array[-2]
    end
print array
