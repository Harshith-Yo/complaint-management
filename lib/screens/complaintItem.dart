import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_management/screens/updateStatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/operations.dart';

class ComplaintItem extends StatefulWidget {
  final String complaintName;
  final String complaintDesc;
  final String id;
  final String postedBy;
  final String date;
  final String status;
  final DocumentSnapshot documentSnapshot;
  ComplaintItem(
      {required this.documentSnapshot,
      required this.id,
      required this.complaintName,
      required this.complaintDesc,
      required this.date,
      required this.status,
      required this.postedBy});

  @override
  _ComplaintItemState createState() => _ComplaintItemState();
}

class _ComplaintItemState extends State<ComplaintItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.complaintName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.complaintDesc,
                style: TextStyle(fontSize: 17),
              ),
              Divider(),
              Text(
                'Posted By: ${widget.postedBy}',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Date: ${widget.date}',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (widget.status == 'Complaint Filed')
                      ? Colors.red
                      : (widget.status == 'In Progress')
                          ? Colors.yellow
                          : Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.status),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
