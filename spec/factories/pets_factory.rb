FactoryGirl.define do
  factory :pet do
    animal_type { Pet::ANIMAL_TYPES.sample }
    sequence(:breed) { |n| "Tabby #{n}" }
    age { Pet::AGES.sample }
    sex { Pet::SEXES.sample }
    sequence(:name) { |n| "Tom#{n}" }
    size { Pet::SIZES.sample }
    sequence(:location) { |n| "MA#{n}" }
  end
end
