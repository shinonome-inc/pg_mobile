class Patterns {
  Patterns._();

  static final RegExp url =
      RegExp(r"(?:^|[\n\s])https?://[\w!?/+\-_~;.,*&@#$%()'[\]]+");
  static final RegExp mention = RegExp(r'(?:^|[\n\s])@(\w+)');
  static final RegExp hashtagPattern = RegExp(r'#[0-9a-zA-Zぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]+');
}
