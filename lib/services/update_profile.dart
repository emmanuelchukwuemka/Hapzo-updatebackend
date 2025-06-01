// import 'dart:convert';
// import 'dart:js';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:haptext_api/exports.dart';
//
//
// Future<void> updateProfile() async {
//   try {
//     final response = await http.put(
//       Uri.parse("http://localhost:9000/social_backend/user/update/profile/:id"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'name': nameController.text,
//         'birthday': birthdayController.text,
//         'tagName': tagNameController.text,
//         'role': roleController.text,
//         'height': heightController.text,
//         'weight': weightController.text,
//         'ethnicity': ethnicityController.text,
//         'status': statusController.text,
//         'lookingFor': lookingForController.text,
//         'biography': biographyController.text,
//       }),
//     );
//     print(response.body);
//
//     if (response.statusCode == 200) {
//       // Profile updated successfully
//       print('Update successful');
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         const SnackBar(
//           content: Text('Profile updated successfully'),
//         ),
//       );
//
//       profileModel = ProfileModel.fromJson(response as Map<String, dynamic>);
//       return json.decode(response.body);
//
//     } else {
//       // Profile update failed
//       print('Update failed');
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to update profile'),
//         ),
//       );
//     }
//   } catch (error) {
//     // Error occurred during the API call
//     print('Error updating profile: $error');
//     ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//       const SnackBar(
//         content: Text('Error updating profile. Please try again later.'),
//       ),
//     );
//   }
// }