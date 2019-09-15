FactoryBot.define do
  factory :container do
    content { "MyText" }
    types_mask { 'text' }
    association :note, :with_preview
  end
end
