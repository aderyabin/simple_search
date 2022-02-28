# frozen_string_literal: true

10.times do
  Post.create(
    title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4),
    text: Faker::Lorem.paragraphs(number: 1)[0]
  )
end
