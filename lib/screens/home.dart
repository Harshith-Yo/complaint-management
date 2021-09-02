import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_management/screens/newComplaint.dart';
import 'package:complaint_management/screens/viewComplaints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'complaintItem.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewComplaint()));
        },
      ),
      // body: Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //         child: Text('Add New Complaint'),
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => NewComplaint()));
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         child: Text('View All Complaints'),
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => viewComplaints()));
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         child: Text('View Status'),
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => NewComplaint()));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
