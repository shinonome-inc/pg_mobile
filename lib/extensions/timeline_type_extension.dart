import 'package:flutter/material.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';

extension TimelineTypeExtension on TimelineType {
  String get text {
    switch (this) {
      case TimelineType.local:
        return 'ローカル';
      case TimelineType.home:
        return 'ホーム';
      case TimelineType.media:
        return 'メディア';
    }
  }

  IconData get icon {
    switch (this) {
      case TimelineType.local:
        return Icons.public_outlined;
      case TimelineType.home:
        return Icons.home_outlined;
      case TimelineType.media:
        return Icons.image_outlined;
    }
  }
}
