import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helper/collection_helper.dart';
import '../Model/user_model.dart';
import '../Utils/global.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> updateData = GlobalKey<FormState>();
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
      body: Form(
        key: updateData,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            Text("${Global.userData[index]['name']}"),
            Text("${Global.userData[index]['age']}"),
            const SizedBox(height: 20),
            TextFormField(
              validator: (val){
                if(val!.isEmpty) {
                  return "Please Enter Name";
                }
              },
              controller: Global.name,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
                hintText: "Edit The Name",
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                errorStyle: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (val){
                if(val!.isEmpty) {
                  return "Please Enter Age";
                }
              },
              controller: Global.age,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
                hintText: "Edit The Age",
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                errorStyle: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(30),
              onPressed: (){
                if(updateData.currentState!.validate()){
                  Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                  UserData userData = UserData(name: Global.name.text, age: int.parse(Global.age.text));
                  CollectionHelper.instance.updateData(index: index, userData: userData);
                  Global.name.clear();
                  Global.age.clear();
                }
              },
              child: Text("Update Data", style: GoogleFonts.poppins(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
