class User < ApplicationRecord
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # URI::MailTo::EMAIL_REGEXPはRubyに定義されてるemail判定正規表現
end
