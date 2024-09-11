class User < ApplicationRecord
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, message: "must be in the format XXX-XXX-XXXX" } 
    validate :birthday_cannot_be_in_the_future
  
    private
  
    def birthday_cannot_be_in_the_future
      if birthday.present? && birthday > Date.today
        errors.add(:birthday, "can't be in the future")
      end
    end
end
