import 'package:block_em_up/models/blocked_number_model.dart';
import 'package:block_em_up/services/data_service.dart';

class BlockedNumbersService {
  DataService _dataService;
  String _tableName = "BlockedNumbers";

  BlockedNumbersService() {
    this._dataService = DataService();
  }

  Future<int> insertNewPatternOrNumber(String numberOrPatternToBlock) async {
    var blockedNumber = BlockedNumber(
      id: 0,
      blockingPattern: numberOrPatternToBlock,
      isBlockingActive: true,
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
    );

    return await this._dataService.insert(blockedNumber, this._tableName);
  }
  
  Future<List<BlockedNumber>> getBlockedNumbers() async {
    final List<Map<String, dynamic>> maps = await this._dataService.getAllEntities(this._tableName);

    return List.generate(maps.length, (i) {
      return BlockedNumber(
        id: maps[i]['id'],
        blockingPattern: maps[i]['blockingPattern'],
        isBlockingActive: maps[i]['isBlockingActive'] == 1,
      );
    });
  }
}