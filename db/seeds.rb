# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do 
    Cat.delete_all

    c1 = Cat.create!(birth_date: "2002/04/29", color: "black", name: "Purry", sex: "F", description: "Purry is a sweet, friendly kitty!")
    c2 = Cat.create!(birth_date: "2001/12/20", color: "white", name: "Kitten", sex: "F", description: "Kitten loves to play!")
    c3 = Cat.create!(birth_date: "2005/4/30", color: "grey", name: "Mittens", sex: "M", description: "Mittens - just like a warm glove")
    c4 = Cat.create!(birth_date: "2012/08/01", color: "calico", name: "Jerry", sex: "M", description: "Human name with cat tendencies!")
    c5 = Cat.create!(birth_date: "2010/06/01", color: "calico", name: "Hairmouth", sex: "M", description: "Usually doesn't have a hairball!")

end
