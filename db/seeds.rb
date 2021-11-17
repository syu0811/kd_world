# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Department.create(name: "ITⅠ", alphabet: "G")
Department.create(name: "ITⅡ", alphabet: "H")
Department.create(name: "ITⅢ", alphabet: "J")
Department.create(name: "ITⅣ", alphabet: "K")


User.create(name: "管理者", email: "kd9999999@st.kobedenshi.ac.jp", password: "password", admin: true, department: Department.first)
User.create(name: "ゲスト", email: "kd0000000@st.kobedenshi.ac.jp", password: "password", admin: false, department: Department.first)
User.create(name: "テスト", email: "kd1234567@st.kobedenshi.ac.jp", password: "password", admin: false, department: Department.first)
User.create(name: "テスト_2", email: "kd2345678@st.kobedenshi.ac.jp", password: "password", admin: false, department: Department.first)

Friend.create(user_id: User.first.id, friend_id: User.second.id)
FriendRequest.create(user_id: User.first.id, applicant_id: User.third.id)

Topic.create(title: "テスト1", user: User.first)
Topic.create(title: "テスト2", user: User.first)

Post.create(user: User.first, body: "テスト１", topic: Topic.first)
Post.create(user: User.first, body: "テスト２", topic: Topic.first)