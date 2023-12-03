// ignore_for_file: non_constant_identifier_names
import 'package:contact_diary_app/model/contact.dart';
import 'package:contact_diary_app/model/controller.dart';
import 'package:contact_diary_app/model/current_step.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddDataProvider extends ChangeNotifier {
  CurrentStep cs = CurrentStep(currentStep: 0);

  List<Contact> hideContact = [];
  List<Contact> allContact = [];

  ControllerVar con_var = ControllerVar(
    nameC: TextEditingController(text: ''),
    emailC: TextEditingController(text: ''),
    contactC: TextEditingController(text: ''),
  );
  ControllerEditVar con_edit_var = ControllerEditVar(
      nameCE: TextEditingController(text: ''),
      emailCE: TextEditingController(text: ''),
      contactCE: TextEditingController(text: ''));

  void addContact(String name, String contact, String email) {
    Contact data = Contact(name: name, contact: contact, email: email);
    allContact.add(data);
    notifyListeners();
  }

  void addData(String name, String contact, String email, File imagePic) {
    Contact data =
        Contact(pic: pickImage!, name: name, contact: contact, email: email);
    allContact.add(data);
    notifyListeners();
  }

  File? pickImage;

  imagePicCamera() async {
    ImagePicker picker = ImagePicker();

    XFile? res = await picker.pickImage(source: ImageSource.camera);
    String? path = res!.path;
    pickImage = File(path);
    notifyListeners();
  }

  imagePicGalary() async {
    ImagePicker picker = ImagePicker();

    XFile? res = await picker.pickImage(source: ImageSource.gallery);
    String? path = res!.path;
    pickImage = File(path);
    notifyListeners();
  }

  checkFillData() {
    if (pickImage != null &&
        con_var.nameC.text.isNotEmpty &&
        con_var.emailC.text.isNotEmpty &&
        con_var.contactC.text.isNotEmpty) {
      addData(con_var.nameC.text, con_var.contactC.text, con_var.emailC.text,
          pickImage!);
    } else if (con_var.nameC.text.isNotEmpty &&
        con_var.emailC.text.isNotEmpty &&
        con_var.contactC.text.isNotEmpty) {
      addContact(
          con_var.nameC.text, con_var.contactC.text, con_var.emailC.text);

      pickImage = null;
      con_var.contactC.clear();
      con_var.nameC.clear();
      con_var.emailC.clear();
    }
    notifyListeners();
  }

  checkEditFillData(
      Contact oldData, String name, String email, String contact) {
    if (allContact.contains(oldData)) {
      for (var element in allContact) {
        if (element == oldData) {
          element.name = name;
          element.email = email;
          element.contact = contact;
        }
      }
    }
    con_edit_var.contactCE.clear();
    con_edit_var.nameCE.clear();
    con_edit_var.emailCE.clear();
    notifyListeners();
  }

  deleteContact(Contact data) {
    // Add Contact Data..........
    allContact.remove(data);
    notifyListeners();
  }

  checkContinueState() {
    if (cs.currentStep < 3) {
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

  void hideContactData(Contact data) {
    hideContact.add(data);
    allContact.remove(data);
    notifyListeners();
  }

  void unhideContactData(Contact data) {
    allContact.add(data);
    hideContact.remove(data);
    notifyListeners();
  }
}
