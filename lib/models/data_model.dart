abstract class DataEntity {

  final int id;
  DateTime dateCreated;
  DateTime dateModified;

  DataEntity(this.id, this.dateCreated, this.dateModified);

  Map<String, dynamic> toMap();
}