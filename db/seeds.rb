puts 'Destroying users...'
User.destroy_all
puts 'Users destroyed !...'

puts 'Destroying types'
Type.destroy_all
puts 'Types destroyed...'

types = %w(maison appartement villa parcking)

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
user.save!
print '👤...'
print 'Donne seeding Christian...'
