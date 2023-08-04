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
  TextEditingController _imageController = TextEditingController();
  String? _gender;
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
            Center(
              child: CircleAvatar(
                radius: 50,
                print("hey"+$_imageController.text);
                backgroundImage: NetworkImage(_imageController.text),
              ),
            ),
            SizedBox(height: 16),
            _buildField('First Name', _firstNameController),
            _buildField('Last Name', _lastNameController),
            _buildField('Email', _emailController),
            _buildField('ID', _idController),
            Row(
              children: [
                Expanded(
                  child: Text('Gender'),
                ),
                Radio(
                  value: 'Male',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value as String?;
                      pref!.setString('Gender', value as String);
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value as String?;
                      pref!.setString('Gender', value as String);
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Perform action when the first button is pressed
                print('First Button pressed!');
              },
              child: Row(
                children: [
                  Icon(Icons.home),
                  Text('Home'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                // Perform action when the second button is pressed
                //   print('Button 2 pressed');
              },
              child: Row(
                children: [
                  Icon(Icons.person_2),
                  Text(' Account'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform action when the third button is pressed

                print('Cart');
              },
              child: Row(
                children: [
                  Icon(Icons.shopping_bag),
                  Text(' Cart'),
                ],
              ),
            ),
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
    _emailController.text = pref!.getString('email').toString();
    _gender = pref!.getString('gender');
    _idController.text = pref!.getString('id').toString();
    _imageController.text = pref!.getString('image').toString();
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
