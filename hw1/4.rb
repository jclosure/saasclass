=begin
Part 4: Basic OOP
=end

#A
class Dessert
  
  attr_accessor :name
  attr_accessor :calories
  
  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  
  def healthy?
    @calories < 200
  end
  
  def delicious?
    true
  end
  
end


dessert = Dessert.new("JellyBelly", 30)
p dessert.healthy?
p dessert.delicious?


#B
class JellyBean < Dessert
  
  attr_accessor :flavor
  
  def initialize(name, calories, flavor)
    @name = name
    @calories = calories
    @flavor = flavor
  end
  
  def delicious?
    unless (@flavor.downcase == "black licorice")
      super
    else
      false
    end
  end
end

jelly_belly = JellyBean.new("JellyBelly", 30, "black licorice")
p jelly_belly.delicious?
jelly_belly = JellyBean.new("JellyBelly", 30, "orange")
p jelly_belly.delicious?
