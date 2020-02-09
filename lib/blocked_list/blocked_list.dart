import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedNumbersListState extends State<BlockedNumbersListWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final List<String> _blockedNumbers;

  BlockedNumbersListState(this._blockedNumbers);

  @override
  Widget build(BuildContext context) {
    // Here comes the list of blocked numbers
    return Center(child: _buildBlockedNumbersList());
  }

  Widget _buildBlockedNumbersList() {
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

  onNewNumberAdded(String newNumberToBlock) {
    setState(() {
      this._blockedNumbers.add(newNumberToBlock);
    });
  }
}

class BlockedNumbersListWidget extends StatefulWidget {
  final List<String> _blockedNumbers;
  BlockedNumbersListWidget(this._blockedNumbers);

  @override
  State<StatefulWidget> createState() => BlockedNumbersListState(this._blockedNumbers);
}