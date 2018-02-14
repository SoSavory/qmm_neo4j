# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u1 = User.create(email: 'sosavory@live.unc.edu', password: 'avery1234')
u2 = User.create(email: 'drut@live.unc.edu', password: 'avery1234')

p1 = Person.create(first_name: 'Avery', last_name: 'Marsh')
p2 = Person.create(first_name: 'Joaquin', last_name: 'Drut')

u1.person = p1
u2.person = p2

a1 = Author.create(institution: 'University of North Carolina Chapel Hill')
a2 = Author.create(institution: 'University of North Carolina Chapel Hill')

p1.authors << a1
p2.authors << a2

a1.person = p1
a2.person = p2

for i in 0..10
  a = Article.create(title: "Article number #{i}", abstract: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
")
  a.authors << [a1,a2]
end

Article.all.each do |a|
  a1.articles << a
  a2.articles << a
end
