import 'package:flutter/material.dart';

class ControllerVar {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController contactC = TextEditingController();

  ControllerVar(
      {required this.nameC, required this.emailC, required this.contactC});
}

class ControllerEditVar {
  TextEditingController nameCE = TextEditingController();
  TextEditingController emailCE = TextEditingController();
  TextEditingController contactCE = TextEditingController();

  ControllerEditVar({
    required this.nameCE,
    required this.emailCE,
    required this.contactCE,
  });
}
