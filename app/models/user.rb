class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :reservations, dependent: :destroy
         has_one :restaurant , dependent: :destroy
         validates :Phone_Number, :length => {:is => 10}


end
