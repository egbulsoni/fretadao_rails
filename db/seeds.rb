# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# include Scrapper
profile = Profile.create([{name: "Fretadao",  url: "https://tinyurl.com/y5xnl9ov",
   username: "@usefretadao", image: "https://tinyurl.com/yyt53knw"},
  {name: "Game idea machine", url: "https://tinyurl.com/n57p87p",
  username: "@gameideamachine", image: "https://tinyurl.com/yy2euo28"}])
