# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.delete_all
trees = Category.create!(name: "Trees")
pots  = Category.create!(name: "Pots")
tools = Category.create!(name: "Tools")
tables = Category.create!(name: "Tables")
other = Category.create!(name: "Other")

Subcategory.delete_all
Subcategory.create!(name: "Coniferous", category_id: trees.id)
Subcategory.create!(name: "Deciduous", category_id: trees.id)
Subcategory.create!(name: "Tropical", category_id: trees.id)
Subcategory.create!(name: "Flowering", category_id: trees.id)
Subcategory.create!(name: "Other", category_id: trees.id)

Subcategory.create!(name: "Mini", category_id: pots.id)
Subcategory.create!(name: "Small", category_id: pots.id)
Subcategory.create!(name: "Medium", category_id: pots.id)
Subcategory.create!(name: "Large", category_id: pots.id)
