import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNumberToBlockForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNumberToBlockFormState();
}

class AddNumberToBlockFormState extends State<AddNumberToBlockForm> {
  var _formKey = GlobalKey<FormState>();
  FocusNode phoneNumberFocusNode = FocusNode();
  final _text = TextEditingController();
  bool _isEmpty = false;
  bool _isTouched = false;
  bool _isInvalidNumber = false;

  String get _invalidMessage {
    return this._text.text.isEmpty ? 'Please enter some text' : this._isInvalidNumber ? 'Please enter a valid number' : null;
  }

  AddNumberToBlockFormState() {
    this._text.addListener(_onTextChangeEventHandler);
  }
  
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
              controller: _text,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                labelText: "Enter the number",
                labelStyle: TextStyle(
                  color: this._getInputColor(),
                ),
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: this._isEmpty && this._isTouched ? Colors.red : Colors.blue, width: 2.0),
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
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                }
              },
              child: Text('Submit'),
            ),
          ),
        ]
      )
    );
  }

  _onTextChangeEventHandler() {
    if (this._isTouched) {
      this._formKey.currentState.validate();
    }

    setState(() {
      this._isEmpty = this._text.text.isEmpty;

      if (this._text.text.isNotEmpty) {
        if (!this._isTouched) {
          this._isTouched = true;
        }
      }
    });
  }

  String numberValidator(String value) {
    if (this._text.text.isEmpty || this._isInvalidNumber) {
      return this._invalidMessage;
    }

    return null;
  }

  MaterialColor _getInputColor() {
    return this._isEmpty && this._isTouched ? Colors.red : Colors.blue;
  }
}