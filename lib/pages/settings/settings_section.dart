import 'package:flutter/material.dart';
import 'package:pg_mobile/pages/settings/settings_section_header.dart';
import 'package:pg_mobile/pages/settings/settings_section_item.dart';
import 'package:pg_mobile/widgetbook.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.header,
    required this.items,
  });

  final SettingsSectionHeader header;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        const SizedBox(height: 16),
        ...items,
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'SettingsSection',
  type: SettingsSection,
  path: '[widgets]/pages/settings',
)
Widget settingsSection(BuildContext context) {
  return WidgetbookWrapper(
    child: SettingsSection(
      header: SettingsSectionHeader(
        iconData: Icons.settings,
        titleText: context.knobs.string(
          label: 'Header text',
          initialValue: 'テキスト',
        ),
      ),
      items: [
        SettingsSectionItem(
          onTap: () {},
          type: SettingsSectionItemType.top,
          title: Text(
            context.knobs.string(
              label: 'Item text 1',
              initialValue: 'テキスト',
            ),
          ),
          action: const Icon(Icons.arrow_forward_ios),
        ),
        SettingsSectionItem(
          onTap: () {},
          title: Text(
            context.knobs.string(
              label: 'Item text 2',
              initialValue: 'テキスト',
            ),
          ),
          action: Text(
            context.knobs.string(
              label: 'Actions text',
              initialValue: 'テキスト',
            ),
          ),
        ),
        SettingsSectionItem(
          type: SettingsSectionItemType.bottom,
          title: Text(
            context.knobs.string(
              label: 'Item text 3',
              initialValue: 'テキスト',
            ),
          ),
          action: Switch(
            value: context.knobs.boolean(
              label: 'switch value',
              initialValue: true,
            ),
            onChanged: (value) {},
          ),
        ),
      ],
    ),
  );
}
