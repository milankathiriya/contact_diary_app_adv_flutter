import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/contact_provider.dart';
import 'package:rwa1_adv_flutter_5pm/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/providers/counter_provider.dart';
import '../../controllers/providers/theme_provider.dart';

class HiddenContactsPage extends StatefulWidget {
  const HiddenContactsPage({super.key});

  @override
  State<HiddenContactsPage> createState() => _HiddenContactsPageState();
}

class _HiddenContactsPageState extends State<HiddenContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hidden Contact Page",
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
      body: (Provider.of<ContactProvider>(context).hiddenContacts.isEmpty)
          ? const Center(
              child: Text("No any contacts available yet...."),
            )
          : ListView.builder(
              itemCount:
                  Provider.of<ContactProvider>(context).hiddenContacts.length,
              itemBuilder: (context, i) {
                List<ContactModel> contacts =
                    Provider.of<ContactProvider>(context).hiddenContacts;

                return ListTile(
                  isThreeLine: true,
                  leading: Text("${i + 1}"),
                  title: Text("${contacts[i].name}"),
                  trailing: IconButton(
                    icon: Icon(Icons.contacts_outlined),
                    onPressed: () {
                      Provider.of<ContactProvider>(context, listen: false)
                          .unhideContact(data: contacts[i]);
                    },
                  ),
                  subtitle:
                      Text("${contacts[i].email} \n${contacts[i].website}"),
                );
              },
            ),
    );
  }
}
