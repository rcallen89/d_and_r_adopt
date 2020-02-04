FactoryBot.define do
  factory :review do
    title { "#{shelter.name} Review" }
    rating { "4" }
    content { "This was a great shelter to work with." }
    image { "https://sagemailer.com/blog/content/images/2019/12/Amazon-review-request-button.jpg" }
    shelter
  end
end