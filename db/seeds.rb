# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_role = Role.create!(rolename: 'admin')
Role.create!(rolename: 'manager')
Role.create!(rolename: 'director')
Role.create!(rolename: 'deputy-director')
Role.create!(rolename: 'teacher')
Role.create!(rolename: 'class-manager')
Role.create!(rolename: 'parent')
Role.create!(rolename: 'student')

school = School.create!(school_code: '22772312', school_name: 'спеціалізована загальноосвітня школа I-III ступенів №29',
                        school_email: 'school29@i.ua', school_address_string: 'Україна, Хмельницький, Вокзвльна, 16', 
                        school_phone: '(0382)55-67-00')

admin = User.create!(school_id: school.id, email: 'sd19621504@gmail.com', username: 'Ulysses', 
                     password: 'qwerty', password_confirmation: 'qwerty')
admin.roles << admin_role



