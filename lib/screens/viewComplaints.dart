import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_management/screens/newComplaint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'complaintItem.dart';

import 'login.dart';

class viewComplaints extends StatefulWidget {
  @override
  _viewComplaintsState createState() => _viewComplaintsState();
}

class _viewComplaintsState extends State<viewComplaints> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Complaints"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
              Color.fromARGB(255, 255, 136, 34),
              Color.fromARGB(255, 255, 177, 41)
            ])),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.email)
              .collection('complaints')
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      return ComplaintItem(
                        documentSnapshot: data,
                        id: data.id,
                        postedBy: data['postedBy'],
                        date: data['date'],
                        status: data['status'],
                        complaintName: data['heading'],
                        complaintDesc: data['description'],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
