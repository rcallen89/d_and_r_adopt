FactoryBot.define do
  factory :pet do
    name { "Tron" }
    approximate_age { "3" }
    sex { "Male" }
    description { "Too Cool for School" }
    image { "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg" }
    adoptable { 0 }
    shelter
  end
end