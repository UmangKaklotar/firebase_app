import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/collection_helper.dart';
import '../Model/user_model.dart';
import '../Utils/global.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    WidgetsBinding.instance.addPostFrameCallback((_){
      Global.name.text = Global.userData[index]['name'];
      Global.age.text = Global.userData[index]['age'].toString();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Text("${Global.userData[index]['name']}"),
          Text("${Global.userData[index]['age']}"),
          const SizedBox(height: 20),
          TextFormField(
            controller: Global.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Edit The Name",
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: Global.age,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Edit The Age",
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton.filled(
            child: const Text("Update Data"),
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
              UserData userData = UserData(name: Global.name.text, age: int.parse(Global.age.text));
              CollectionHelper.instance.updateData(index: index, userData: userData);
              Global.name.clear();
              Global.age.clear();
            },
          ),
        ],
      ),
    );
  }
}
