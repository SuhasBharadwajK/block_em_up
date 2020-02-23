import 'dart:io';

import 'package:block_em_up/services/blocked_number_service.dart';
import 'package:block_em_up/services/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:random_color/random_color.dart';
import 'constants.dart';
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
  static const methodChannel = const MethodChannel(MethodChannelNames.BlockingServiceChannel);

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
      refreshRogueRoster(blockedNumbers);

      this.setState(() {
        this._blockedNumbers = blockedNumbers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    this._startBackgroundService();
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

        refreshRogueRoster([blockedNumbers.last]);

        this.setState(() {
          this._blockedNumbers = blockedNumbers;
        });
      });
    });
  }

  void refreshRogueRoster(List<BlockedNumber> blockedNumbers) {
    methodChannel.invokeMethod(AndroidMethodNames.RefreshBlockList, {"blockedNumbers": blockedNumbers.map((b) => {"blockingPattern": b.blockingPattern, "isBlockingActive": b.isBlockingActive}).toList()});
  }

  Future<List<BlockedNumber>> getBlockedNumbersCallback() async {
    return this._blockedNumbersService.getBlockedNumbers();
  }

  Widget _buildBlockedNumbersList() {
    return ListView.builder(
      itemCount: this._blockedNumbers.length,
      itemBuilder: (context, i) {
        return this._buildRow(this._blockedNumbers[i]);
      }
    );
  }

  Widget _buildRow(BlockedNumber blockedNumber) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border(
            bottom: BorderSide(
              color: Colors.grey, 
            )
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: this._getRandomColor(),
              child: Text('#'),
              foregroundColor: Colors.white,
            ),
            title: Text(
              blockedNumber.blockingPattern,
              style: _biggerFont,
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => this._showDeleteConfirmationDialog(blockedNumber),
        )
      ],
    );
  }

  void _showDeleteConfirmationDialog(BlockedNumber number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete ${number.blockingPattern}?"),
          content: Text("Are you sure you want to delete ${number.blockingPattern} from the list of your blocked numbers?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: const Text(
                "No", 
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                this._deleteBlockedNumber(number);
                Navigator.of(context).pop();
              },
              color: Colors.red,
              child: const Text("Yes"),
              elevation: 4,
            )
          ],
        );
      }
    );
  }

  void _deleteBlockedNumber(BlockedNumber number) {
    this._blockedNumbersService.deleteBlockedNumber(id: number.id).then((rowsAffected) {
      this.setState(() {
        this._blockedNumbers.removeWhere((n) => n.id == number.id);
      });
    });
  }

  void _startBackgroundService() async {
    if (Platform.isAndroid) {
      await methodChannel.invokeMethod(AndroidMethodNames.StartBlockingService, [DataService.dbName, DataService.tableName]);
    }
  }

  Color _getRandomColor() {
    RandomColor _randomColor = RandomColor();
    return _randomColor.randomColor(colorHue: ColorHue.red);
  }
}