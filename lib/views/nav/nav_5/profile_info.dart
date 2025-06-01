import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  String sub;
  String hintValue;
  TextEditingController mainController;

  ProfileInfo({super.key, required this.sub, required this.hintValue, required this.mainController});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(widget.sub),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Fill in details...',
            ),
            controller: widget.mainController,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: Text('Done'),
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(widget.mainController.text);

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // final widget;.hintValue = name;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: double.infinity,
      // color: context.theme.appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.sub,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              // color: context.theme.textColor,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final name = await openDialog();
              if (name == null || name.isEmpty) return;

              setState(() {
                widget.hintValue = name;
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: Text(
                    widget.hintValue,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
