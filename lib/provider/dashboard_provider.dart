import 'package:flutter/material.dart';

import '../model/model_class.dart';

class DashboardProvider with ChangeNotifier{
  List<ItemData> _items = [];
  List<ItemData> get items=>_items;
  bool _isDeleting = false;
  bool get isDeleting=>_isDeleting;

  void changeDelete(bool value){
    _isDeleting=value;
    notifyListeners();
  }

  void removeItems(int index){
    _items.removeAt(index);
    notifyListeners();
  }
  void insertItems(int index,item){
    _items.insert(index, item);
    notifyListeners();
  }

  void addItems(title,desc){
    _items.add(
      ItemData(
        title: title,
        description:desc,
      ),
    );
    notifyListeners();
  }
  void editItems(index,title,desc){
    _items[index].title= title;
    _items[index].description = desc;
    notifyListeners();
  }

}