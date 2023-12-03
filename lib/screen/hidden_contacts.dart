import 'package:contact_diary_app/provider/add_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HiddenContacts extends StatelessWidget {
  const HiddenContacts({super.key});

  @override
  Widget build(BuildContext context) {
    var contactHide = Provider.of<AddDataProvider>(context);
    var contactHideFalse = Provider.of<AddDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hidden Contacts"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: contactHide.hideContact.map((e) {
            return Card(
              elevation: 5,
              child: ListTile(
                dense: true,
                leading: (e.pic != null)
                    ? CircleAvatar(
                        backgroundImage: FileImage(e.pic!),
                      )
                    : const CircleAvatar(
                        child: FlutterLogo(),
                      ),
                title: Text(e.name),
                subtitle: Text(e.contact),
                trailing: IconButton(
                  onPressed: () {
                    contactHideFalse.unhideContactData(e);
                  },
                  icon: const Icon(
                    Icons.lock_open_outlined,
                    color: Colors.green,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
