require './basket'

describe Basket do 

  before :each do
    @basket = Basket.new
  end

  describe "with no discount" do
    it "should cost 8e for one book" do
      @basket.add([4])
      @basket.price.should == 8
    end

    it "should cost 16e for two books of the same title" do
      @basket.add([4,4])
      @basket.price.should == 2*8
    end

    it "should cost 24e for three books of the same title" do
      @basket.add([4,4,4])
      @basket.price.should == 3*8
    end
  end
  
  describe "with simple discounts" do
  	it "should be 5% for 2 different titles" do
  		@basket.add([1,3])
  		@basket.price.should == 8*2*0.95
  	end

    it "should be 10% for 3 different titles" do
      @basket.add([1,3,5])
      @basket.price.should == 3*8*0.9
    end

    it "should be 20% for 4 different titles" do
      @basket.add([1,3, 5, 2])
      @basket.price.should == 4*8*0.8
    end

    it "should be 25% for 5 different titles" do
      @basket.add([1,3,5,2,4])
      @basket.price.should == 5*8*0.75
    end
  end

  describe "several discounts" do
    it "should be 5% for 3 books from which 2 are same titles" do
      @basket.add([1,5,1])
      @basket.price.should == 8+8*2*0.95
    end

    it "should be 5% for 4 books which are 2 different titles" do
      @basket.add([1,5,5,1])
      @basket.price.should == 2*8*2*0.95
    end

    it "should calculate best discount with several titles" do
      @basket.add([1,1,2,3,3,4])
      @basket.price.should == 8*4*0.8+8*2*0.95
    end

    it "should calculate best discount with even more titles" do
      @basket.add([1,2,2,3,4,5])
      @basket.price.should == 8+8*5*0.75
    end
  end

  describe "the edge cases" do
    it "should calculate the best discount from set 1" do
      @basket.add([1,1,2,2,3,3,4,5])
      @basket.price.should == 2*8*4*0.8
    end

    it "should calculate the best discount from set 2" do
      @basket.add([1,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,4,4,4,5,5,5,5])
      @basket.price.should == 3*8*5*0.75+2*8*4*0.8
    end
  end

  describe "helper functions" do
    describe "with books in basket" do
      before :each do
        @basket.add([1,1,2,2,2,3,3,4,4,4,4])
      end

      it "should count the number of books" do
        books, different_books = @basket.book_stats @basket.titles
        books.should == 11
        different_books.should == 4
      end

      it "should subtract books from the titles with most books" do
        titles = @basket.subtract_titles @basket.titles, 3
        titles[1].should == 1
        titles[2].should == 2
        titles[3].should == 2
        titles[4].should == 3
        titles[5].should == 0
      end

      it "should recognize non-empty basket" do
        is_empty = @basket.is_empty? @basket.titles
        is_empty.should == false
      end
    end
    
    describe "with empty basket" do
      before :each do
        @empty_hash = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0}
      end

      it "should recognize empty basket" do 
        is_empty = @basket.is_empty? @empty_hash
        is_empty.should == true
      end

      it "price calculation should return nil" do
        price = @basket.calculate_price @empty_hash
      end
    end
  end
end