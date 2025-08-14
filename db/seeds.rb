# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

cla_roles = %w[student facilitator alumni admin]

cla_roles.each do |role_name|
  ClaRole.find_or_create_by!(name: role_name)
end
puts '✅ Roles seeded successfully!'

cla_roles = %w[student facilitator alumni admin]

# db/seeds.rb

# Define an array of cohort data. IT KEEPS CREATING COHORT. THEY ARE ONLY NECESSARY ON FRESH DEPLOY
# cohorts_data = [
#   { name: 'Spring 2025', start_date: '2025-03-01', end_date: '2025-06-30' },
#   { name: 'Summer 2025', start_date: '2025-07-01', end_date: '2025-09-30' },
#   { name: 'Fall 2025',   start_date: '2025-09-01', end_date: '2025-12-31' }
# ]

# # Create or find cohorts based on the name attribute.
# cohorts_data.each do |data|
#   ClaCohort.find_or_create_by!(name: data[:name]) do |cohort|
#     cohort.start_date = data[:start_date]
#     cohort.end_date   = data[:end_date]
#   end
# end

puts '✅ Cohorts seeded successfully!'

# Seed the admin user.
admin_email = 'admin@example.com'
admin_password = 'securepassword'  # Replace with a strong password in production

admin_user = ClaUser.find_or_initialize_by(email: admin_email)
admin_user.assign_attributes(
  name: 'Admin User',
  password: admin_password,
  password_confirmation: admin_password,
  cla_role_id: 2,
  cla_cohort_id: nil
)
admin_user.save!

puts '✅ Admin user seeded successfully!'