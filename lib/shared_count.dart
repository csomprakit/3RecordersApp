import 'package:flutter/foundation.dart';

class SharedCount with ChangeNotifier {
  int _count;
  DateTime _date;
  int _dedicationLevel;
  String _category;

  SharedCount(this._count, this._date, this._dedicationLevel, this._category);

  int getCount() { return _count; }
  DateTime getDate(){return _date;}
  int getDedicationLevel(){return _dedicationLevel;}
  String getCategory(){return _category;}

  void setCount(int newCount) {
    _count = newCount;
  }

  void setDate(DateTime newDate)
  {
    _date = newDate;
  }

  void setCategory(String newCategory){
    _category = newCategory;
  }

  void setDedicationLevel(int newDedicationLevel) {
    _dedicationLevel = newDedicationLevel;
  }

  void updateCount(DateTime newDate, String newCategory)
  {
    int newCount = _count;
    if(_date.difference(newDate).inHours < 1)
    {
      newCount = newCount + 24;
    }
    else if (_date.difference(newDate).inHours >24)
    {
      newCount = newCount + 1;
    }
    else
    {
      newCount = newCount + newDate.difference(newDate).inHours;
    }
    _count = newCount;
    _date = newDate;
    updateDedicationLevel();
    setCategory(newCategory);
    notifyListeners();
  }

  void updateDedicationLevel()
  {
    if(_count > 5000)
      {
        _dedicationLevel = 5;
      }
    else if (_count > 1000)
      {
        _dedicationLevel = 4;
      }
    else if(_count > 500)
      {
        _dedicationLevel = 3;
      }
    else if(_count > 100)
      {
        _dedicationLevel = 2;
      }
  }
}