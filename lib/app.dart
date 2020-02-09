import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/add_number_button.dart';
import 'blocked_list/blocked_list.dart';

class BlockEmAllApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => BlockEmAllAppState();
}

class BlockEmAllAppState extends State<BlockEmAllApp> {
  List<String> _blockedNumbers = List<String>();

  BlockEmAllAppState() {
    this._blockedNumbers.add("9123456789");
    this._blockedNumbers.add("9123456788");
    this._blockedNumbers.add("9123456787");
    this._blockedNumbers.add("9123456786");
    this._blockedNumbers.add("9123456785");
    this._blockedNumbers.add("9123456784");
    this._blockedNumbers.add("9123456783");
    this._blockedNumbers.add("9123456782");
    this._blockedNumbers.add("9123456781");
    this._blockedNumbers.add("9123456780");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Blocked Ones'),
      ),
      body: BlockedNumbersListWidget(this._blockedNumbers),
      floatingActionButton: AddNumberButton(addNewNumberCallback),
    );
  }

  addNewNumberCallback(String newBlockedNumber) {
    this.setState(() {
      this._blockedNumbers.add(newBlockedNumber);
    });
  }
}