import 'package:contact_diary_app/model/contact.dart';
import 'package:contact_diary_app/provider/add_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewContactInfo extends StatelessWidget {
  const ViewContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    Contact viewContact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Contact Info'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.all(15),
                  height: 230,
                  alignment: Alignment.center,
                  child: const FlutterLogo(
                    size: 200,
                  ),
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
                            size: 50,
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
                            size: 50,
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
                            size: 50,
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        addDataP.deleteContact(viewContact);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
