import 'package:flutter/cupertino.dart';

class BlockedNumbersListState extends State<BlockedNumbersListWidget> {
  @override
  Widget build(BuildContext context) {
    // Here comes the list of blocked numbers
    return Center(child: const Text('Press the button below!'));
  }
}

class BlockedNumbersListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlockedNumbersListState();
}