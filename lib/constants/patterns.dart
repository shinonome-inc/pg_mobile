class Patterns {
  Patterns._();

  /// 通常のURLパターン
  static final RegExp url = RegExp(
      r'((https?:\/\/)|(https?:www\.)|(www\.))[a-zA-Z0-9-]{1,256}\.[a-zA-Z0-9]{2,6}(\/[a-zA-Z0-9亜-熙ぁ-んァ-ヶ()@:%_\+.~#?&\/=-]*)?');

  /// Mastodon本文にURLが含まれているかどうか判定するためのURLパターン
  static final RegExp statusUrl =
      RegExp(r"(?:^|[\n\s])https?://[\w!?/+\-=_~;.,*&@#$%()'[\]]+");

  static final RegExp mention = RegExp(r'(?:^|[\n\s])@(\w+)');
  static final RegExp hashtag = RegExp(r'#[0-9a-zA-Zぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠_]+');
}
