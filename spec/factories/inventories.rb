FactoryBot.define do
  factory :inventory do
    locked_at {[Time.now, nil].sample}
    store
  end
end
