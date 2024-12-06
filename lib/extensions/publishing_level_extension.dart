import 'package:flutter/material.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/util/publishing_level_util.dart';

extension PublishingLevelExtension on PublishingLevel {
  String get text =>
      PublishingLevelConverter.convertTextFromPublishingLevel(this);

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
