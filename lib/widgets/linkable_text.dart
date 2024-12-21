import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/patterns.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:url_launcher/url_launcher.dart';

/// テキストのURL、メンション、ハッシュタグをタップ可能にするWidgetです。
class LinkableText extends StatefulWidget {
  const LinkableText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  State<LinkableText> createState() => _LinkableTextState();
}

class _LinkableTextState extends State<LinkableText> {
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> _onTapMention(String mention) async {
    context.push(AppPage.user.path);
  }

  Future<void> _onTapHashtag(String hashtag) async {
    context.push(AppPage.hashTag.path);
  }

  List<Match> _matchList() {
    final List<Match> matches = [];

    final urlMatches = Patterns.statusUrl.allMatches(widget.text);
    final mentionMatches = Patterns.mention.allMatches(widget.text);
    final hashtagMatches = Patterns.hashtag.allMatches(widget.text);

    matches.addAll(urlMatches);
    matches.addAll(mentionMatches);
    matches.addAll(hashtagMatches);
    matches.sort((a, b) => a.start.compareTo(b.start));

    return matches;
  }

  List<TextSpan> textSpanList(List<Match> allMatches) {
    final textSpans = <TextSpan>[];
    int currentPosition = 0;

    for (var match in allMatches) {
      if (currentPosition < match.start) {
        final textPart = widget.text.substring(currentPosition, match.start);
        textSpans.add(
          TextSpan(text: textPart),
        );
      }

      final matchedText = widget.text.substring(match.start, match.end);
      if (Patterns.statusUrl.hasMatch(matchedText)) {
        final url = matchedText.replaceAll(' ', '').replaceAll('\n', '');
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: const TextStyle(color: AppColors.blue),
            recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
          ),
        );
      } else if (Patterns.mention.hasMatch(matchedText)) {
        final mention = matchedText.replaceAll(' ', '').replaceAll('\n', '');
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: const TextStyle(color: AppColors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _onTapMention(mention),
          ),
        );
      } else if (Patterns.hashtag.hasMatch(matchedText)) {
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: const TextStyle(color: AppColors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _onTapHashtag(matchedText),
          ),
        );
      }

      currentPosition = match.end;
    }
    if (currentPosition < widget.text.length) {
      final remainingText = widget.text.substring(currentPosition);
      textSpans.add(
        TextSpan(text: remainingText),
      );
    }
    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    final allMatches = _matchList();
    final textSpans = textSpanList(allMatches);
    return SelectableText.rich(
      allMatches.isEmpty
          ? TextSpan(text: widget.text)
          : TextSpan(children: textSpans),
    );
  }
}
