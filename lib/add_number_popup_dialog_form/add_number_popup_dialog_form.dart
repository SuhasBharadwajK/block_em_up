import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNumberToBlockForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNumberToBlockFormState();
}

class AddNumberToBlockFormState extends State<AddNumberToBlockForm> {
  var _formKey = GlobalKey<FormState>();
  FocusNode phoneNumberFocusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    // phoneNumberFocusNode.addListener(_onOnFocusNodeEvent);
      
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: TextFormField(
              focusNode: phoneNumberFocusNode,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                labelText: "Enter the number",
                labelStyle: TextStyle(
                  color: phoneNumberFocusNode.hasFocus ? Colors.green : Colors.blue,
                ),
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
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

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  String numberValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    return null;
  }
}