class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: "Enrollment",
    foreign_key: :course_id,
    primary_key: :id
  )
  #SELECT * FROM enrollments WHERE enrollment.course_id = ?

  has_many(
    :enrolled_students,
    through: :enrollments,    #call self.enrollments (WHERE enrollment.course_id = self.id)
    source: :student      #from that table, gather student id
  )

  belongs_to(
    :prerequisite,
    class_name: "Course",
    foreign_key: :prereq_id,
    primary_key: :id
  )

  belongs_to(
    :instructor,
    class_name: "User",
    foreign_key: :instructor_id,
    primary_key: :id
  )

  #SELECT * FROM courses WHERE course.id = self.prereq_id
end
