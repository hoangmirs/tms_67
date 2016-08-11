# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Hoang Mirs",
             email: "hoang@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: 2)

20.times do |n|
  name = Faker::Name.name
  email = "trainee-#{n+1}@gmail.com"
  password = "111111"
  User.create!(name: name, email: email, password: password,
               password_confirmation: password, role: 0)
end

12.times do |n|
  name = "Fake subject #{n+1}"
  instructions = Faker::Lorem.paragraphs.first
  tasks = {}
  4.times do |m|
    tasks["#{m}"] = {name: "Fake task #{m}"}
  end
  Subject.create! name: name,
                  instructions: instructions,
                  tasks_attributes: tasks
end

# course_1 = Course.create! name: "Course 1", user_ids: 1,
#                           instructions: "Course 1 instruction",
#                           status: 0,
#                           start_date: Time.now,
#                           end_date: Time.now,
#                           subjects_attributes: {
#                             "0": {name: "Subject 1",
#                                   instructions: "Subject 1 instruction",
#                                   tasks_attributes: {
#                                     "0": {name: "Task 1"},
#                                     "1": {name: "Task 2"}
#                                   }},
#                             "1": {name: "Subject 2",
#                                   instructions: "Subject 2 instruction"},
#                             "2": {name: "Subject 3",
#                                   instructions: "Subject 3 instruction"}
#                           }
#
# course_subject = CourseSubject.create! subject_id: 1,
#                                        course_id: 1, status: 0
#
# course_2 = Course.create! name: "Course 2", user_ids: 2,
#                           instructions: "Course 2 instruction",
#                           status: 0,
#                           start_date: Time.now,
#                           subjects_attributes: {
#                             "0": {name: "Subject 1",
#                                   instructions: "Subject 1 instruction",
#                                   tasks_attributes: {
#                                     "0": {name: "Task 1"},
#                                     "1": {name: "Task 2"}
#                                   }},
#                             "1": {name: "Subject 2",
#                                   instructions: "Subject 2 instruction"},
#                             "2": {name: "Subject 3",
#                                   instructions: "Subject 3 instruction"}
#                           }
#
# course_3= Course.create! name: "Course 3", user_ids: 1,
#                          instructions: "Course 3 instruction",
#                          status: 0,
#                          start_date: Time.now,
#                          subjects_attributes: {
#                            "0": {name: "Subject 1",
#                                  instructions: "Subject 1 instruction",
#                                  tasks_attributes: {
#                                    "0": {name: "Task 1"},
#                                    "1": {name: "Task 2"}
#                                  }},
#                            "1": {name: "Subject 2",
#                                  instructions: "Subject 2 instruction"},
#                            "2": {name: "Subject 3",
#                                  instructions: "Subject 3 instruction"}
#                          }
#
# 5.times do |n|
#   UserCourse.create! user_id: n + 5,
#                      course_id: course_1.id,
#                      supervisor: 0,
#                      status: 0
# end
#
# UserCourse.create! user_id: 2,
#                    course_id: course_1.id,
#                    supervisor: 1,
#                    status: 0
