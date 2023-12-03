import 'package:contact_diary_app/model/contact.dart';
import 'package:contact_diary_app/provider/add_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewContactInfo extends StatelessWidget {
  const ViewContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    var addDataPFalse = Provider.of<AddDataProvider>(context, listen: false);
    Contact viewContact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Contact Info'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addDataP.con_edit_var.nameCE.text = viewContact.name;
              addDataP.con_edit_var.emailCE.text = viewContact.email;
              addDataP.con_edit_var.contactCE.text = viewContact.contact;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Update Contact"),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            addDataPFalse.checkEditFillData(
                                viewContact,
                                addDataP.con_edit_var.nameCE.text,
                                addDataP.con_edit_var.emailCE.text,
                                addDataP.con_edit_var.contactCE.text);
                            Navigator.pop(context);
                          },
                          child: const Text("Done")),
                    ],
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name"),
                        TextField(
                          controller: addDataP.con_edit_var.nameCE,
                          keyboardType: TextInputType.text,
                        ),
                        const Text("Contact"),
                        TextField(
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          controller: addDataP.con_edit_var.contactCE,
                        ),
                        const Text("Email"),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: addDataP.con_edit_var.emailCE,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit,
              size: 25,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 850,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: (addDataP.pickImage != null)
                        ? CircleAvatar(
                            backgroundImage: FileImage(addDataP.pickImage!),
                            radius: 150,
                          )
                        : const FlutterLogo(size: 250),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              viewContact.name,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.call_sharp,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              viewContact.contact,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              viewContact.email,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          addDataP.deleteContact(viewContact);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF25232a),
                          ),
                        ),
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
