FactoryGirl.define do
  factory :attachment do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:title_url) { |n| "http://site_#{n}.com/xxx.html" }
    description "some text"

    trait :with_image do
      image_url "http://site.com/image.png"
    end
  end

end
