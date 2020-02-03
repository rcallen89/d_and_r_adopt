# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all


shelter1 = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")
shelter2 = Shelter.create!(name: "Meg's Shelter", address: "150 Main Street", city: "Hershey", state: "PA", zip: "17003")

pet1 = shelter1.pets.create!(name: "Tron",
                       image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg",
                       approximate_age: 3,
                       sex: "Male",
                       description: 'Too Cool for School')
pet2 = shelter2.pets.create!(name: "Kat",
                  image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg",
                  approximate_age: 2,
                  sex: "Female",
                  description: 'Too Hot for TV')
