import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/add_number_button.dart';
import 'blocked_list/blocked_list.dart';

class BlockEmAllApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Blocked Ones'),
      ),
      body: BlockedNumbersListWidget(),
      floatingActionButton: AddNumberButton(),
    );
  }
}