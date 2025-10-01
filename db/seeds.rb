# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create admin user
admin = User.find_or_create_by!(email: 'siddharthadhakall3722@gmail.com') do |user|
  user.name = 'GuruOrGoru'
  user.password = 'Balakotalu77'
  user.password_confirmation = 'Balakotalu77'
  user.admin = true
end

# Ensure admin is set
admin.update(admin: true) if admin.persisted?

puts "Admin user created/updated:"
puts "Email: siddharthadhakall3722@gmail.com"
puts "Password: Balakotalu77"
puts "Username: GuruOrGoru"
