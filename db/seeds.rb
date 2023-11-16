# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
User.destroy_all
puts "user初期データ生成"
CSV.foreach("db/user_csv.csv", headers: true) do |row|
  User.create(name: row["name"], email: row["email"], password: row["password"], password_confirmation: row["password"])
end
