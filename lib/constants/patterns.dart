class Patterns {
  Patterns._();

  static final RegExp url = RegExp(r" https?://[\w!?/+\-_~;.,*&@#$%()'[\]]+");
  static final RegExp mention = RegExp(r' @(\w+)');
  static final RegExp hashtagPattern = RegExp(r'#[0-9a-zA-Zぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]+');
}
