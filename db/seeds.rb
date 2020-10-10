# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Organizer.create!(
  email: 'test@organizer.com',
  password: 'password'
)

Participant.create!(
  nickname: 'test',
  telephone_number: '09012341234',
  email: 'test@pp.com',
  password: 'password'
)

Organizer.all.each do |organizer|
  organizer.events.create!(
    date_and_time: '2020/10/30',
    event_name: 'ソクラテスの会',
    content: '面白い',
    number_of_reservations: 20,
    is_active: 'true'
  )
end