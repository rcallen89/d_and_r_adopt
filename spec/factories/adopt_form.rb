FactoryBot.define do
  factory :adopt_form do
    name { "Sally" }
    address { "1234 Main St." }
    city { "Denver" }
    state { "CO" }
    zip { "80123" }
    phone_number { "303-111-1234" }
    description { "I would be a great pet parent" }
  end
end