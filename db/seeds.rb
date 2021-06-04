# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "admin_user", email: "admin@example.com", password: "password", admin: true)
User.create(name: "guest_user", email: "guest@example.com", password: "password", admin: false)
User.create(name: "test_user", email: "test@example.com", password: "password", admin: false)
