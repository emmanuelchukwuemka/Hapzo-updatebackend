import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/user_utils.dart';
import 'package:haptext_api/views/nav/exports.dart';

class EditProfile extends StatefulWidget {
  UserModel? userData;
  EditProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController tagNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  TextEditingController biographyController = TextEditingController();

  bool isLoading = false; 

  Future<UserModel?> updateProfile() async {
    var token = await getUserToken();
    var profileId = await getProfileId();

    try {
      var url = Uri.parse(
          "https://hapztext.onrender.com/api/v1/user/profile/$profileId/");
      var head = {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      };
      // _isLoading.value = true;
      final response = await http.put(
        url,
        headers: head,
        body: jsonEncode(<String, dynamic>{
          'first_name': nameController.text.trim(),
          'birth_date': birthdayController.text,
          'username': tagNameController.text,
          'occupation': roleController.text,
          'height': heightController.text,
          'weight': weightController.text,
          'ethnicity': ethnicityController.text,
          'relationship_status': statusController.text,
          'lookingFor': lookingForController.text,
          'bio': biographyController.text,
        }),
      );

      print(token);
      print(profileId);
      print('Response:');
      print(response.body);

      if (response.statusCode == 202) {
        // Profile updated successfully
        print('Updating');
        final jsonData = jsonDecode(response.body);
        // _isLoading.value = false;
        print('Profile updated');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        final userModel = UserModel.fromJson(jsonData);
        return userModel;
      } else {
        // Profile update failed
        print('Update failed');
        // _isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile'),
          ),
        );

        return null;
      }
    } on HttpException catch (error) {
      print('HttpException: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('HTTP Exception: $error')),
      );

      return null;
    } on FormatException catch (error) {
      print('FormatException: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid JSON format')),
      );
      return null;
    } catch (error) {
      // _isLoading.value = false;
      // Error occurred during the API call
      print('Unknown Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating profile. Please try again later.'),
        ),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: context.theme.bgColor,
      appBar: AppBar(
        // backgroundColor: context.theme.appBarColor,
        iconTheme: const IconThemeData(
            // color: context.theme.primaryColor,
            ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              // color: context.theme.titleTextColor,
              ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            // color: context.theme.bgColor,
            icon: const Icon(
              Icons.more_vert,
              size: 22,
              // color: context.theme.primaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (_) => Blocked(),),
                    // );
                  },
                  // onLongPress: () {
                  //   Navigator.push(
                  //       context, MaterialPageRoute(builder: (_) => Settings(),),
                  //   );
                  // },
                  child: const Text('Blocked'),
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const PicsChange(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'About You',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  // color: context.theme.textColor,
                ),
              ),
            ),

            // INFO
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ProfileInfo(
                    sub: 'Name',
                    hintValue: widget.userData?.firstName ?? 'Your name',
                    mainController: nameController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Tag Name',
                    hintValue: '@${widget.userData?.tagname}',
                    mainController: tagNameController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Birthday',
                    hintValue: widget.userData?.birthDate ?? 'yyyy-mm-dd',
                    mainController: birthdayController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Role',
                    hintValue: widget.userData?.occupation ?? 'Position',
                    mainController: roleController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Height',
                    hintValue: widget.userData?.height.toString() ?? '0.00',
                    mainController: heightController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Weight',
                    hintValue: widget.userData?.weight.toString() ?? '0.00',
                    mainController: weightController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Ethnicity',
                    hintValue:
                        widget.userData?.ethnicity ?? 'Christianity/Islamic',
                    mainController: ethnicityController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Relationship status',
                    hintValue: widget.userData?.relationshipStatus ??
                        'Single/Married/Divorced...',
                    mainController: statusController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Looking for',
                    hintValue:
                        widget.userData?.lastName ?? 'Games/Anime/Sports/...',
                    mainController: lookingForController,
                  ),
                  const SizedBox(height: 8),
                  ProfileInfo(
                    sub: 'Biography',
                    hintValue: widget.userData?.bio ?? 'Edit',
                    mainController: biographyController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              // color: context.theme.appBarColor,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        // color: context.theme.primaryColor,
                      ),
                      Text(
                        'Current location',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          // color: context.theme.textColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Umuahia, Abia State',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              // color: context.theme.appBarColor,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        // color: context.theme.primaryColor,
                      ),
                      Text(
                        'Last visited location',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          // color: context.theme.textColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Lagos, Nigeria',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),

            // UPDATE PROFILE METHOD CALLED
            Center(
              child: SizedBox(
                width: size.width * 0.65,
                child:  Appbutton(
                        onTap: () {
                         
                          updateProfile();
                        },
                        label: 'Save',
                      ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
