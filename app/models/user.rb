class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :organisation, foreign_key: "user_id"
  has_many :sites, through: :organisation

  def name
    firstname.presence || lastname.presence || email
  end

  def full_name
    name = [firstname, lastname].join(' ')
  end
end
