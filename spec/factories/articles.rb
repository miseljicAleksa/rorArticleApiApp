FactoryBot.define do
  factory :article do
    sequence(:title){ |n|"thas is article #{n}" }
    sequence(:content) {|n| "thas is content of article #{n}"}
    sequence(:slug) { |n| "thas-is-slug-of-article-#{n}" }
  end
end
