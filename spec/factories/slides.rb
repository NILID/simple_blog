FactoryBot.define do
  factory :slide do
    container

    trait(:with_slide) { slide { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png'), 'image/png') } }
  end
end
