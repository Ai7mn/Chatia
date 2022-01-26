import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MassageBubble extends StatelessWidget {
  MassageBubble(this.massage, this.isMe, this.isPeer,this.userId, this.receiverEmail, {this.key});

  final Key key;
  final String userId;
  final String massage;
  final bool isMe;
  final bool isPeer;
  final String receiverEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12)),
          ),
          width: 240,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading');
                  }
                  return Text(
                    snapshot.data['username'],
                    style: TextStyle(fontWeight: FontWeight.bold ,color: isMe ? Colors.black : Colors.black,),
                  );
                },
              ),
              Text(
                massage,
                style: TextStyle(color: isMe ? Colors.black : Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
