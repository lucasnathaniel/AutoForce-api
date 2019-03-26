namespace :dev do
  desc "Configure development environment"
  task setup: :environment do
    
    8.times do |b|
      Batch.create!(
        reference: Faker::Code.asin,
        purchase_channel: Faker::App.name,
      )
    end

    15.times do |o|
      Order.create!(
        reference: Faker::Code.asin,
        purchase_channel: Faker::App.name,
        client_name: Faker::Name.name,
        address: Faker::Address.full_address,
        delivery_service: ["SEDEX", "CORREIOS"].sample,
        total_value: rand(10.0...1000.00).round(2).to_f,
        line_item: Faker::Device.model_name,
        status: [1,2,3,4].sample,
        batch: Batch.all.sample
      )
    end
    
  end

end
