# pg_mobile
モバイルコース2021年度生の卒業制作です。

## packageのインストール（必須）
```
fvm flutter pub get
```

## コードの自動生成（必須）
```
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## ブランチ運用
- main
- develop
- feature/xxx
- fix/xxx
- release/v1

## ディレクトリ構造
- root
    - assets
        - images
        - fonts
        - （その他の種類のデータを使用するようであれば適宜ディレクトリを追加する）
    - lib
        - debug（本実装前の技術検証用）
        - pages（Figmaの画面遷移図に定義されている各ページ）
            - 各page名のディレクトリ
        - constants（全てのカラー・スタイルなどの定数をここに定義）
        - widgets（UIコンポーネント）
        - providers（riverpod関連）
        - models（状態遷移の時に値渡しする時のクラスやRiverpodで状態管理する時のクラスを定義）
        - repository（API通信, ローカル・リモートのデータのやり取りを行う）
        - util（便利ツール類）
        - extensions(string型やdouble型などの拡張したい時に編集する）
        - main.dart

## .env
プロジェクト設定や秘匿情報を環境変数として`.env`で管理しています。
`.env`は必ずプロジェクトのルートディレクトリ直下に配置してください。
環境変数の追加や削除を行った場合は以下の1〜5を、変更を行った場合は3〜5を実施してください（ただし、`USE_DEBUG_MODE`を除く）。
1. [envied公式ドキュメント](https://pub.dev/packages/envied)等を参考に`lib/config/env.dart`を更新
2. GitHubの[workflows/flutter.yml](https://github.com/shinonome-inc/pg_mobile/blob/develop/.github/workflows/flutter.yml)の`Create .env file`を更新
3. GitHubの[Repository secrets](https://github.com/shinonome-inc/pg_mobile/settings/secrets/actions)を更新
4. [Google Drive](https://drive.google.com/drive/u/2/folders/13gvikBmZyZ6N7OWngaowWR-pT6-DYST4)に最新の`.env`をアップロード
5. `.env`の更新をSlackにて連絡
