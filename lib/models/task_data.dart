
class TaskData{
  String id,title,description;
  int date;
  bool isDone;

  TaskData({
    required this.title,
    required this.description,
    required this.date,
    this.id="",
    this.isDone=false
  });

  Map<String,dynamic> toJson(){
    return{
      "id":id,
      "title":title,
      "description":description,
      "date":date,
      "isDone":isDone,
    };
  }
  TaskData.fromJson(Map<String,dynamic> json):this(
    title: json["title"],
    description: json["description"],
    date: json["date"],
    isDone: json["isDone"],
    id: json["id"]
  );
}