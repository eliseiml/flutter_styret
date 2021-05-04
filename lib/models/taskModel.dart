import 'package:flutter_styret_app/models/api_worker.dart';
import 'package:scoped_model/scoped_model.dart';

class TaskModel extends Model {
  APIworker api = new APIworker();
  void update() {
    notifyListeners();
  }
}

TaskModel taskModel = new TaskModel();
