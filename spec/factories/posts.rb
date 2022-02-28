# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    trait :lorem_ipsum do
      title { 'Lorem Ipsum' }
      text { 'Lorem Ipsum is simply dummy text of the printing and typesetting industry' }
    end

    trait :come_from do
      title { 'Where does it come from?' }
      text  { 'Contrary to popular belief, Lorem Ipsum is not simply random text' }
    end
    trait :why do
      title { 'Why do we use it?' }
      text  { 'It is a long established fact that a reader will be distracted by the readable content of a page' }
    end
  end
end
