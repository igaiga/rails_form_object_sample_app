class UserRegistrationForm
  include ActiveModel::Model
  # バリデーション機能, form_withに渡せる機能,
  # new(name: "xxx", ...)のようにattributesとあわせて初期化する機能などを足す

  include ActiveModel::Attributes # 型を持つattributesをかんたんに定義できるようにする
  attribute :name, :string
  attribute :email, :string
  attribute :terms_of_service, :boolean

  # このFormObject用のバリデーション（なのでUserモデルと違って良い）
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # URI::MailTo::EMAIL_REGEXPはRubyに定義されてるemail判定正規表現
  validates :terms_of_service, acceptance: { allow_nil: false }
  # acceptanceはチェックボックス確認用 https://railsguides.jp/active_record_validations.html#acceptance

  # 委譲するためにUserモデルをセットできるようにする
  # redirect_to @user のときにUserモデルを取りたいので取得できるようにする
  attr_accessor :user

  def save(...) # ... は全引数を引き渡す記法
    transfer_attributes
    user.save(...) if valid?
  end

  def save!(...)
    transfer_attributes
    user.save!(...) if valid?
  end

  def set_attributes
    self.name = user.name
    self.email = user.email
  end

  private

  def transfer_attributes
    user.name = name
    user.email = email
  end
end

# つかい方の例:
# uf = UserRegistrationForm.new(name: "iga", email: "iga@example.com", terms_of_service: true)
# uf.user = User.new
# if uf.save
#   # 成功時の処理
# else
#   # 失敗時の処理
# end
