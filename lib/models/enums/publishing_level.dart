/// デフォルトの投稿公開範囲を表す列挙型。
///
/// 詳しい仕様は以下参照。
/// https://docs.joinmastodon.org/user/posting/#privacy
///
enum PublishingLevel {
  /// 全員に公開。
  public,

  /// 未収載（public以外に公開される）。
  quietPublic,

  /// フォロワー限定（フォロワーにのみ公開される）。
  followers,

  /// DM（メンションした人にのみ表示される）。
  specificPeople,
}
