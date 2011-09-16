require './basket'

describe Basket do 

  describe "basket" do  
  	it "should store added titles" do
	end
  end
  
  describe "discount" do
  	before :each do
  	  @basket = Basket.new
  	end

  	it "should be zero for one book" do
  		@basket.add(["four"])
  		@basket.total.should == 8
  	end

    it "should not give discount for two same books" do
      @basket.add(["one", "one"])
      @basket.total.should == 16
    end

  	it "should be 5% for 2 different titles" do
  		@basket.add(["one","three"])
  		@basket.total.should == 15.2
  	end
  end
end