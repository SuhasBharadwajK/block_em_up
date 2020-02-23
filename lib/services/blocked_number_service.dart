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
        dateCreated: DateTime.parse(maps[i]['dateCreated']),
        dateModified: DateTime.parse(maps[i]['dateModified']),
      );
    });
  }

  Future<int> deleteBlockedNumber({int id, String number}) async {
    if (id == null) {
      var allNumbers = await this.getBlockedNumbers();
      id = allNumbers.firstWhere((n) => n.blockingPattern == number, orElse: () => null)?.id;
    }

    return await this._dataService.delete(id, this._tableName);
  }

  Future<int> updateBlockedNumber(BlockedNumber number) async {
    var recordToUpdate = BlockedNumber(
      id: number.id,
      blockingPattern: number.blockingPattern,
      isBlockingActive: number.isBlockingActive,
      dateCreated: number.dateCreated,
      dateModified: DateTime.now()
    );

    return await this._dataService.update(recordToUpdate, this._tableName);
  }
}