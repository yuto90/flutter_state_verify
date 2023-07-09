// todoを管理するクラス
class Todo {
  final String id;
  final String title;
  final bool isDone;

  // コンストラクタ
  Todo({required this.id, required this.title, this.isDone = false});
}
