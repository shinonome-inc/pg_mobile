import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pg_mobile/constants/collections.dart';
import 'package:pg_mobile/models/office.dart';
import 'package:pg_mobile/models/office_user.dart';

class FirestoreRepository {
  FirestoreRepository._();

  static Future<void> setOffice(Office office) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collections.office)
          .doc(office.id)
          .set(office.toJson());
    } catch (e) {
      throw Exception('Failed to set ${Collections.office}: $e');
    }
  }

  static Stream<List<Office>> getOfficeStream() async* {
    try {
      final querySnapshot =
          FirebaseFirestore.instance.collection(Collections.office).snapshots();
      await for (var snapshot in querySnapshot) {
        final List<Office> users =
            snapshot.docs.map((doc) => Office.fromJson(doc.data())).toList();
        yield users;
      }
    } catch (e) {
      throw Exception('Failed to get ${Collections.office} stream: $e');
    }
  }

  static Future<void> updateOffice({required Office office}) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collections.office)
          .doc(office.id)
          .set(office.toJson());
    } catch (e) {
      throw Exception('Failed to update ${Collections.office}: $e');
    }
  }

  static Future<void> setOfficeUser(OfficeUser officeUser) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collections.officeUser)
          .doc(officeUser.id)
          .set(officeUser.toJson());
    } catch (e) {
      throw Exception('Failed to set ${Collections.officeUser}: $e');
    }
  }

  static Stream<List<OfficeUser>> getOfficeUsersStream() async* {
    try {
      final querySnapshot = FirebaseFirestore.instance
          .collection(Collections.officeUser)
          .snapshots();
      await for (var snapshot in querySnapshot) {
        final List<OfficeUser> users = snapshot.docs
            .map((doc) => OfficeUser.fromJson(doc.data()))
            .toList();
        yield users;
      }
    } catch (e) {
      throw Exception('Failed to get ${Collections.officeUser} stream: $e');
    }
  }
}
