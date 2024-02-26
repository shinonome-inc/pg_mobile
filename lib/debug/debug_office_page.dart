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

  late Stream<List<Office>> _officeStream;
  late Stream<List<OfficeUser>> _allOfficeUserStream;
  List<Office> _offices = [];
  List<OfficeUser> _allOfficeUsers = [];

  late PageController _pageViewController;

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _officeListener(List<Office> newOffices) async {
    setState(() {
      _offices = newOffices;
    });
  }

  Future<void> _officeUserListener(List<OfficeUser> newOfficeUsers) async {
    setState(() {
      _allOfficeUsers = newOfficeUsers;
    });
  }

  Future<void> _checkInOffice(String officeId) async {
    if (_isLoading) {
      return;
    }
    _setLoading(true);
    Office newOffice = _offices.firstWhere(
      (element) => element.id == officeId,
    );
    final bool isAlreadySignedIn = newOffice.userIdList.contains(signInUser.id);
    if (isAlreadySignedIn) {
      return;
    }
    newOffice = newOffice.copyWith(
      userIdList: [...newOffice.userIdList, signInUser.id],
    );
    await FirestoreRepository.updatePost(office: newOffice);
    _setLoading(false);
  }

  @override
  void initState() {
    super.initState();
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
        body: PageView.builder(
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
                                final user = _allOfficeUsers.firstWhere(
                                  (user) =>
                                      user.id == _allOfficeUsers[userIndex].id,
                                );
                                return DebugOfficeUserItem(user: user);
                              },
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _checkInOffice(office.id),
                    child: const Text('チェックイン'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
