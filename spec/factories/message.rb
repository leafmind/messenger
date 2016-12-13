FactoryGirl.define do
  factory :message do
    sequence(:body) { |n| "Body#{n}" }

    trait :with_attachments do
      after(:create) do |message, evaluator|
        message.attachments << create(:attachment, message: message)
      end
    end

    trait :with_images do
      after(:create) do |message, evaluator|
        message.attachments << create(:attachment, :with_image, message: message)
      end
    end

    trait :images_in_body do
      body 'http://site.com/image.png kittens'
    end

    trait :urls_in_body do
      body 'http://site.com/doc.pdf'
    end
  end
end
