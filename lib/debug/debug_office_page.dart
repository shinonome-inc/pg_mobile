import 'package:flutter/material.dart';
import 'package:pg_mobile/models/office.dart';
import 'package:pg_mobile/models/office_user.dart';
import 'package:pg_mobile/repository/firestore_repository.dart';

class DebugOfficePage extends StatefulWidget {
  const DebugOfficePage({Key? key}) : super(key: key);

  @override
  State<DebugOfficePage> createState() => _DebugOfficePageState();
}

class _DebugOfficePageState extends State<DebugOfficePage> {
  late Stream<List<Office>> _officeStream;
  late Stream<List<OfficeUser>> _officeUserStream;
  List<Office> _offices = [];
  List<OfficeUser> _officeUsers = [];

  late PageController _pageViewController;

  Future<void> _officeListener(List<Office> newOffices) async {
    setState(() {
      _offices = newOffices;
    });
  }

  Future<void> _officeUserListener(List<OfficeUser> newOfficeUsers) async {
    setState(() {
      _officeUsers = newOfficeUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    _officeStream = FirestoreRepository.getOfficeStream();
    _officeUserStream = FirestoreRepository.getOfficeUsersStream();
    _officeStream.listen(_officeListener);
    _officeUserStream.listen(_officeUserListener);

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
            return Column(
              children: [
                Text(office.toString()),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: office.userIdList.length,
                  itemBuilder: (context, userIndex) {
                    final user = _officeUsers.firstWhere(
                      (user) => user.id == _officeUsers[userIndex].id,
                    );
                    return Column(
                      children: [
                        Text(user.toString()),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
