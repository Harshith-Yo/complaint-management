import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'complaintItem.dart';

class ResolvedComplaints extends StatefulWidget {
  const ResolvedComplaints({Key? key}) : super(key: key);

  @override
  _ResolvedComplaintsState createState() => _ResolvedComplaintsState();
}

class _ResolvedComplaintsState extends State<ResolvedComplaints> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Resolved Complaints"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
              Color.fromARGB(255, 255, 136, 34),
              Color.fromARGB(255, 255, 177, 41)
            ])),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('resolved').snapshots(),
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
