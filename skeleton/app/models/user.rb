class User < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: "Enrollment",
    foreign_key: :student_id,
    primary_key: :id
  )
end
