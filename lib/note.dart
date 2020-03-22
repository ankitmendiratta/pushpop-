import 'package:flutter/material.dart';

class Note {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priorirty;

//Create --- default and named constructor
  Note(this._title, this._date, this._priorirty, [this._description]);
  Note.withId(this._id, this._title, this._date, this._priorirty,
      [this._description]);

//set ----- getter
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priorirty => _priorirty;

//set -------- setter
  set title(String newTitle) {
    if (newTitle.length < 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length < 255) {
      this._title = newDescription;
    }
  }

  set priorirty(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priorirty = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

//Convert note object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = '_id';
    }
    map['title'] = '_title';
    map['description'] = '_description';
    map['date'] = '_date';
    map['priorirty'] = '_priorirty';

    return map;
  }

  // Extract note object from map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priorirty = map['priorirty'];
  }
}
