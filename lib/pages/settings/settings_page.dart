import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/pages/settings/settings_notifier.dart';
import 'package:pg_mobile/pages/settings/settings_section.dart';
import 'package:pg_mobile/pages/settings/settings_section_header.dart';
import 'package:pg_mobile/pages/settings/settings_section_item.dart';
import 'package:pg_mobile/widgets/label/publishing_level_label.dart';
import 'package:pg_mobile/widgets/label/timeline_type_label.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  Future<void> _onTapSignOut() async {
    final isLoading = ref.read(settingsNotifierProvider).isLoading;
    if (isLoading) return;

    final cookieManager = WebViewCookieManager();
    try {
      await cookieManager.clearCookies();
      await ref.read(settingsNotifierProvider.notifier).signOut();
    } catch (e) {
      return;
    }

    if (!mounted) return;
    context.pushReplacement(AppPage.top.path);
  }

  /// TimelineTypeのPopupMenuItemを構築する
  List<PopupMenuEntry<TimelineType>> _buildTimelineTypePopupMenuItems(
    BuildContext context,
  ) {
    return TimelineType.values
        .map(
          (timelineType) => PopupMenuItem<TimelineType>(
            value: timelineType,
            child: TimelineTypeLabel(timelineType: timelineType),
          ),
        )
        .toList();
  }

  /// PublishingLevelのPopupMenuItemを構築する
  List<PopupMenuEntry<PublishingLevel>> _buildPublishingLevelPopupMenuItems(
    BuildContext context,
  ) {
    return PublishingLevel.values
        .map(
          (publishingLevel) => PopupMenuItem<PublishingLevel>(
            value: publishingLevel,
            child: PublishingLevelLabel(publishingLevel: publishingLevel),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsNotifierProvider);
    final appVersion = ref.watch(appVersionProvider).value;
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
                  PopupMenuButton<TimelineType>(
                    initialValue: state.defaultTimelineType,
                    onSelected: notifier.selectDefaultTimelineType,
                    itemBuilder: _buildTimelineTypePopupMenuItems,
                    child: SettingsSectionItem(
                      type: SettingsSectionItemType.top,
                      title: const Text('デフォルトのタイムライン'),
                      action: Row(
                        children: [
                          TimelineTypeLabel(
                            timelineType: state.defaultTimelineType,
                          ),
                          SizedBox(width: 8.w),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton<PublishingLevel>(
                    initialValue: state.defaultPublishingLevel,
                    onSelected: notifier.selectDefaultPublishingLevel,
                    itemBuilder: _buildPublishingLevelPopupMenuItems,
                    child: SettingsSectionItem(
                      type: SettingsSectionItemType.bottom,
                      title: const Text('デフォルトの公開範囲'),
                      action: Row(
                        children: [
                          PublishingLevelLabel(
                            publishingLevel: state.defaultPublishingLevel,
                          ),
                          SizedBox(width: 8.w),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
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
                    title: const Text('アプリバージョン'),
                    action: Text('v $appVersion'),
                  ),
                  SettingsSectionItem(
                    onTap: () {
                      // TODO: 利用規約のWebページに遷移する。
                    },
                    title: const Text('利用規約'),
                    action: const Icon(Icons.arrow_forward_ios),
                  ),
                  SettingsSectionItem(
                    onTap: () {
                      // TODO: プライバシーポリシーのWebページに遷移する。
                    },
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
                    onTap: _onTapSignOut,
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
