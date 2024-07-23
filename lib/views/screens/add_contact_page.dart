import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/contact_provider.dart';
import 'package:rwa1_adv_flutter_5pm/models/contact_model.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  int initialStepIndex = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  String? name, phone, email, website;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stepper(
            type: StepperType.vertical,
            currentStep: initialStepIndex,
            onStepTapped: (val) {
              setState(() {
                initialStepIndex = val;
              });
            },
            onStepContinue: () {
              if (initialStepIndex < 3) {
                setState(() {
                  initialStepIndex++;
                });
              }
            },
            onStepCancel: () {
              if (initialStepIndex > 0) {
                setState(() {
                  initialStepIndex--;
                });
              }
            },
            steps: [
              Step(
                title: Text("Personal Info"),
                subtitle: Text("Fill all the details"),
                isActive: (initialStepIndex == 0) ? true : false,
                state: StepState.indexed,
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Step(
                title: Text("Contact Info"),
                subtitle: Text("Fill all the details"),
                isActive: (initialStepIndex == 1) ? true : false,
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter your contact number",
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Step(
                title: Text("Email Info"),
                subtitle: Text("Fill all the details"),
                isActive: (initialStepIndex == 2) ? true : false,
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter your email address",
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Step(
                title: Text("Website"),
                subtitle: Text("Fill all the details"),
                isActive: (initialStepIndex == 3) ? true : false,
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: websiteController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      hintText: "Enter your website here",
                      labelText: "Website",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          OutlinedButton(
            child: Text("Submit"),
            onPressed: () {
              name = nameController.text;
              phone = phoneController.text;
              email = emailController.text;
              website = websiteController.text;

              ContactModel contact = ContactModel(
                name: name!,
                phone: phone!,
                email: email!,
                website: website!,
              );

              // call the logic => add this contact object into the allContacts list
              Provider.of<ContactProvider>(context, listen: false)
                  .addContact(data: contact);

              // navigate the user to the HomePage
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
