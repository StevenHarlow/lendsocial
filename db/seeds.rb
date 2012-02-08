# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if LoanPurpose.count.zero?
  LoanPurpose.create([
    { description: 'Expanding Business' },
    { description: 'Purchasing Inventory/Equipment' },
    { description: 'Real Estate Purchase' },
    { description: 'Acquisitions' },
    { description: 'General Expenses' },
    { description: 'Other' }
    ])
  end
    

if MessageType.count.zero?
  MessageType.create([
    { description: 'Status' },
    { description: 'Post' }
    ])
end

