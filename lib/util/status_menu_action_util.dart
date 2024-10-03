import 'package:flutter/material.dart';
import 'package:pg_mobile/extensions/status_menu_action_extension.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';

/// StatusMenuActionに関するユーティリティクラスです。
class StatusMenuActionUtil {
  StatusMenuActionUtil._();

  /// StatusMenuActionのリストを作成するメソッド
  static List<StatusMenuAction> _createStatusMenuActions({
    required Status status,
    required VoidCallback onCopyLink,
    required VoidCallback onPinToProfile,
    required VoidCallback onDeleteAndReturnToDraft,
    required VoidCallback onDelete,
    required VoidCallback onMute,
    required VoidCallback onBlock,
    required VoidCallback onCancel,
  }) {
    return <StatusMenuAction>[
      StatusMenuAction(
        onPressed: onCopyLink,
        text: 'リンクをコピー',
        type: StatusMenuActionType.common,
      ),
      StatusMenuAction(
        onPressed: onPinToProfile,
        text: 'プロフィールに固定',
        type: StatusMenuActionType.onlySignedInUser,
      ),
      StatusMenuAction(
        onPressed: onDeleteAndReturnToDraft,
        text: '削除して下書きに戻す',
        type: StatusMenuActionType.onlySignedInUser,
        isDestructiveAction: true,
      ),
      StatusMenuAction(
        onPressed: onDelete,
        text: '削除',
        type: StatusMenuActionType.onlySignedInUser,
        isDestructiveAction: true,
      ),
      StatusMenuAction(
        onPressed: onMute,
        text: '${status.account.username}さんをミュート',
        type: StatusMenuActionType.onlyNotSignedInUser,
      ),
      StatusMenuAction(
        onPressed: onBlock,
        text: '${status.account.username}さんをブロック',
        type: StatusMenuActionType.onlyNotSignedInUser,
        isDestructiveAction: true,
      ),
      StatusMenuAction(
        onPressed: onCancel,
        text: 'キャンセル',
        type: StatusMenuActionType.cancel,
        isDestructiveAction: true,
      ),
    ];
  }

  /// ユーザーに応じてアクションをフィルタリングする。
  static List<StatusMenuAction> _filterActionsByUser({
    required List<StatusMenuAction> actions,
    required bool isSignedInUser,
  }) {
    if (isSignedInUser) {
      // サインインしているユーザー向けのアクションを保持
      return actions.where((action) => !action.isOnlyNotSignedInUser).toList();
    } else {
      // サインインしていないユーザー向けのアクションを保持
      return actions.where((action) => !action.isOnlySignedInUser).toList();
    }
  }

  /// ユーザーに応じてフィルタリングされたStatusMenuActionsのリストを取得する
  static List<StatusMenuAction> getStatusMenuActions({
    required Status status,
    required bool isSignedInUser,
    required VoidCallback onCopyLink,
    required VoidCallback onPinToProfile,
    required VoidCallback onDeleteAndReturnToDraft,
    required VoidCallback onDelete,
    required VoidCallback onMute,
    required VoidCallback onBlock,
    required VoidCallback onCancel,
  }) {
    // アクションリスト生成
    final actions = _createStatusMenuActions(
      status: status,
      onCopyLink: onCopyLink,
      onPinToProfile: onPinToProfile,
      onDeleteAndReturnToDraft: onDeleteAndReturnToDraft,
      onDelete: onDelete,
      onMute: onMute,
      onBlock: onBlock,
      onCancel: onCancel,
    );

    // ユーザーに基づいてフィルタリング
    return _filterActionsByUser(
      actions: actions,
      isSignedInUser: isSignedInUser,
    );
  }
}
