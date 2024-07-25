# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Test User" }
    passport_number { "A1234567" }
    passport_expiry { "2025-01-01" }
    date_of_birth { "1990-01-01" }
    session_id { SecureRandom.uuid }
  end
end
