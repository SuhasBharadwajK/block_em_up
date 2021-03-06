import 'data_model.dart';

class BlockedNumber extends DataEntity {
  final int id;
  final String blockingPattern;
  bool isBlockingActive;
  final DateTime dateCreated;
  final DateTime dateModified;

  BlockedNumber({this.id, this.blockingPattern, this.isBlockingActive, this.dateCreated, this.dateModified}) : super(id, dateCreated, dateModified);

  @override
  Map<String, dynamic> toMap() {
    return {
      'blockingPattern': this.blockingPattern,
      'isBlockingActive': this.isBlockingActive ? 1 : 0,
      'dateCreated': this.dateCreated.toIso8601String(),
      'dateModified': this.dateModified.toIso8601String(),
    };
  }
}