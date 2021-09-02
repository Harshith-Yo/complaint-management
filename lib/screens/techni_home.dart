import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_management/screens/feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'addAdmin.dart';
import 'addTechnician.dart';
import 'complaintItem.dart';
import 'login.dart';
import 'updateStatus.dart';

class TechniHome extends StatefulWidget {
  const TechniHome({Key? key}) : super(key: key);

  @override
  _TechniHomeState createState() => _TechniHomeState();
}

class _TechniHomeState extends State<TechniHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Management"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              GoogleSignIn().signOut().then((value) async {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
                GoogleSignIn _googleSignIn = GoogleSignIn();
                await _googleSignIn.disconnect();
                FirebaseAuth.instance.signOut();
              });
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("complaints").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return GestureDetector(
                      child: ComplaintItem(
                        documentSnapshot: data,
                        id: data.id,
                        postedBy: data['postedBy'],
                        date: data['date'],
                        status: data['status'],
                        complaintName: data['heading'],
                        complaintDesc: data['description'],
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TechniFeedback())),
                    );
                  },
                );
        },
      ),
    );
  }
}
