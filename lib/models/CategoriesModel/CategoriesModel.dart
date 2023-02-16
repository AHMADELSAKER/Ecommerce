import 'package:ecommers/shared/component/Constants.dart';

class CategoriesModel {
  bool? status;
  GategoriesData? data;

  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = GategoriesData.fromjson(json['data']);
  }
}

class GategoriesData {
  int? current_page;
  List<DataModel> data = [];
  GategoriesData.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data']!.forEach((element) {
      print('======================Element in Categories====================');

      print(element);
      data.add(
        DataModel.fromjson(
          element,
        ),
      );
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromjson(Map<String, dynamic> json) {
    // print(
    //     '===================data In DataModel================================');
    // PrintFullText(DataModel.fromjson(json).name);
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
