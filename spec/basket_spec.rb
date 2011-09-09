require './basket'

describe Basket do 
  describe "discount" do
  	it "should not give discount for one book" do
  		basket = Basket.new
  		basket.add(1)
  		basket.total.should == 8
  	end
  end
end