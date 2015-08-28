require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('./lib/**/*.rb')
require('./lib/teacher')
require('./lib/student')
require('pg')
require('pry')

get('/') do
  erb(:index)
end

get('/teachers') do
  @teachers = Teacher.all()
  erb(:teachers)
end

get('/teachers/:id') do
  teacher_id = params.fetch("id").to_i
  @teacher = Teacher.find(teacher_id)
  @students = @teacher.students
  @all_students = Student.all
  erb(:teacher)
end

post('/teachers/new') do
  teacher_name = params.fetch('name')
  Teacher.create({:name => teacher_name})
  redirect('/teachers')
end

post('/teachers/:id/students/new') do
  teacher_id = params.fetch("id").to_i
  @teacher = Teacher.find(teacher_id)
  student_name = params.fetch('name')
  new_student = Student.create({:name => student_name})
  @teacher.students.push(new_student)
  redirect('/teachers/' + @teacher.id.to_s())
end


get('/students') do
  @students = Student.all()
  erb(:students)
end

get('/students/:id') do
  student_id = params.fetch("id").to_i
  @student = Student.find(student_id)
  @teachers = @student.teachers
  erb(:student)
end

post('/students/new') do
  student_name = params.fetch('name')
  Student.create({:name => student_name})
  redirect('/students')
end

patch('/update_students') do
  teacher_id = params.fetch('teacher_id').to_i
  @teacher = Teacher.find(teacher_id)
  student_ids = params.fetch("student_ids")
  @teacher.update({:student_ids => student_ids})
  redirect('/teachers/' + @teacher.id.to_s())
end

post('/students/:id/teachers/new') do
  student_id = params.fetch("id").to_i
  @student = Student.find(student_id)
  teacher_name = params.fetch('name')
  new_teacher = Teacher.create({:name => teacher_name})
  @student.teachers.push(new_teacher)
  redirect('/students/' + @student.id.to_s())
end
