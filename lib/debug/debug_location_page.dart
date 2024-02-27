import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_mobile/debug/debug_loding_view.dart';

class DebugLocationPage extends StatefulWidget {
  const DebugLocationPage({Key? key}) : super(key: key);

  @override
  State<DebugLocationPage> createState() => _DebugLocationPageState();
}

class _DebugLocationPageState extends State<DebugLocationPage> {
  late PermissionStatus _status;
  bool _isLoading = false;
  bool _isCheckingIn = false;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _switchCheckingIn() {
    setState(() {
      _isCheckingIn = !_isCheckingIn;
    });
  }

  Future<void> _setStatus() async {
    _setLoading(true);
    _status = await Permission.location.request();
    _setLoading(false);
  }

  Future<void> _onPressedCheckInCheckOut() async {
    if (_isLoading) {
      return;
    }
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _switchCheckingIn();
    _setLoading(false);
  }

  @override
  void initState() {
    super.initState();
    _setStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('位置情報'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _onPressedCheckInCheckOut,
              child: Text(_isCheckingIn ? 'チェックアウト' : 'チェックイン'),
            ),
          ),
          if (_isLoading) const DebugLoadingView(),
        ],
      ),
    );
  }
}
