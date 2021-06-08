# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Department.create(name: "IT学科", alphabet: "G")
Department.create(name: "情報処理学科", alphabet: "H")
Department.create(name: "ITスペシャリスト学科", alphabet: "J")
Department.create(name: "ITエキスパート学科", alphabet: "K")


User.create(name: "管理者", email: "kd9999999@st.kobedenshi.ac.jp", password: "password", admin: true, department: Department.first)
User.create(name: "ゲスト", email: "kd0000000@st.kobedenshi.ac.jp", password: "password", admin: false, department: Department.first)
User.create(name: "テスト", email: "kd1234567@st.kobedenshi.ac.jp", password: "password", admin: false, department: Department.first)