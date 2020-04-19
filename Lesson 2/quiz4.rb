alphabet = ('a'..'z')
vowels = %w[a e i o u]
hash = {}

alphabet.each.with_index(1) do |letter, index|
    hash[letter] = index if vowels.include? letter 
end
print hash

