import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/contact_provider.dart';
import 'package:rwa1_adv_flutter_5pm/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/providers/counter_provider.dart';
import '../../controllers/providers/theme_provider.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          onSelected: (val) async {
            switch (val) {
              case "hidden":
                // authenticate the user
                LocalAuthentication auth = LocalAuthentication();

                try {
                  bool haveBiometrics = await auth.canCheckBiometrics;
                  bool isDeviceSupported = await auth.isDeviceSupported();

                  bool isAuthenticated = false;

                  if (haveBiometrics || isDeviceSupported) {
                    isAuthenticated = await auth.authenticate(
                        localizedReason: "Enter your biometric/password...");

                    if (isAuthenticated) {
                      Navigator.of(context).pushNamed('hidden_contacts_page');
                    }
                  }
                } on PlatformException catch (e) {
                  log("EXCEPTION: $e");
                  log("EXCEPTION CODE: ${e.code}");
                  log("EXCEPTION MSG: ${e.message}");
                }

                break;
            }
          },
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text("Hidden Contacts"),
                value: "hidden",
              ),
              // PopupMenuItem(
              //   child: Text("Second"),
              //   value: "Second",
              // ),
            ];
          },
        ),
        title: Text(
          "Home Page",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeProvider>(context).themeModel.isDark,
            onChanged: (val) async {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
      ),
      body: (Provider.of<ContactProvider>(context).allContacts.isEmpty)
          ? const Center(
              child: Text("No any contacts available yet...."),
            )
          : ListView.builder(
              itemCount:
                  Provider.of<ContactProvider>(context).allContacts.length,
              itemBuilder: (context, i) {
                List<ContactModel> contacts =
                    Provider.of<ContactProvider>(context).allContacts;

                return ListTile(
                  isThreeLine: true,
                  leading: Text("${i + 1}"),
                  title: Text("${contacts[i].name}"),
                  trailing: IconButton(
                    icon: Icon(Icons.contacts_outlined),
                    onPressed: () {
                      Provider.of<ContactProvider>(context, listen: false)
                          .addHiddenContact(data: contacts[i]);
                    },
                  ),
                  subtitle:
                      Text("${contacts[i].email} \n${contacts[i].website}"),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("detail_page", arguments: contacts[i]);
                  },
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('add_contact_page');
              // Navigator.pushNamed(context, 'add_contact_page');
            },
          ),
        ],
      ),
    );
  }
}
