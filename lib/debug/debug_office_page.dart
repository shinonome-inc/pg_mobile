import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Office Page'),
      ),
      body: ListView.builder(
        itemCount: _offices.length,
        itemBuilder: (context, officeIndex) {
          final office = _offices[officeIndex];
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
              SizedBox(height: 16.h),
            ],
          );
        },
      ),
    );
  }
}
