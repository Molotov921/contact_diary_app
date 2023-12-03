import 'package:contact_diary_app/provider/add_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    var addDataPFalse = Provider.of<AddDataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        elevation: 18,
        actions: [
          IconButton(
            onPressed: () async {
              LocalAuthentication localAuth = LocalAuthentication();
              if (await localAuth.canCheckBiometrics &&
                  await localAuth.isDeviceSupported()) {
                localAuth
                    .authenticate(localizedReason: "Unlock Hidden Contacts")
                    .then((value) {
                  Navigator.pushNamed(context, "hidden_contacts");
                });
              }
            },
            icon: const Icon(Icons.lock_outline_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const Alert();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: (addDataP.allContact.isEmpty)
          ? Container(
              alignment: Alignment.center,
              color: Colors.black12,
              child: const Text(
                'No Contacts are here,\nPress + to add new',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: addDataP.allContact
                          .map(
                            (e) => Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              elevation: 9,
                              child: ListTile(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Contact'),
                                        content: const Text(
                                            'Are You Sure To Delete Contact..!'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              addDataP.deleteContact(e);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('viewContact', arguments: e);
                                },
                                leading: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 50,
                                  width: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2, color: Colors.black54),
                                  ),
                                  child: (e.pic != null)
                                      ? CircleAvatar(
                                          backgroundImage: FileImage(e.pic!),
                                        )
                                      : const CircleAvatar(
                                          child: FlutterLogo(),
                                        ),
                                ),
                                title: Text(
                                  e.name,
                                ),
                                subtitle: Text(
                                  e.contact,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        addDataPFalse.hideContactData(e);
                                      },
                                      icon: const Icon(
                                          Icons.lock_outline_rounded),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final Uri url =
                                            Uri.parse('tel:${e.contact}');
                                        await launchUrl(url);
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final Uri url =
                                            Uri.parse('sms:${e.contact}');
                                        await launchUrl(url);
                                      },
                                      icon: const Icon(
                                        Icons.message_rounded,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    return AlertDialog(
      title: const Text(
        'Add Contact',
      ),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Stepper(
          controlsBuilder: (context, details) {
            if (addDataP.cs.currentStep == 0) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                ],
              );
            } else if (addDataP.cs.currentStep == 3) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkFillData();
                      addDataP.checkContinueState();
                      addDataP.cs.currentStep = 0;
                      Navigator.pop(context);
                    },
                    child: const Text('Finish'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            }
          },
          currentStep: addDataP.cs.currentStep,
          steps: <Step>[
            Step(
              state: (addDataP.cs.currentStep == 0)
                  ? StepState.editing
                  : StepState.complete,
              title: const Text('Profile Image'),
              content: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.black54,
                              ),
                            ),
                            child: (addDataP.pickImage != null)
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        FileImage(addDataP.pickImage!),
                                  )
                                : const CircleAvatar(
                                    radius: 40,
                                    child: FlutterLogo(),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  addDataP.imagePicCamera();
                                },
                                child: const Icon(Icons.camera),
                              ),
                              const SizedBox(height: 10),
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  addDataP.imagePicGalary();
                                },
                                child: const Icon(Icons.photo),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 1)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 1)
                      ? StepState.editing
                      : (addDataP.con_var.nameC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Name'),
              content: TextField(
                controller: addDataP.con_var.nameC,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 2)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 2)
                      ? StepState.editing
                      : (addDataP.con_var.emailC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Email'),
              content: TextField(
                controller: addDataP.con_var.emailC,
                decoration: const InputDecoration(hintText: 'Enter your Email'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 3)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 3)
                      ? StepState.editing
                      : (addDataP.con_var.contactC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Contact'),
              content: TextField(
                onSubmitted: (val) {
                  addDataP.con_var.contactC.text = val;
                },
                keyboardType: TextInputType.phone,
                controller: addDataP.con_var.contactC,
                maxLength: 10,
                decoration:
                    const InputDecoration(hintText: 'Enter your Contact'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
