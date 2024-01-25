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

## .env
プロジェクト設定や秘匿情報を環境変数として`.env`で管理しています。
`.env`は必ずプロジェクトのルートディレクトリ直下に配置してください。
環境変数の追加や削除を行った場合は以下の1〜5を、変更を行った場合は1, 2, 3, 5を実施してください（ただし、`USE_DEBUG_MODE`を除く）。
1. Google Driveに最新の`.env`をアップロード
2. [envied公式ドキュメント](https://pub.dev/packages/envied)等を参考に`lib/config/env.dart`を更新
3. GitHubの[Repository secrets](https://github.com/shinonome-inc/pg_mobile/settings/secrets/actions)を更新
4. GitHubの[workflows/flutter.yml](https://github.com/shinonome-inc/pg_mobile/blob/develop/.github/workflows/flutter.yml)の`Create .env file`を更新
5. `.env`の更新をSlackにて連絡
