
puts 'Destroying users...'
User.destroy_all
puts 'Users destroyed !...'


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
