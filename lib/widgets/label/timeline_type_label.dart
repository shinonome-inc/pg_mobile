import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/timeline_type_extension.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class TimelineTypeLabel extends StatelessWidget {
  const TimelineTypeLabel({
    super.key,
    required this.timelineType,
  });

  final TimelineType timelineType;

  final _foregroundColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          timelineType.icon,
          color: _foregroundColor,
        ),
        const SizedBox(width: 8.0),
        Text(
          timelineType.text,
          style: TextStyle(color: _foregroundColor),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'TimelineTypeLabelLocal',
  type: TimelineTypeLabel,
  path: '[common]/widgets/label',
)
Widget timelineTypeLabelLocal(BuildContext context) {
  return const WidgetbookWrapper(
    child: TimelineTypeLabel(timelineType: TimelineType.local),
  );
}

@widgetbook.UseCase(
  name: 'TimelineTypeLabelHome',
  type: TimelineTypeLabel,
  path: '[common]/widgets/label',
)
Widget timelineTypeLabelHome(BuildContext context) {
  return const WidgetbookWrapper(
    child: TimelineTypeLabel(timelineType: TimelineType.home),
  );
}

@widgetbook.UseCase(
  name: 'TimelineTypeLabelMedia',
  type: TimelineTypeLabel,
  path: '[common]/widgets/label',
)
Widget timelineTypeLabelMedia(BuildContext context) {
  return const WidgetbookWrapper(
    child: TimelineTypeLabel(timelineType: TimelineType.media),
  );
}
