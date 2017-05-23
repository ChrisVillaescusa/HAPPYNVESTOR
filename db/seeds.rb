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
