import 'package:flutter/material.dart';
import 'package:pg_mobile/extensions/build_context_extension.dart';
import 'package:pg_mobile/widgetbook.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({
    super.key,
    required this.iconData,
    required this.titleText,
  });

  final IconData iconData;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 16.0),
          Text(
            titleText,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'SettingsSectionHeader',
  type: SettingsSectionHeader,
  path: '[widgets]/pages/settings',
)
Widget settingsSectionHeader(BuildContext context) {
  return WidgetbookWrapper(
    child: SettingsSectionHeader(
      iconData: Icons.settings,
      titleText: context.knobs.string(
        label: 'Header text',
        initialValue: 'テキスト',
      ),
    ),
  );
}
