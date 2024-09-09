class UserNameForm
  include ActiveModel::Model
  # バリデーション機能, form_withに渡せる機能,
  # new(name: "xxx", ...)のようにattributesとあわせて初期化する機能などを足す

  include ActiveModel::Attributes # 型を持つattributesをかんたんに定義できるようにする
  attribute :name, :string

  # このFormObject用のバリデーション
  validates :name, presence: true

  # DB保存などの機能を委譲するためにUserモデルをセット可能に
  def user=(u)
    @user = u
    set_attributes
  end

  # redirect_to @user のときなどUserモデルを取りたいので取得もできるようにする
  def user
    @user
  end

  def save(...) # ... は全引数を引き渡す記法
    transfer_attributes
    user.save(...) if valid?
  end

  def save!(...)
    transfer_attributes
    user.save!(...) if valid?
  end

  private

  # FormObjectにモデルからattributesをセット
  def set_attributes
    self.name = user.name
  end

  # FormObjectからモデルへattributesをセット
  def transfer_attributes
    user.name = name
  end
end

# つかい方の例:
# uf = UserNameForm.new(name: "iga")
# uf.user = User.new
# if uf.save
#   # 成功時の処理
# else
#   # 失敗時の処理
# end
