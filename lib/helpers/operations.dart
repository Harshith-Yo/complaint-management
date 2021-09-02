import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

String? docId;
Future<void> uploadingData(
    String _complaintHeading, String _complaintDesc, String _roomNo) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.email)
      .collection('complaints')
      .add({
    'heading': _complaintHeading,
    'description': _complaintDesc,
    'roomnum': _roomNo,
    'date': DateFormat("yyyy-MM-dd").format(DateTime.now()),
    'postedBy': FirebaseAuth.instance.currentUser?.email,
    'status': 'Complaint Filed'
  }).then((value) => docId = value.id);
  await FirebaseFirestore.instance.collection("complaints").add({
    'heading': _complaintHeading,
    'description': _complaintDesc,
    'roomnum': _roomNo,
    'date': DateFormat("yyyy-MM-dd").format(DateTime.now()),
    'postedBy': FirebaseAuth.instance.currentUser?.email,
    'status': 'Complaint Filed',
    'docId': docId,
  });
}

Future<void> updateStatus(
    String status,
    String id,
    String _complaintHeading,
    String _complaintDesc,
    String _roomNo,
    String postedBy,
    String date,
    String docum) async {
  if (status == 'Resolved') {
    await FirebaseFirestore.instance.collection("complaints").doc(id).delete();
    await FirebaseFirestore.instance.collection('resolved').add({
      'heading': _complaintHeading,
      'description': _complaintDesc,
      'roomnum': _roomNo,
      'date': date,
      'postedBy': postedBy,
      'status': 'Resolved'
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(postedBy)
        .collection('complaints')
        .doc(docum)
        .update({'status': status});
  } else {
    await FirebaseFirestore.instance
        .collection("complaints")
        .doc(id)
        .update({'status': status});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(postedBy)
        .collection('complaints')
        .doc(docum)
        .update({'status': status});
  }
}

// Future<void> deleteComplaint(DocumentSnapshot doc) async {
//   await FirebaseFirestore.instance
//       .collection("complaints")
//       .doc(doc.id)
//       .delete();
// }
