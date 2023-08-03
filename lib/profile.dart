import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/sharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  SharedPreferences? pref;
  @override
  void initState() {
    super.initState();
    // Load values from SharedPreferences and set them to the respective TextControllers
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField('First Name', _firstNameController),
            _buildField('Last Name', _lastNameController),
            _buildField('Email', _emailController),
            _buildField('ID', _idController),
            _buildField('Gender', _genderController),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _showEditDialog(label, controller),
        ),
      ],
    );
  }

  Future<void> _showEditDialog(
      String label, TextEditingController controller) async {
    TextEditingController editController =
        TextEditingController.fromValue(controller.value);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextFormField(
            controller: editController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.text = editController.text;
                print('text' + controller.text);
                pref!.setString(label, controller.text);

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  getDetails() async {
    pref = await SharedPreferences.getInstance();
    _firstNameController.text = pref!.getString('firstName').toString();
    _lastNameController.text = pref!.getString('lastName').toString();
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
