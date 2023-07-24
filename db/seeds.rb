# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "dmm@gmail.com",
  password: "114514"
)

Tag.create([
	{ name: '通勤通学' },
	{ name: '個性重視' },
	{ name: '初心者におすすめ' },
	{ name: 'セカンドバイク' },
	{ name: '快適ロングツーリング' }
])
