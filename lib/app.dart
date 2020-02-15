import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/blocked_number_model.dart';
import 'widgets/add_number_button.dart';
import 'blocked_list/blocked_list.dart';
import 'services/data_service.dart';

class BlockEmAllApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => BlockEmAllAppState();
}

class BlockEmAllAppState extends State<BlockEmAllApp> {
  // List<String> _blockedNumbers = List<String>();
  DataService _dataService;
  String _tableName = "BlockedNumbers";

  BlockEmAllAppState() {
    this._dataService = DataService();
    
    // this._blockedNumbers.add("9123456789");
    // this._blockedNumbers.add("9123456788");
    // this._blockedNumbers.add("9123456787");
    // this._blockedNumbers.add("9123456786");
    // this._blockedNumbers.add("9123456785");
    // this._blockedNumbers.add("9123456784");
    // this._blockedNumbers.add("9123456783");
    // this._blockedNumbers.add("9123456782");
    // this._blockedNumbers.add("9123456781");
    // this._blockedNumbers.add("9123456780");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Blocked Ones'),
      ),
      body: BlockedNumbersListWidget(this.getBlockedNumebrs),
      floatingActionButton: AddNumberButton(addNewNumberCallback),
    );
  }

  addNewNumberCallback(String numberOrPatternToBlock) {
    this.setState(() {
      var blockedNumber = BlockedNumber(
        id: 0,
        blockingPattern: numberOrPatternToBlock,
        isBlockingActive: true,
        dateCreated: DateTime.now(),
        dateModified: DateTime.now(),
      );

      this._dataService.insert(blockedNumber, this._tableName);
      // this._blockedNumbers.add(numberOrPatternToBlock);
    });
  }

  Future<List<BlockedNumber>> getBlockedNumebrs() async {
    final List<Map<String, dynamic>> maps = await this._dataService.getAllEntities(this._tableName);

    return List.generate(maps.length, (i) {
      return BlockedNumber(
        id: maps[i]['id'],
        blockingPattern: maps[i]['blockingPattern'],
        isBlockingActive: maps[i]['isBlockingActive'],
      );
    });
  }
}