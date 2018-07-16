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

# Create tags here

tg1 = TagGroup.create(name: "Interaction")
  t1 = Tag.create(name: "Zero Range")
  t2 = Tag.create(name: "Finite Range")
  t3 = Tag.create(name: "Dipole")
  t4 = Tag.create(name: "Long Range")
  tg1.tags << [t1,t2,t3,t4]

tg2 = TagGroup.create(name: "Spatial Dimension")
  t5 = Tag.create(name: "1")
  t6 = Tag.create(name: "2")
  t7 = Tag.create(name: "3")
  tg2.tags << [t5,t6,t7]

tg3 = TagGroup.create(name: "External Potential")
  t8 = Tag.create(name: "None")
  t9 = Tag.create(name: "Lattice")
  t10 = Tag.create(name: "Harmonic")
  tg3.tags << [t8,t9,t10]

tg4 = TagGroup.create(name: "Statistics Type")
  t11 = Tag.create(name: "Fermi")
  t12 = Tag.create(name: "Bose")
  t13 = Tag.create(name: "Boltzmann")
  tg4.tags << [t11, t12, t13]

tg5 = TagGroup.create(name: "Temperature")
  t14 = Tag.create(name: "Zero")
  t15 = Tag.create(name: "Finite")
  tg5.tags << [t14,t15]

tg6 = TagGroup.create(name: "Particle Number")
  t16 = Tag.create(name: "Few")
  t17 = Tag.create(name: "Many")
  tg6.tags << [t16, t17]


# Create roles here

r = Role.create(name: "librarian")
r.users << [u1, u2]
