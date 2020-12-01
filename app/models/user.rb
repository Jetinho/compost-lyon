class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :organisation, foreign_key: "user_id", class_name: 'CollectiveComposting::Organisation'
  has_many :sites, through: :organisations

  def name
    firstname.presence || lastname.presence || email
  end

  def full_name
    name = [firstname, lastname].join(' ')
  end
end
