=begin
Part 1: fun with strings
=end

#a
def palindrome?(string)
  words = string.downcase.gsub(/[^\w]+/, '')
  words == words.reverse
end

string = "Madam, I'm Adam!"
p palindrome?(string)

string = "A man, a plan, a canal -- Panama"
p palindrome?(string)

p palindrome?("Abracadabra")


#b
def count_words(string)
  freqs = Hash.new(0)
  list = string.downcase.scan(/\w+/)
  list.each { |word| freqs[word] += 1 }
  freqs
end

string = "A man, a plan, a canal -- Panama"
p count_words(string) 