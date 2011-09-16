class Basket

  def initialize
    @titles = {"one" => 0, "two" => 0, "three" => 0, "four" => 0, "five" => 0}
    @discounts = [1, 0.95, 0.90, 0.80, 0.75]
  end

  def add(titles)
  	titles.each { |title| @titles[title] += 1 }
  end

  def price
  	calculate_price @titles
  end

  def calculate_price titles
	books, different_books = book_stats titles

  	if books == different_books
  		price = books * 8 * @discounts[different_books-1]
  	elsif different_books == 1
  		price = books * 8 
  	else
  		price = different_books * 8 * @discounts[different_books-1]
  		next_titles = subtract_titles titles, different_books
  		price += calculate_price next_titles
  	end
  	price
  end

  def subtract_titles titles, different_books
  	counter = different_books
  	titles.keys.each do |title|
  		if titles[title] > 0 && counter > 0
  	 		titles[title] -= 1
  	 		counter -= 1
  		end
  	end
  	titles
  end

  def book_stats titles
  	books = 0
  	different_books = 0
  	titles.keys.each do |title|  	 	
  	 	if titles[title] > 0
  	 		books += titles[title]
  			different_books += 1
  		end
  	end
  	[books, different_books]
  end
end