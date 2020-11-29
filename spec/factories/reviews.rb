FactoryBot.define do
  factory :review do
    title        {"７つの習慣"}
    text         {Faker::Lorem.paragraph(sentence_count = 3)}
    category_id  {"10"}
    limit_id     {"3"}
    association :user 
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/index_contents.jpg'), filename: 'index_contents.jpg')
    end
  end
end
