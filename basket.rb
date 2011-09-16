class Basket

  def initialize
    @titles = {"one" => 0, "two" => 0, "three" => 0, "four" => 0, "five" => 0}
  end

  def add(titles)
  	titles.each { |title| @titles[title] += 1 }
  end

  def total
  	total = 0
  	if number_of_books == 2 && number_of_different_books == 2
  		total = 15.2
  	else
  		total = 8 * number_of_books
  	end
  	total
  end

  def number_of_books
  	books = 0
  	@titles.keys.each {|title| books += @titles[title] }
  	books
  end

  def number_of_different_books
	books = 0
  	@titles.keys.each do |title|
  		if @titles[title] > 0
  			books += 1
  		end
  	end
  	books
  end
end