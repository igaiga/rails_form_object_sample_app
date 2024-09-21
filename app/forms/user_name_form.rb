class UserNameForm
  include ActiveModel::Attributes # 型を持つattributesをかんたんに定義できるようにする
  attribute :name, :string

  include ActiveModel::Model
  # バリデーション機能、form_withに渡せる機能、
  # new(name: "xxx", ...)のようにattributesとあわせて初期化する機能などを足す

  # このFormObjectのバリデーション
  validates :name, presence: true

  # DB保存などの機能を委譲するためにUserモデルをセット可能に
  # redirect_to @user のときなどUserモデルを取りたいので取得もできるようにする
  attr_accessor :user

  def initialize(model: nil, **attrs)
    attrs.symbolize_keys!
    if model
      @user = model
      attrs = {name: @user.name}.merge(attrs)
    end
    super(**attrs)
  end

  def save(...) # ... は全引数を引き渡す記法
    transfer_attributes
    if valid?
      user.save(...)
    else
      false # モデルのsave失敗時の戻り値に揃える
    end
    # valid? || user.save(...) # 短く書いても良い
  end

  def form_with_options
    if user.persisted?
      # update用
      { url: Rails.application.routes.url_helpers.name_path(user), method: :patch }
    else
      # create用
      { url: Rails.application.routes.url_helpers.names_path, method: :post }
    end
  end

  private

  # FormObjectからモデルへattributesをセット
  def transfer_attributes
    user.name = name
  end
end

# つかい方の例:
# uf = UserNameForm.new(model: User.new, name: "iga")
# if uf.save
#   # 成功時の処理
# else
#   # 失敗時の処理
# end
