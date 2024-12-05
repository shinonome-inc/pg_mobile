import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/publishing_level_extension.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class PublishingLevelLabel extends StatelessWidget {
  const PublishingLevelLabel({
    super.key,
    required this.publishingLevel,
  });

  final PublishingLevel publishingLevel;

  final _foregroundColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          publishingLevel.icon,
          color: _foregroundColor,
        ),
        const SizedBox(width: 8.0),
        Text(
          publishingLevel.text,
          style: TextStyle(color: _foregroundColor),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'PublishingLevelLabelPublic',
  type: PublishingLevelLabel,
  path: '[common]/widgets/label',
)
Widget publishingLevelLabelPublic(BuildContext context) {
  return const WidgetbookWrapper(
    child: PublishingLevelLabel(
      publishingLevel: PublishingLevel.public,
    ),
  );
}

@widgetbook.UseCase(
  name: 'PublishingLevelLabelQuietPublic',
  type: PublishingLevelLabel,
  path: '[common]/widgets/label',
)
Widget publishingLevelLabelQuietPublic(BuildContext context) {
  return const WidgetbookWrapper(
    child: PublishingLevelLabel(
      publishingLevel: PublishingLevel.quietPublic,
    ),
  );
}

@widgetbook.UseCase(
  name: 'PublishingLevelLabelFollowers',
  type: PublishingLevelLabel,
  path: '[common]/widgets/label',
)
Widget publishingLevelLabelFollowers(BuildContext context) {
  return const WidgetbookWrapper(
    child: PublishingLevelLabel(
      publishingLevel: PublishingLevel.followers,
    ),
  );
}

@widgetbook.UseCase(
  name: 'PublishingLevelLabelSpecificPeople',
  type: PublishingLevelLabel,
  path: '[common]/widgets/label',
)
Widget publishingLevelLabelSpecificPeople(BuildContext context) {
  return const WidgetbookWrapper(
    child: PublishingLevelLabel(
      publishingLevel: PublishingLevel.specificPeople,
    ),
  );
}
