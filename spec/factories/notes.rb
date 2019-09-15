FactoryBot.define do
  factory :note do
    title { "MyString" }
    desc { "MyText" }
    hide { true }
    user

    trait(:with_preview) { preview { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png'), 'image/png') } }
  end
end
