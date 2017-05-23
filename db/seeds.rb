require 'yaml'

puts 'Destroying searches...'
Search.destroy_all
puts 'Searches destroyed !'

puts '-' * 20

puts 'Destroying users...'
User.destroy_all
puts 'Users destroyed !'

puts '-' * 20

puts 'Destroying results...'
Result.destroy_all
puts 'Results destroyed'

puts '-' * 20

puts 'Destroying types'
Type.destroy_all
puts 'Types destroyed...'

types = %w(Maison Appartement Villa Parking)

print 'Seeding types...'
types.each do |type|
  Type.create!(name: type)
  print '🏡...'
end
print 'Done seeding types...'

print 'Seeding Christian...'
user = User.new(
  first_name: 'Christian',
  last_name: 'Villaescusa',
  email: 'christian.villaescusa@gmail.com',
  password: 'motdepasse',
  phone: '0606060606'
)
user.photo_url = 'https://avatars1.githubusercontent.com/u/25774894'
user.save!
print '👤...'
puts 'Done seeding Christian !'

print 'Seeding searches...'
searches = [
  {city: 'arcachon', type: 'Appartement'},
  {city: 'arcachon', type: 'Maison'},
  {city: 'bordeaux', type: 'Appartement'},
  {city: 'bordeaux', type: 'Maison'}
]

searches.each do |search|
  Search.create!(
    address: search[:city],
    type: Type.find_by(name: search[:type]),
    user: User.first,
    budget: 500000
  )
end
puts 'Done seeding searches !'

print 'Sedding results'
results_yml = YAML.load(open('db/result.yml').read)

results_yml.each do |result|
  type = Type.find_by(name: result['type'])
  result_to_save = Result.new(
    address: result['address'],
    price: result['price'],
    surface: result['surface'],
    description: result['description'],
    search: Search.find_by(type: type, address: result['city'])
  )
  result_to_save.photo_url = result['photo']
  result_to_save.save!
  print '🔍...'
end
print 'Done seeding results ! '

puts 'DONE SEEDING !!! YAAAAAAAAAAAAAAAAAAAAY !!!'
