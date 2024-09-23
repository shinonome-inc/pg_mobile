enum NotificationType {
  mention,
  status,
  reblog,
  follow,
  followRequest,
  favorite,
  poll,
  update,
  signUp,
  report,
  severedRelationships;

  String get text {
    switch (this) {
      case NotificationType.mention:
        return 'mention';
      case NotificationType.status:
        return 'status';
      case NotificationType.reblog:
        return 'reblog';
      case NotificationType.follow:
        return 'follow';
      case NotificationType.followRequest:
        return 'follow_request';
      case NotificationType.favorite:
        return 'favorite';
      case NotificationType.poll:
        return 'poll';
      case NotificationType.update:
        return 'update';
      case NotificationType.signUp:
        return 'admin.sign_up';
      case NotificationType.report:
        return 'admin.report';
      case NotificationType.severedRelationships:
        return 'severed_relationships';
    }
  }
}
