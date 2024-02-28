import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/debug/debug_office_user_item.dart';
import 'package:pg_mobile/models/office.dart';
import 'package:pg_mobile/models/office_user.dart';
import 'package:pg_mobile/repository/firestore_repository.dart';

class DebugOfficePage extends StatefulWidget {
  const DebugOfficePage({Key? key}) : super(key: key);

  @override
  State<DebugOfficePage> createState() => _DebugOfficePageState();
}

class _DebugOfficePageState extends State<DebugOfficePage> {
  bool _isLoading = false;
  bool _isInitializedOffices = false;
  bool _isInitializedUsers = false;

  late Stream<List<Office>> _officeStream;
  late Stream<List<OfficeUser>> _allOfficeUserStream;
  List<Office> _offices = [];
  List<OfficeUser> _allOfficeUsers = [];

  late PageController _pageViewController;

  bool get _isInitializedOfficesAndUsers =>
      _isInitializedOffices && _isInitializedUsers;

  bool get _isAlreadySignedIn {
    for (final office in _offices) {
      if (office.userIdList.contains(signInUser.id)) {
        return true;
      }
    }
    return false;
  }

  bool get _isNotAlreadySignedIn => !_isAlreadySignedIn;

  bool get _isRegisteredUser {
    for (final user in _allOfficeUsers) {
      if (user.id == signInUser.id) {
        return true;
      }
    }
    return false;
  }

  bool get _isNotRegisteredUser => !_isRegisteredUser;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _setIsInitializedOffices(bool value) {
    setState(() {
      _isInitializedOffices = value;
    });
  }

  void _setIsInitializedUsers(bool value) {
    setState(() {
      _isInitializedUsers = value;
    });
  }

  Future<void> _officeListener(List<Office> newOffices) async {
    setState(() {
      _offices = newOffices;
    });
    if (!_isInitializedOffices) {
      _setIsInitializedOffices(true);
      if (_isInitializedUsers) {
        _setLoading(false);
      }
    }
  }

  Future<void> _officeUserListener(List<OfficeUser> newOfficeUsers) async {
    setState(() {
      _allOfficeUsers = newOfficeUsers;
    });
    if (!_isInitializedUsers) {
      _setIsInitializedUsers(true);
      if (_isInitializedUsers) {
        _setLoading(false);
      }
    }
  }

  Future<void> _checkIn(String officeId) async {
    if (_isLoading) {
      return;
    }
    _setLoading(true);
    final office = _offices.firstWhere(
      (element) => element.id == officeId,
    );
    if (_isAlreadySignedIn) {
      return;
    }
    if (_isNotRegisteredUser) {
      await FirestoreRepository.setOfficeUser(signInUser);
    }
    final newOffice = office.copyWith(
      userIdList: [...office.userIdList, signInUser.id],
    );
    await FirestoreRepository.updateOffice(office: newOffice);
    _setLoading(false);
  }

  Future<void> _checkOut(String officeId) async {
    if (_isLoading) {
      return;
    }
    _setLoading(true);
    final Office office = _offices.firstWhere(
      (element) => element.id == officeId,
    );
    if (_isNotAlreadySignedIn) {
      return;
    }
    final newUserIdList = List<String>.from(office.userIdList)
      ..remove(signInUser.id);
    final newOffice = office.copyWith(userIdList: newUserIdList);
    await FirestoreRepository.updateOffice(office: newOffice);
    _setLoading(false);
  }

  @override
  void initState() {
    super.initState();
    _setLoading(true);
    _officeStream = FirestoreRepository.getOfficeStream();
    _allOfficeUserStream = FirestoreRepository.getOfficeUsersStream();
    _officeStream.listen(_officeListener);
    _allOfficeUserStream.listen(_officeUserListener);

    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIXME: WillPopScopeの代替案を導入する
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Debug Office Page'),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _isInitializedOfficesAndUsers
            ? PageView.builder(
                controller: _pageViewController,
                itemBuilder: (context, officeIndex) {
                  if (_offices.isEmpty) {
                    return const Center(
                      child: Text('オフィスがありません'),
                    );
                  }
                  final office = _offices[officeIndex % _offices.length];
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Text(
                          '${office.name}(@${office.id})',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: office.userIdList.isEmpty
                                ? const Text('今は誰もオフィスにいません')
                                : GridView.builder(
                                    itemCount: office.userIdList.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, userIndex) {
                                      final userId =
                                          office.userIdList[userIndex];
                                      final user = _allOfficeUsers.firstWhere(
                                        (user) => user.id == userId,
                                      );
                                      return DebugOfficeUserItem(user: user);
                                    },
                                  ),
                          ),
                        ),
                        _isAlreadySignedIn
                            ? TextButton(
                                onPressed: () => _checkOut(office.id),
                                child: const Text('チェックアウト'),
                              )
                            : TextButton(
                                onPressed: () => _checkIn(office.id),
                                child: const Text('チェックイン'),
                              ),
                      ],
                    ),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
