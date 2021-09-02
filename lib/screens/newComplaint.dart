import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:complaint_management/helpers/operations.dart';
import 'package:complaint_management/screens/home.dart';
import 'package:flutter/material.dart';

class NewComplaint extends StatefulWidget {
  const NewComplaint({Key? key}) : super(key: key);

  @override
  _NewComplaintState createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  final GlobalKey<FormState> _complaintFormKey = GlobalKey<FormState>();
  TextEditingController headingController = new TextEditingController();
  TextEditingController complaintController = new TextEditingController();
  TextEditingController roomController = new TextEditingController();

  late String heading, desc, room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new complaint'),
      ),
      body: Form(
        key: _complaintFormKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Heading"),
                controller: headingController,
                onChanged: (value) {
                  heading = value;
                },
                validator: (value) {
                  if (value!.length == 0)
                    return 'Heading is compulsory';
                  else
                    return null;
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Complaint Description"),
                controller: complaintController,
                onChanged: (value) {
                  desc = value;
                },
                validator: (value) {
                  if (value!.length == 0)
                    return 'Complaint can\'t be empty';
                  else
                    return null;
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Room Number"),
                controller: roomController,
                onChanged: (value) {
                  room = value;
                },
                validator: (value) {
                  if (value!.length == 0)
                    return 'Room No. is compulsory';
                  else
                    return null;
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              // alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if (_complaintFormKey.currentState!.validate()) {
                    await uploadingData(heading, desc, room);
                    ArtDialogResponse response = await ArtSweetAlert.show(
                        barrierDismissible: false,
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            title: "Complaint Filed Successfully",
                            confirmButtonText: "Ok",
                            type: ArtSweetAlertType.success));

                    if (response == null) {
                      return;
                    }

                    if (response.isTapConfirmButton) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                      return;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
