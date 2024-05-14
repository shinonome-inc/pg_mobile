import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/patterns.dart';
import 'package:url_launcher/url_launcher.dart';

/// テキストのURL、メンション、ハッシュタグをタップ可能にするWidgetです。
class LinkableText extends StatelessWidget {
  const LinkableText(
    this.text, {
    super.key,
    this.onTapUrl,
    required this.onTapMention,
    required this.onTapHashtag,
  });

  final String text;

  final void Function(String)? onTapUrl;
  final void Function(String) onTapMention;
  final void Function(String) onTapHashtag;

  List<Match> _matchList() {
    final List<Match> matches = [];

    final urlMatches = Patterns.statusUrl.allMatches(text);
    final mentionMatches = Patterns.mention.allMatches(text);
    final hashtagMatches = Patterns.hashtag.allMatches(text);

    matches.addAll(urlMatches);
    matches.addAll(mentionMatches);
    matches.addAll(hashtagMatches);
    matches.sort((a, b) => a.start.compareTo(b.start));

    return matches;
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  List<TextSpan> textSpanList(List<Match> allMatches) {
    final textSpans = <TextSpan>[];
    int currentPosition = 0;

    for (var match in allMatches) {
      if (currentPosition < match.start) {
        final textPart = text.substring(currentPosition, match.start);
        textSpans.add(
          TextSpan(text: textPart),
        );
      }

      final matchedText = text.substring(match.start, match.end);
      if (Patterns.statusUrl.hasMatch(matchedText)) {
        final url = matchedText.replaceAll(' ', '').replaceAll('\n', '');
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: const TextStyle(color: AppColors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => onTapUrl == null ? _launchUrl(url) : onTapUrl!(url),
          ),
        );
      } else if (Patterns.mention.hasMatch(matchedText)) {
        final mention = matchedText.replaceAll(' ', '').replaceAll('\n', '');
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: const TextStyle(color: AppColors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTapMention(mention),
          ),
        );
      } else if (Patterns.hashtag.hasMatch(matchedText)) {
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: const TextStyle(color: AppColors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTapHashtag(matchedText),
          ),
        );
      }

      currentPosition = match.end;
    }
    if (currentPosition < text.length) {
      final remainingText = text.substring(currentPosition);
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
      allMatches.isEmpty ? TextSpan(text: text) : TextSpan(children: textSpans),
    );
  }
}
