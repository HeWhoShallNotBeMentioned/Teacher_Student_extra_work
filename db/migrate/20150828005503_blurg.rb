class Blurg < ActiveRecord::Migration
  def change
    create_table(:teachers) do |t|
      t.column(:name, :string)

      t.timestamp()
    end
    create_table(:students) do |s|
      s.column(:name, :string)

      s.timestamp()
    end
    create_table(:students_teachers) do |s|
      s.column(:teacher_id, :integer)
      s.column(:student_id, :integer)

      s.timestamp()
    end
  end
end
