class User < ApplicationRecord
  belongs_to :company
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :company_add
  
  private 
  def company_add
    company_find = Company.find_by(name: company_name)
    self.company = company_find || Company.create(name: company_name)
  end
  def company_name
    email.split('@')[1].split('.')[0].capitalize
  end
end
