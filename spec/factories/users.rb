# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default(0), not null
#  session_key     :string
#  password_digest :string
#

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| Faker::Internet.email }
    password { '12345678' }
    password_confirmation { '12345678' }

    factory :user_with_articles do
      transient do
        article_count 2
      end

      after(:build) do |user, evaluator|
        evaluator.article_count.times do
          user.articles << build(:article, author: user)
        end
      end
    end

    factory :member do
      role 'member'
    end

    factory :admin do
      role 'admin'
    end

    factory :editor do
      role 'editor'
    end
  end
end
