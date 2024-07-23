import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/contact_provider.dart';
import 'package:rwa1_adv_flutter_5pm/models/contact_model.dart';
import 'package:share_plus/share_plus.dart';
import '../../controllers/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    ContactModel contact =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Page",
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "Name: ${contact.name}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Email: ${contact.email}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Phone: ${contact.phone}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Website: ${contact.website}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.edit),
                  onPressed: () {
                    Provider.of<ContactProvider>(context, listen: false)
                        .editContact(data: contact);

                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<ContactProvider>(context, listen: false)
                        .deleteContact(data: contact);
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.share),
                  onPressed: () async {
                    Share.share(
                        "Hello, Myself ${contact.name}. \nSave my contact no: ${contact.phone}");
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.web),
                  onPressed: () async {
                    await launchUrl(Uri.parse(contact.website));
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.phone),
                  onPressed: () async {
                    await launchUrl(Uri.parse("tel:+91" + contact.phone));
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.message),
                  onPressed: () async {
                    await launchUrl(Uri.parse("sms:+91" + contact.phone));
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(Icons.mail),
                  onPressed: () async {
                    await launchUrl(Uri.parse("mailto:" + contact.email));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
