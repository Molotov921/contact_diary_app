// ignore_for_file: non_constant_identifier_names
import 'package:contact_diary_app/model/contact.dart';
import 'package:contact_diary_app/model/controller.dart';
import 'package:contact_diary_app/model/current_step.dart';
import 'package:flutter/material.dart';

class AddDataProvider extends ChangeNotifier {
  // Create Obj of Current Step of Editing.............
  CurrentStep cs = CurrentStep(currentStep: 0);

  // List Of All Contact
  List<Contact> allContact = [
    Contact(
        flutterlogo: const FlutterLogo(
          size: 50,
        ),
        name: 'Neel',
        contact: '9328119097',
        email: 'kalarianeel249@gmail.com'),
    Contact(
        flutterlogo: const FlutterLogo(
          size: 50,
        ),
        name: 'Pranav',
        contact: '8866161894',
        email: 'pranavharnesha25@gmail.com'),
  ];

  // TextEditing Controller Obj.................
  ControllerVar con_var = ControllerVar(
    nameC: TextEditingController(text: ''),
    emailC: TextEditingController(text: ''),
    contactC: TextEditingController(text: ''),
  );

  // Add Contact Data..........
  void addData(String name, String contact, String email) {
    Contact data = Contact(
        flutterlogo: const FlutterLogo(
          size: 50,
        ),
        name: name,
        contact: contact,
        email: email);
    allContact.add(data);
    notifyListeners();
  }

  // Check Fill Data Or Not ...................
  checkFillData() {
    if (con_var.nameC.text.isNotEmpty &&
        con_var.emailC.text.isNotEmpty &&
        con_var.contactC.text.isNotEmpty) {
      addData(con_var.nameC.text, con_var.contactC.text, con_var.emailC.text);

      con_var.contactC.clear();
      con_var.nameC.clear();
      con_var.emailC.clear();
    }
    notifyListeners();
  }

  // Delete Contact Function.......
  deleteContact(Contact data) {
    // Add Contact Data..........
    allContact.remove(data);
    notifyListeners();
  }

  checkContinueState() {
    if (cs.currentStep < 2) {
      cs.currentStep++;
    }
    notifyListeners();
  }

  checkCancelState() {
    if (cs.currentStep > 0) {
      cs.currentStep--;
    }
    notifyListeners();
  }
}
