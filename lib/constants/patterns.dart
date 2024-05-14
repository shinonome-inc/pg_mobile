class Patterns {
  Patterns._();

  /// 通常のURLパターン
  static final RegExp url = RegExp(r"https?://[\w!?/+\-=_~;.,*&@#$%()'[\]]+");

  /// Mastodon本文にURLが含まれているかどうか判定するためのURLパターン
  static final RegExp statusUrl =
      RegExp(r"(?:^|[\n\s])https?://[\w!?/+\-=_~;.,*&@#$%()'[\]]+");

  static final RegExp mention = RegExp(r'(?:^|[\n\s])@(\w+)');
  static final RegExp hashtag = RegExp(r'#[0-9a-zA-Zぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠_]+');
}
