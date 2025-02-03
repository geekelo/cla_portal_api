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

cla_cohorts = %w[cohort 1] # Array of cohort names

cla_cohorts.each do |cohort_name| # Using correct variable name
  ClaCohort.find_or_create_by!(name: cohort_name)
end

puts '✅ Cohort seeded successfully!'
