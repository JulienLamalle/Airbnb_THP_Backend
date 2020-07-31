require 'faker'

City.destroy_all
City.reset_pk_sequence
Stay.destroy_all
Stay.reset_pk_sequence
User.destroy_all
User.reset_pk_sequence
Trip.destroy_all
Trip.reset_pk_sequence
Faker::Config.locale = 'fr'

cities = Array.new
stays = Array.new
users = Array.new
trips = Array.new

10.times do 
  city = City.create(
    name:["Paris","Lyon","Bordeaux","Nice","Marseille","Bastia"].sample(1).join(''),
    zip_code: Faker::Address.zip_code)
  cities << city
  puts "Seeding City #{city.id} #{city.name} #{city.zip_code}"
end

20.times do 
  user = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number,
  description: Faker::Lorem.sentence
  )
  users << user
  puts "Seeding User #{user.first_name} #{user.last_name}"
end

50.times do 
  stay = Stay.create(
      nb_beds: rand(1..5),
      night_price: Faker::Number.between(from: 30.0, to: 100.0).round(2),
      description: Faker::Lorem.sentence,
      wifi: Faker::Boolean.boolean(true_ratio: 0.8),
      city_id: cities[rand(0..9)].id,
      user_id: users[rand(0..9)].id)      
  stays << stay
  puts "Seeding Stay number #{stay.id}"
end

5.times do
    stays.each do |stay|
        random_date = Faker::Date.backward
        trip = Trip.create(
          start_date: random_date,
          end_date: random_date + rand(1..5),
          stay_id: stay.id,
          host_id: stays[rand(0..49)].user_id,
          customer_id: users[rand(0..9)].id
        )
        puts "Seeding past Trip '#{trip.id}' from #{trip.start_date} to #{trip.end_date}"
    end
end

5.times do
    stays.each do |stay|
        random_date = Faker::Date.forward
        trip = Trip.create(
          start_date: random_date,
          end_date: random_date + rand(1..5),
          stay_id: stay.id,
          host_id: stays[rand(0..49)].user_id,
          customer_id: users[rand(0..9)].id
        )
        puts "Seeding future Trip '#{trip.id}' from #{trip.start_date} to #{trip.end_date}"
    end
end

