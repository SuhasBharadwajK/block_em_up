import 'package:block_em_up/models/blocked_number_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedNumbersListState extends State<BlockedNumbersListWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<String> _blockedNumbers;
  // final Future<List<BlockedNumber>> Function() _blockNumberGetter;
  final Future<List<BlockedNumber>> Function() _blockNumberGetter;

  BlockedNumbersListState(this._blockNumberGetter) {
    this._blockedNumbers = List<String>();
    this._blockedNumbers.add("value");
    this.initBlockedList();
  }

  void initBlockedList() async {
    if (_blockNumberGetter != null) {
      var blockedNumbers = await this._blockNumberGetter();
      this._blockedNumbers = blockedNumbers.map<String>((n) {
        var a = n.blockingPattern;
        return a;
      }).toList();
    }
    // setState(() async {
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Here comes the list of blocked numbers
    return Center(child: _buildBlockedNumbersList());
  }

  Widget _buildBlockedNumbersList() {
    this._blockedNumbers = List<String>();
    this._blockedNumbers.add("value");

    return ListView.builder(
      itemCount: this._blockedNumbers.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        
        final index = i ~/ 2;
        return this._buildRow(this._blockedNumbers[index]);
      }
    );
  }

  Widget _buildRow(String blockedNumber) {
    return ListTile(title: Text(
      blockedNumber,
      style: _biggerFont,
    ), onTap: () {
      setState(() {
      });
    },);
  }

  // onNewNumberAdded(String newNumberToBlock) {
  //   setState(() {
  //     this._blockedNumbers.add(newNumberToBlock);
  //   });
  // }
}

class BlockedNumbersListWidget extends StatefulWidget {
  final Future<List<BlockedNumber>> Function() _blockNumberGetter;
  BlockedNumbersListWidget(this._blockNumberGetter);

  @override
  State<StatefulWidget> createState() => BlockedNumbersListState(this._blockNumberGetter);
}