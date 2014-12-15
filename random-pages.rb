# adds 20 new random files to ./articles

categories = %w{foo bar baz qux quux corge grault garply waldo fred plugh xyzzy thud}

article_path = File.dirname(__FILE__) + '/articles/'
Dir.chdir(article_path)

def random_word(letters)
  letters.times.inject("") {|word,letter| word + ('a'..'z').to_a.sample}
end

120.times do |page|
  page_title = "#{random_word(3)}-#{random_word(4)}-#{random_word(6)}"
  File.open(article_path + page_title + ".md","w") do |file|
    file.puts "---"
    file.puts "layout: page"
    file.puts "title: \"#{page_title}\""
    file.puts "date: 2014-#{(1..12).to_a.sample}-#{(1..28).to_a.sample}"
    number_of_categories = Random.rand(3) + 1
    file.puts "categories: #{categories.sample(number_of_categories).inspect}"
    file.puts "indexed: #{Random.rand(2) == 0}"
    file.puts "---"
    file.puts "This is the body of _this_ file, the one called #{page_title}"
  end
end