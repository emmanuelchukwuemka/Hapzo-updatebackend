import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';

FriendCardWidget (context, String text, String img) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => FriendProfilePage()),);
    },
    child: Container(
      // height: 250,
      // width: 105,
      // margin: EdgeInsets.all(1.5),
      // color: context.theme.bgColor,
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Color(0xFF111B21),
        borderRadius: BorderRadius.circular(3.5),
        boxShadow: const [BoxShadow(
          color: Colors.black38,
          blurRadius: 1.0,
          offset: Offset(1, 0.5)
        )]
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage(img),
                  // fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 3),
              Text(text, style: TextStyle(color: Color(0xFFFD6104), fontWeight: FontWeight.w400),)
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 15,
              width: 15,
              margin: const EdgeInsets.only(right: 8.5, bottom: 6.0),
              decoration: BoxDecoration(
                color: Color(0xFFFD6104),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: const Center(
                child: Text(
                  '4',
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              )
            ),
          )
        ]
      ),
    ),
  );
}
