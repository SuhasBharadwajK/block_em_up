import 'package:block_em_up/services/blocked_number_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/blocked_number_model.dart';
import 'widgets/add_number_button.dart';

class BlockEmAllApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => BlockEmAllAppState();
}

class BlockEmAllAppState extends State<BlockEmAllApp> {
  var _blockedNumbers = List<BlockedNumber>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  BlockedNumbersService _blockedNumbersService;

  BlockEmAllAppState() {
    this._blockedNumbersService = BlockedNumbersService();

    this.getBlockedNumbersCallback().then((blockedNumbers) {
        this._blockedNumbers = blockedNumbers;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getBlockedNumbersCallback().then((blockedNumbers) {
      this.setState(() {
        this._blockedNumbers = blockedNumbers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Blocked Ones'),
      ),
      body: this._buildBlockedNumbersList(),
      floatingActionButton: AddNumberButton(addNewNumberCallback),
    );
  }

  void addNewNumberCallback(String numberOrPatternToBlock) {
    this._blockedNumbersService.insertNewPatternOrNumber(numberOrPatternToBlock).then((insertedId) {
      this.getBlockedNumbersCallback().then((blockedNumbers) {
        this.setState(() {
          this._blockedNumbers = blockedNumbers;
        });
      });
    });
  }

  Future<List<BlockedNumber>> getBlockedNumbersCallback() async {
    return this._blockedNumbersService.getBlockedNumbers();
  }

  Widget _buildBlockedNumbersList() {
    return ListView.builder(
      itemCount: this._blockedNumbers.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        
        final index = i ~/ 2;
        return this._buildRow(this._blockedNumbers[index].blockingPattern);
      }
    );
  }

  Widget _buildRow(String blockedNumber) {
    return ListTile(title: Text(
      blockedNumber,
      style: _biggerFont,
    ), onTap: () {
      // TODO: Implement this.
    },);
  }
}