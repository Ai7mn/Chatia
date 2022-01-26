import 'package:chatia/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactBar extends StatelessWidget {
  ContactBar(this.email, this.username, this.userId, this.isMe, this.isPeer,
      {this.key});

  final Key key;
  final String email;
  final String username;
  final String userId;
  final bool isMe;
  final bool isPeer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (isMe)
          InkWell(
            child: Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(5)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 2,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(radius: 50, child: Text(username[0])),
                title: Text(username),
                subtitle: Text(email),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen(email , key)));
            },
          ),
        /////############
        if (isPeer)
          InkWell(
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading');
                  }
                  return Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(5)),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(radius: 50, child: Text(snapshot.data['username'][0])),
                      title: Text(snapshot.data['username'],),
                      subtitle: Text(snapshot.data['email'],),
                    ),
                  );
                }),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen(email , key)));
            },
          ),
      ],
    );
  }
}
