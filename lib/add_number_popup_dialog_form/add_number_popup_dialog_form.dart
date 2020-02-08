import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNumberToBlockForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNumberToBlockFormState();
}

class AddNumberToBlockFormState extends State<AddNumberToBlockForm> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: TextFormField(
              validator: numberValidator,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ]
      )
    );
  }

  String numberValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    return null;
  }
}