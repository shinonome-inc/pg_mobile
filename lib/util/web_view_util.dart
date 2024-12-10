import 'package:webview_flutter/webview_flutter.dart';

class WebViewUtil {
  WebViewUtil._();

  /// JavaScriptを実行してWebViewの高さを取得する。
  static Future<double> calculateWebViewHeight(
      WebViewController controller) async {
    const javaScript = 'document.documentElement.scrollHeight;';
    final result = await controller.runJavaScriptReturningResult(javaScript);
    final height = double.parse(result.toString());
    return height;
  }
}
