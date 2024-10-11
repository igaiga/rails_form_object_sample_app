class UserNameForm
  include ActiveModel::Model
  # バリデーション機能、form_withに渡せる機能、
  # new(name: "xxx", ...)のようにattributesとあわせて初期化する機能などを足す
  include ActiveModel::Attributes # 型を持つattributesをかんたんに定義できるようにする

  attribute :name, :string

  # このフォームオブジェクトのバリデーション
  validates :name, presence: true

  # DB保存などの機能を委譲するためにUserモデルをセット可能に
  # redirect_to @user のときなどUserモデルを取りたいので取得もできるようにする
  attr_accessor :user

  def initialize(model: nil, **attrs) # `**`はキーワード引数をHashで受け取る文法
    attrs.symbolize_keys! # StringとSymbolの両対応
    if model
      @user = model
      attrs = {name: @user.name}.merge(attrs) # attrsがあれば優先
    end
    super(**attrs) # もともとのinitializeメソッドを呼び出し
    # `**`はHashをキーワード引数で渡す文法
  end

  def save(...) # ... は全引数を引き渡す記法
    transfer_attributes # フォームオブジェクトからモデルへattributesをセット
    if valid? # フォームオブジェクトのバリデーション実行
      user.save(...)  # モデルのsaveメソッドへ委譲
    else
      false # これがないとvalid?失敗時にnilが返る
    end
    # valid? && user.save(...) # 短く書いても良い
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

  # フォームオブジェクトからモデルへattributesをセット
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
