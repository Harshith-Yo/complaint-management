import 'package:complaint_management/helpers/operations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class UpdateStatus extends StatefulWidget {
  final String complaintName;
  final String complaintDesc;
  final String id;
  final String postedBy;
  final String date;
  final String status;
  final String roomnum;
  final String documentId;
  const UpdateStatus(
      {Key? key,
      required this.complaintName,
      required this.complaintDesc,
      required this.id,
      required this.postedBy,
      required this.date,
      required this.status,
      required this.roomnum,
      required this.documentId})
      : super(key: key);

  @override
  _UpdateStatusState createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  late String _chosenValue;
  @override
  void initState() {
    _chosenValue = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  GoogleSignIn _googleSignIn = GoogleSignIn();
                  await _googleSignIn.disconnect();
                  FirebaseAuth.instance.signOut();
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.complaintName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.postedBy,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.complaintDesc,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Room Number: ${widget.roomnum}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  focusColor: Colors.white,
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>['Complaint Filed', 'In Progress', 'Resolved']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a langauage",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _chosenValue = value!;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      updateStatus(
                              _chosenValue,
                              widget.id,
                              widget.complaintName,
                              widget.complaintDesc,
                              widget.roomnum,
                              widget.postedBy,
                              widget.date,
                              widget.documentId)
                          .then((value) => Navigator.pop(context));
                    },
                    child: Text('Update'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
