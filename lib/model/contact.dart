import 'dart:io';

class Contact {
  File? pic;
  String name;
  String contact;
  String email;
  bool ishidden;
  Contact(
      {this.pic,
      required this.name,
      required this.contact,
      required this.email,
      this.ishidden = false});
}
