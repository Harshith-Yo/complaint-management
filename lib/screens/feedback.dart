import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:complaint_management/screens/techni_home.dart';
import 'package:flutter/material.dart';

class TechniFeedback extends StatefulWidget {
  const TechniFeedback({Key? key}) : super(key: key);

  @override
  _TechniFeedbackState createState() => _TechniFeedbackState();
}

class _TechniFeedbackState extends State<TechniFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ElevatedButton(
                onPressed: () async {
                  ArtDialogResponse response = await ArtSweetAlert.show(
                      barrierDismissible: false,
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          title: "Feedback Submitted Successfully",
                          confirmButtonText: "Ok",
                          type: ArtSweetAlertType.success));

                  if (response == null) {
                    return;
                  }

                  if (response.isTapConfirmButton) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => TechniHome()));
                    return;
                  }
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
