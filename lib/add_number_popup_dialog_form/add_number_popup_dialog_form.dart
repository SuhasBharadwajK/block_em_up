import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNumberToBlockForm extends StatefulWidget {
  final Function(String) addNewNumberCallback;
  AddNumberToBlockForm(this.addNewNumberCallback);
  
  @override
  State<StatefulWidget> createState() => AddNumberToBlockFormState(addNewNumberCallback);
}

class AddNumberToBlockFormState extends State<AddNumberToBlockForm> {
  final Function(String) addNewNumberCallback;

  var _formKey = GlobalKey<FormState>();
  FocusNode _textFieldFocusNode = FocusNode();
  final _textController = TextEditingController();

  bool _isEmpty = false;
  bool _isTextBoxFocused = false;
  bool _didKeydownHappen = false;
  bool _isSubmitted = false;

  bool get _isInvalidNumber {
    return false;
  }

  String get _invalidMessage {
    return this._textController.text.isEmpty ? 'Please enter some text' : this._isInvalidNumber ? 'Please enter a valid number' : null;
  }

  AddNumberToBlockFormState(this.addNewNumberCallback) {
    this._textController.addListener(_onTextChangeEventHandler);
    _textFieldFocusNode.addListener(_onFocusNodeEvent);
  }
  
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
              focusNode: _textFieldFocusNode,
              autofocus: true,
              controller: _textController,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                labelText: "Enter the number",
                labelStyle: TextStyle(
                  color: this._getInputColor(),
                ),
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: this._isEmpty && this._isSubmitted ? Colors.red : Colors.grey, width: 2.0),
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
                setState(() {
                  this._isSubmitted = true;
                });

                if (_formKey.currentState.validate()) {
                  this.addNewNumberCallback(this._textController.text);
                  Navigator.pop(context);
                }
                else {
                  this._didKeydownHappen = true;
                  FocusScope.of(context).requestFocus(this._textFieldFocusNode);
                }
              },
              child: Text('Block Number'),
            ),
          ),
        ]
      )
    );
  }

  _onFocusNodeEvent() {
    setState(() {
      this._isTextBoxFocused = !this._isTextBoxFocused;
    });
  }

  _onTextChangeEventHandler() {
    if (this._didKeydownHappen || this._isSubmitted) {
      this._formKey.currentState.validate();
    }

    setState(() {
      this._isEmpty = this._textController.text.isEmpty;

      if (this._textController.text.isNotEmpty) {
        this._didKeydownHappen = true;
      }
    });
  }

  String numberValidator(String value) {
    if (this._textController.text.isEmpty || this._isInvalidNumber) {
      return this._invalidMessage;
    }

    return null;
  }

  MaterialColor _getInputColor() {
    return this._isEmpty && (this._didKeydownHappen || this._isSubmitted) ? Colors.red : this._isTextBoxFocused ? Colors.blue : Colors.grey;
  }
}