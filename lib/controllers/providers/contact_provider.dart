import 'package:flutter/material.dart';

import '../../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  // Create a List of ContactModel, with initially empty
  List<ContactModel> allContacts = [];
  List<ContactModel> hiddenContacts = [];

  // add a Contact into a List
  void addContact({required ContactModel data}) {
    allContacts.add(data);
    notifyListeners();
  }

  // add a Contact into a hiddenContact list
  void addHiddenContact({required ContactModel data}) {
    hiddenContacts.add(data);
    allContacts.remove(data);
    notifyListeners();
  }

  // add a Contact into a allContacts list
  void unhideContact({required ContactModel data}) {
    allContacts.add(data);
    hiddenContacts.remove(data);
    notifyListeners();
  }

  // delete a Contact from a List
  void deleteContact({required ContactModel data}) {
    allContacts.remove(data);
    notifyListeners();
  }

  // edit a Contact from a List
  void editContact({required ContactModel data}) {
    data.name = "Piyush";
    data.email = "piyush@gmail.com";
    data.phone = "9090909090";
    data.website = "https://www.google.com";
    notifyListeners();
  }
}
