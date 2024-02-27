import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_mobile/debug/debug_loding_view.dart';
import 'package:pg_mobile/util/location_util.dart';
import 'package:pg_mobile/util/navigator_util.dart';

class DebugLocationPage extends StatefulWidget {
  const DebugLocationPage({Key? key}) : super(key: key);

  @override
  State<DebugLocationPage> createState() => _DebugLocationPageState();
}

class _DebugLocationPageState extends State<DebugLocationPage> {
  bool _isLoading = false;
  bool _isCheckingIn = false;
  double _currentLat = 0.0;
  double _currentLong = 0.0;
  double _distanceInMeters = 0.0;
  final _location = Location();

  // PlayGround東京オフィスの座標
  final _targetLocation = LocationUtil.convertToLocationData(
    35.7021178,
    139.7449061,
  );

  bool get _isInOffice => _distanceInMeters <= 10.0;

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

  void _setCurrentLatLong(double currentLat, double currentLong) {
    setState(() {
      _currentLat = currentLat;
      _currentLong = currentLong;
    });
  }

  void _onPressedCancel() {
    Navigator.of(context).pop();
  }

  Future<void> _onPressedOK() async {
    _setLoading(true);
    await openAppSettings();
    final status = await Permission.locationAlways.status;
    if (status.isGranted) {
      await _checkInCheckOut();
    }
    _setLoading(false);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _checkInCheckOut() async {
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _switchCheckingIn();
    _setLoading(false);
  }

  Future<void> _onPressedCheckInCheckOut() async {
    if (_isLoading) return;
    final status = await Permission.locationAlways.request();
    if (status.isGranted) {
      await _checkInCheckOut();
    } else {
      if (!mounted) return;
      NavigatorUtil.showCommonAlertDialog(
        context,
        titleText: '設定を開きますか？',
        contentText: 'オフィス機能を利用するには、設定から位置情報の使用を許可する必要があります。',
        onPressedOK: _onPressedOK,
        onPressedCancel: _onPressedCancel,
      );
    }
  }

  void _locationListener(LocationData currentLocation) {
    if (currentLocation.latitude == null || currentLocation.longitude == null) {
      return;
    }
    _setCurrentLatLong(currentLocation.latitude!, currentLocation.longitude!);
    setState(() {
      _distanceInMeters = LocationUtil.distanceInMeters(
        currentLocation,
        _targetLocation,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen(_locationListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('位置情報'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                    'オフィスの座標: ${_targetLocation.latitude!.toStringAsFixed(5)}, ${_targetLocation.longitude!.toStringAsFixed(5)}'),
                Text(
                    '　現在地の座標: ${_currentLat.toStringAsFixed(5)}, ${_currentLong.toStringAsFixed(5)}'),
                const Divider(),
                Text('オフィスまでの距離: ${_distanceInMeters.toStringAsFixed(2)}(m)'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onPressedCheckInCheckOut,
                    child: Text(_isCheckingIn ? 'チェックアウト' : 'チェックイン'),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
          if (_isLoading) const DebugLoadingView(),
        ],
      ),
    );
  }
}
