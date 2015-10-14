class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: "Enrollment",
    foreign_key: :course_id,
    primary_key: :id
  )

  has_many(
    :enrolled_students,
    through: :enrollments,    #call self.enrollments (WHERE enrollment.course_id = self.id)
    source: :student      #from that table, gather student id
  )
end
