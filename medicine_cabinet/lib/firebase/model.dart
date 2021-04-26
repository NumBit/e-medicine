abstract class Model {
  final String id;

  Model({this.id = ""});
  toJson();

  Model.fromMap({this.id = "", data});
}
