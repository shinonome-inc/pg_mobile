import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/debug_page.dart';
import 'package:pg_mobile/pages/boost_user_list/boost_user_list_page.dart';
import 'package:pg_mobile/pages/create_status/create_status_page.dart';
import 'package:pg_mobile/pages/favorite_user_list/favorite_user_list_page.dart';
import 'package:pg_mobile/pages/follower_list/follower_list_page.dart';
import 'package:pg_mobile/pages/following_list/following_list_page.dart';
import 'package:pg_mobile/pages/hash_tag/hash_tag_page.dart';
import 'package:pg_mobile/pages/launch/launch_page.dart';
import 'package:pg_mobile/pages/my_page/my_page.dart';
import 'package:pg_mobile/pages/notifications/notification_page.dart';
import 'package:pg_mobile/pages/settings/settings_page.dart';
import 'package:pg_mobile/pages/sign_in/sign_in_page.dart';
import 'package:pg_mobile/pages/status_detail/status_detail_page.dart';
import 'package:pg_mobile/pages/timeline/timeline_page.dart';
import 'package:pg_mobile/pages/top/top_page.dart';
import 'package:pg_mobile/pages/user/user_page.dart';

/// アプリ内の画面に関する列挙型。
enum AppPage {
  debug, // TODO: 技術調査用なので、本実装が始まったら削除する。
  launch,
  top,
  signIn,
  timeline,
  statusDetail,
  createStatus,
  user,
  hashTag,
  favoriteUserList,
  boostUserList,
  followingList,
  followerList,
  notification,
  myPage,
  settings;

  String get path {
    switch (this) {
      case AppPage.debug:
        return '/debug';
      case AppPage.launch:
        return '/';
      case AppPage.top:
        return '/top';
      case AppPage.signIn:
        return '/sign_in';
      case AppPage.timeline:
        return '/timeline';
      case AppPage.statusDetail:
        return '/status_detail';
      case AppPage.createStatus:
        return '/create_status';
      case AppPage.user:
        return '/user';
      case AppPage.hashTag:
        return '/hash_tag';
      case AppPage.favoriteUserList:
        return '/favorite_user_list';
      case AppPage.boostUserList:
        return '/boost_user_list';
      case AppPage.followingList:
        return '/following_list';
      case AppPage.followerList:
        return '/follower_list';
      case AppPage.notification:
        return '/notification';
      case AppPage.myPage:
        return '/my_page';
      case AppPage.settings:
        return '/settings';
    }
  }

  Widget get child {
    switch (this) {
      case AppPage.debug:
        return const DebugPage();
      case AppPage.launch:
        return const LaunchPage();
      case AppPage.top:
        return const TopPage();
      case AppPage.signIn:
        return const SignInPage();
      case AppPage.timeline:
        return const TimelinePage();
      case AppPage.statusDetail:
        return const StatusDetailPage();
      case AppPage.createStatus:
        return const CreateStatusPage();
      case AppPage.user:
        return const UserPage();
      case AppPage.hashTag:
        return const HashTagPage();
      case AppPage.favoriteUserList:
        return const FavoriteUserListPage();
      case AppPage.boostUserList:
        return const BoostUserListPage();
      case AppPage.followingList:
        return const FollowingListPage();
      case AppPage.followerList:
        return const FollowerListPage();
      case AppPage.notification:
        return const NotificationPage();
      case AppPage.myPage:
        return const MyPage();
      case AppPage.settings:
        return const SettingsPage();
    }
  }
}
