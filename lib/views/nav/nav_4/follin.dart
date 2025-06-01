import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/exports.dart';
import 'package:get/get.dart';

class Follin extends StatefulWidget {
  const Follin({Key? key}) : super(key: key);

  @override
  State<Follin> createState() => _FollinState();
}

class _FollinState extends State<Follin> {

  UserController userController = Get.put(UserController());
  UserModel? _userData;
  UserModel? newData;

  Future<void> getData() async {
    final userModel = await userController.fetchUserData();
    setState(() {
      _userData = userModel;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  _showOptionsDialog(BuildContext context) async {
    // setState(() {
    return showDialog(context: context, builder: (context) => SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () {},
          child: Container(
            // color: Colors.white12,
            child: const Center(
              child: Text('Looking for someone to follow?.. go and read your books!!!!',),
            ),
          ),
        ),
      ],
    ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return userController.isLoading.value
      ? const Center(child: CircularProgressIndicator())
      : Column(
          children: [
            // SEARCH CONTAINER
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                // color: context.theme.appBarColor,
                // border: Border.all(
                //   color: Colors.orange,
                //   // (0xFFFD6104),
                //   width: 1.5,
                //   style: BorderStyle.solid
                // ),
                borderRadius: BorderRadius.circular(7.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.search,
                        // color: context.theme.greyColor,
                      ),),
                      SizedBox(width: 10.0),
                      Text('Search', style: TextStyle(
                        // color: context.theme.greyColor,
                      ),)
                    ],
                  ),
                  IconButton(onPressed: () => _showOptionsDialog(context), icon: Icon(Icons.add),
                    // color: context.theme.greyColor,
                  ),
                ],
              )
            ),
            // CONTENT
            _userData!.following!.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        'The people you follow will appear here.',
                        style:  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
                      child:  GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0,  childAspectRatio: 0.8),
                        itemCount: _userData!.following!.length,
                        itemBuilder: (context, index) => FriendCardWidget(context, _userData!.following![index], 'assets/images/chukwuchi.jpg'),
                      ),
                    ),
                )
          ]
        );
  }
}
