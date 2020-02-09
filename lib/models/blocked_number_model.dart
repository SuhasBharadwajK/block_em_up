import 'data_model.dart';

class BlockedNumber extends DataEntity {
  final int id;
  final String blockingPattern;
  final bool isBlockingActive;
  final DateTime dateCreated;
  final DateTime dateModified;

  BlockedNumber({this.id, this.blockingPattern, this.isBlockingActive, this.dateCreated, this.dateModified}) : super(dateCreated, dateModified);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'blockingPattern': this.blockingPattern,
      'isBlockingActive': this.isBlockingActive,
      'dateCreated': this.dateCreated.toIso8601String(),
      'dateModified': this.dateModified.toIso8601String(),
    };
  }
}