FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Sample Article #{n}" }
    # sequence(:content) { |n| "Sample content #{n}" }
    content {"Sample Content"}
    sequence(:slug) { |n| "Sample Slug-#{n}" }
  end
end
