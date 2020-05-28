class Owner
  
  @@owners = []

  attr_reader :name, :species
  def initialize(name)
    @name = name
    @species = "human"
    save()
  end

  def save()
    self.class.all() << self
  end  

  def say_species()
    "I am a #{self.species}."
  end

  def cats()
    get_animals(Cat)
  end
  
  def dogs()
    get_animals(Dog)
  end
  
  def buy_cat(cat_name)
    Cat.new(cat_name, self)
  end

  def buy_dog(dog_name)
    Dog.new(dog_name, self)
  end

  def walk_dogs()
    change_mood(self.dogs(), "happy")
  end 

  def feed_cats()
    change_mood(self.cats(), "happy")
  end

  def sell_pets()
    all_pets = self.cats() + self.dogs()
    change_mood(all_pets, "nervous")
    change_owner(all_pets, nil)
  end

  def list_pets()
    "I have #{self.dogs().count()} dog(s), and #{self.cats().count()} cat(s)."
  end

  def self.all()
    @@owners
  end

  def self.count()
    self.all().count()
  end

  def self.reset_all()
    self.all().clear()
  end

  private

  def get_animals(class_name)
    class_name.all().select {|animal| animal.owner == self}
  end 

  def change_mood(animals, mood)
    animals.map{|animal| animal.mood = mood}
  end

  def change_owner(animals, owner)
    animals.map{|animal| animal.owner = owner}
  end

end