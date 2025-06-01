import 'package:flutter/material.dart';

class PicsChange extends StatefulWidget {
  const PicsChange({super.key});

  @override
  State<PicsChange> createState() => _PicsChangeState();
}

class _PicsChangeState extends State<PicsChange> {
  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          const SimpleDialogOption(
            // onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 10.0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 10.0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              return showOptionsDialog(context);
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/me.jpg'),
                      fit: BoxFit.cover,),),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: Icon(Icons.camera_alt_outlined,
                        color: Colors.grey[300],),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 70),
          InkWell(
            onTap: () {
              return showOptionsDialog(context);
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/landscape3.jpg'),
                      fit: BoxFit.cover,),),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: Icon(Icons.camera_alt_outlined,
                        color: Colors.grey[300],),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
