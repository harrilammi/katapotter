class Basket

  BookPrice = 8

  def initialize
    @titles = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0}
    @discounts = [1, 0.95, 0.90, 0.80, 0.75]
  end

  def titles
    @titles
  end

  def add(titles)
  	titles.each { |title| @titles[title] += 1 }
  end

  def price
  	calculate_price @titles
  end

  def calculate_price titles
    return nil if is_empty? titles

    books, different_books = book_stats titles
    
    if books == different_books
        return books * BookPrice * @discounts[different_books-1]
    elsif different_books == 1
        return books * BookPrice
    end

    lowest_price = nil
    while different_books > 1
      price = different_books * BookPrice * @discounts[different_books-1]
		  tmp_price = calculate_price(subtract_titles titles.clone, different_books)
      price += tmp_price unless tmp_price.nil?

      if lowest_price.nil? || (!tmp_price.nil? && price < lowest_price)
        lowest_price = price
      end
      different_books -= 1
    end
    lowest_price
  end

  def subtract_titles titles, different_books	
    sorted = titles.sort {|a,b| b[1]<=>a[1]} 
  	for i in 0..(different_books - 1)
      if titles[sorted[i][0]] > 0 
        titles[sorted[i][0]] -= 1
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

  def is_empty? titles
    titles.each_value { |value| return false if value > 0 }
    true
  end
end