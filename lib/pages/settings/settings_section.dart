import 'package:flutter/material.dart';
import 'package:pg_mobile/pages/settings/settings_section_header.dart';
import 'package:pg_mobile/pages/settings/settings_section_item.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.header,
    required this.items,
  });

  final SettingsSectionHeader header;
  final List<SettingsSectionItem> items;

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
