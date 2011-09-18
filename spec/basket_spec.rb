require './basket'

describe Basket do 

  before :each do
    @basket = Basket.new
  end

  describe "with no discount" do
    it "should cost 8e for one book" do
      @basket.add(["four"])
      @basket.price.should == 8
    end

    it "should cost 16e for two books of the same title" do
      @basket.add(["four", "four"])
      @basket.price.should == 2*8
    end

    it "should cost 24e for three books of the same title" do
      @basket.add(["four", "four", "four"])
      @basket.price.should == 3*8
    end
  end
  
  describe "with simple discounts" do
  	it "should be 5% for 2 different titles" do
  		@basket.add(["one","three"])
  		@basket.price.should == 8*2*0.95
  	end

    it "should be 10% for 3 different titles" do
      @basket.add(["one","three", "five"])
      @basket.price.should == 3*8*0.9
    end

    it "should be 20% for 4 different titles" do
      @basket.add(["one","three", "five", "two"])
      @basket.price.should == 4*8*0.8
    end

    it "should be 25% for 5 different titles" do
      @basket.add(["one","three", "five", "two", "four"])
      @basket.price.should == 5*8*0.75
    end
  end

  describe "several discounts" do
    it "should be 5% for 3 books from which 2 are same titles" do
      @basket.add(["one", "five", "one"])
      @basket.price.should == 8+8*2*0.95
    end

    it "should be 5% for 4 books which are 2 different titles" do
      @basket.add(["one", "five", "five", "one"])
      @basket.price.should == 2*8*2*0.95
    end

    it "should calculate best discount with several titles" do
      @basket.add(["one", "one", "two", "three", "three", "four"])
      @basket.price.should == 8*4*0.8+8*2*0.95
    end

    it "should calculate best discount with even more titles" do
      @basket.add(["one", "two", "two", "three", "four", "five"])
      @basket.price.should == 8+8*5*0.75
    end
  end

  describe "the edge cases" do
    it "should calculate the best discount from set 1" do
      @basket.add(["one", "one", "two", "two", "three", "three", "four", "five"])
      @basket.price.should == 2*8*4*0.8
    end
  end

  describe "helper functions" do
    
    describe "with books in basket" do
      before :each do
        @basket.add(["one", "one", "two", "two", "two", "three", "three", "four", "four", "four", "four"])
      end

      it "should count the number of books" do
        books, different_books = @basket.book_stats @basket.titles
        books.should == 11
        different_books.should == 4
      end

      it "should subtract books from the titles with most books" do
        titles = @basket.subtract_titles @basket.titles, 3
        titles["one"].should == 1
        titles["two"].should == 2
        titles["three"].should == 2
        titles["four"].should == 3
        titles["five"].should == 0
      end

      it "should recognize basket has books" do
        is_empty = @basket.is_empty? @basket.titles
        is_empty.should == false
      end
    end
    
    describe "with empty basket" do
      before :each do
        @empty_hash = {"one" => 0, "two" => 0, "three" => 0, "four" => 0, "five" => 0}
      end

      it "should recognize empty basket" do 
        is_empty = @basket.is_empty? @empty_hash
        is_empty.should == true
      end

      it "price calculation should return nil" do
        price = @basket.calculate_price @empty_hash, 0
      end
    end
  end
end