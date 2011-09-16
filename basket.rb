class Basket

  def initialize
    @titles = {"one" => 0, "two" => 0, "three" => 0, "four" => 0, "five" => 0}
    @discounts = [1, 0.95, 0.90, 0.80, 0.75]
  end

  def add(titles)
  	titles.each { |title| @titles[title] += 1 }
  end

  def price
  	price = 0
  	books, different_books = book_stats

  	if books == different_books
  		price = books * 8 * @discounts[different_books-1]
  	elsif different_books == 1
  		price = books * 8 
  	elsif books % different_books == 0
  		factor = books / different_books
  		price = factor * different_books * 8 * @discounts[different_books-1]
  	else
  		price = different_books * 8 * @discounts[different_books-1]
  		price += (books - different_books) * 8 		
  	end
  	price
  end

  def book_stats
  	books = 0
  	different_books = 0
  	@titles.keys.each do |title|  	 	
  	 	if @titles[title] > 0
  	 		books += @titles[title]
  			different_books += 1
  		end
  	end
  	[books, different_books]
  end
end