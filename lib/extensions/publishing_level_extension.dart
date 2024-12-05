import 'package:flutter/material.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';

extension PublishingLevelExtension on PublishingLevel {
  String get text {
    switch (this) {
      case PublishingLevel.public:
        return 'ローカル';
      case PublishingLevel.quietPublic:
        return '未収載';
      case PublishingLevel.followers:
        return 'フォロワー限定';
      case PublishingLevel.specificPeople:
        return 'DM';
    }
  }

  IconData get icon {
    switch (this) {
      case PublishingLevel.public:
        return Icons.public_outlined;
      case PublishingLevel.quietPublic:
        return Icons.nightlight_outlined;
      case PublishingLevel.followers:
        return Icons.lock_outline;
      case PublishingLevel.specificPeople:
        return Icons.mail_outline;
    }
  }
}
