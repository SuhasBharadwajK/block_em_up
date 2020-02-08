import 'package:block_em_up/add_number_popup_dialog_form/add_number_popup_dialog_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNumberButton extends StatelessWidget {
  AddNumberButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        addNumber(context);
      },
      child: Icon(Icons.block),
      backgroundColor: Colors.red,
    );
  }

  void addNumber(BuildContext context) {

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AddNumberToBlockForm(),
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => simpleDialog);
  }
}