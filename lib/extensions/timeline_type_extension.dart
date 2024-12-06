import 'package:flutter/material.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/util/timeline_type_converter.dart';

extension TimelineTypeExtension on TimelineType {
  String get text => TimelineTypeConverter.convertTextFromTimelineType(this);

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
