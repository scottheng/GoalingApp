class Goal < ActiveRecord::Base
  validates(
    :title,
    :description,
    :user,
    presence: true
  )

  validates :is_public, inclusion: [true, false]

  belongs_to :user


end
