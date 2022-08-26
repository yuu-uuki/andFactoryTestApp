# andFactoryTestApp

#### Githubのユーザーを検索し表示するアプリ

- MVVMアーキテクチャを使用し作成。

- 検索Barに入力された文字を検知しユーザー情報をリクエスト(Githubユーザー検索API)。  
レスポンスが来たらユーザーリストを画面へ表示する。

- リストのユーザーをタップするとGithubのユーザーページへと遷移

# アーキテクチャ
### MVVM
#### Model
- GithubSearchAPIModel  APIリクエストモデル

#### View
- GithubUserListViewController  ユーザーの一覧を表示する画面
- GithubUserDetailViewController  ユーザーの詳細画面

#### ViewModel
- GithubUserSearchViewModel  Viewの検索バーに入力を検知しモデルへAPIリクエスト

# クローン
```
git clone https://github.com/yuu-uuki/andFactoryTestApp.git
```

# ライブラリ

- RxSwift (データバインディング)
- RxCocoa
- Alamofire (HTTP通信)
- PKHUD　(インジケータ)
- SwiftLint (静的解析ツール)

# インストール

```
pod install
```

# Author

* 田中裕貴
* yuu99.331@gmail.com
