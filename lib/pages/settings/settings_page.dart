import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/pages/settings/settings_notifier.dart';
import 'package:pg_mobile/pages/settings/settings_section.dart';
import 'package:pg_mobile/pages/settings/settings_section_header.dart';
import 'package:pg_mobile/pages/settings/settings_section_item.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsNotifierProvider);
    final appVersion = ref.watch(
      appVersionProvider(fetchPackageInfo: PackageInfo.fromPlatform),
    );
    final notifier = ref.read(settingsNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.gray1,
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              SettingsSection(
                header: const SettingsSectionHeader(
                  iconData: Icons.settings,
                  titleText: 'タイムライン',
                ),
                items: [
                  SettingsSectionItem(
                    onTap: () {},
                    type: SettingsSectionItemType.top,
                    title: const Text('デフォルトのタイムライン'),
                    action: Row(
                      children: [
                        const Icon(Icons.public),
                        SizedBox(width: 8.w),
                        const Text('ローカル'),
                        SizedBox(width: 8.w),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  SettingsSectionItem(
                    onTap: () {},
                    type: SettingsSectionItemType.bottom,
                    title: const Text('デフォルトの公開範囲'),
                    action: Row(
                      children: [
                        const Icon(Icons.public),
                        SizedBox(width: 8.w),
                        const Text('ローカル'),
                        SizedBox(width: 8.w),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              SettingsSection(
                header: const SettingsSectionHeader(
                  iconData: Icons.notifications,
                  titleText: 'アプリ内通知',
                ),
                items: [
                  SettingsSectionItem(
                    type: SettingsSectionItemType.top,
                    title: const Text('いいね'),
                    action: Switch(
                      value: state.enableLikesNotification,
                      onChanged: notifier.switchEnableLikesNotification,
                    ),
                  ),
                  SettingsSectionItem(
                    title: const Text('ブースト'),
                    action: Switch(
                      value: state.enableReblogsNotification,
                      onChanged: notifier.switchEnableReblogsNotification,
                    ),
                  ),
                  SettingsSectionItem(
                    title: const Text('メンション'),
                    action: Switch(
                      value: state.enableMentionsNotification,
                      onChanged: notifier.switchEnableMentionsNotification,
                    ),
                  ),
                  SettingsSectionItem(
                    type: SettingsSectionItemType.bottom,
                    title: const Text('フォロー'),
                    action: Switch(
                      value: state.enableFollowsNotification,
                      onChanged: notifier.switchEnableFollowsNotification,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              SettingsSection(
                header: const SettingsSectionHeader(
                  iconData: Icons.settings,
                  titleText: 'アプリ情報',
                ),
                items: [
                  SettingsSectionItem(
                    type: SettingsSectionItemType.top,
                    onTap: () {},
                    title: const Text('アプリバージョン'),
                    action: switch (appVersion) {
                      AsyncData(:final value) => Text('v ${value}'),
                      _ => const Text('v'),
                    },
                  ),
                  SettingsSectionItem(
                    onTap: () {},
                    title: const Text('利用規約'),
                    action: const Icon(Icons.arrow_forward_ios),
                  ),
                  SettingsSectionItem(
                    onTap: () {},
                    type: SettingsSectionItemType.bottom,
                    title: const Text('プライバシーポリシー'),
                    action: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              SettingsSection(
                header: const SettingsSectionHeader(
                  iconData: Icons.logout,
                  titleText: 'ログアウト',
                ),
                items: [
                  SettingsSectionItem(
                    onTap: () {},
                    type: SettingsSectionItemType.single,
                    title: const Text('ログアウトする'),
                    action: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              SizedBox(height: 160.h),
            ],
          ),
        ),
      ),
    );
  }
}
