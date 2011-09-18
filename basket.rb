class Basket

  def initialize
    #puts "Basket init"
    @titles = {"one" => 0, "two" => 0, "three" => 0, "four" => 0, "five" => 0}
    @discounts = [1, 0.95, 0.90, 0.80, 0.75]
  end

  def titles
    @titles
  end

  def add(titles)
  	titles.each { |title| @titles[title] += 1 }
  end

  def price
    #puts "CALCULATION BEGINS"
  	calculate_price @titles, 0
  end

  def calculate_price titles, level
    #puts "calc price #{level}: #{titles}"

    return nil if is_empty? titles
    books, different_books = book_stats titles
    
    if books == different_books
        return books * 8 * @discounts[different_books-1]
    elsif different_books == 1
        return books * 8
    end

    loop_counter = different_books
    lowest_price = nil
    while loop_counter > 1
      tmp_titles = titles.clone
      
      #puts "     Loop counter (#{loop_counter}): level = #{level}, #{tmp_titles}"
		  price = loop_counter * 8 * @discounts[loop_counter-1]
		  next_titles = subtract_titles tmp_titles, loop_counter
		  tmp_price = calculate_price next_titles, level + 1
      #puts "     tmp_price: #{tmp_price}"
      price += tmp_price unless tmp_price.nil?

      loop_counter -= 1

      if lowest_price.nil? || (!tmp_price.nil? && price < lowest_price)
        lowest_price = price
      end
    end
    #puts "calc price: lowest #{lowest_price}"
    lowest_price
  end

  def subtract_titles titles, different_books
  	counter = different_books - 1
    sorted = titles.sort {|a,b| b[1]<=>a[1]} 
    
  	for i in 0..counter
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
    titles.keys.each { |title| return false if titles[title] > 0 }
    true
  end
end