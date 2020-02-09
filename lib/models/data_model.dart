abstract class DataEntity {
  final DateTime dateCreated;
  final DateTime dateModified;

  DataEntity(this.dateCreated, this.dateModified);

  Map<String, dynamic> toMap();
}