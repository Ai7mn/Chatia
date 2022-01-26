import 'package:chatia/widgets/chat/massage_bubble.dart';
import 'package:chatia/widgets/contacts/contact_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Massages extends StatelessWidget {
  Massages(this.email, this.key);

  final String email;
  final Key key;

  Future getUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (cxt, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('contacts')
              .doc(key.toString())
              .collection('chats')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data.docs;

            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MassageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] == futureSnapshot.data.uid,
                chatDocs[index]['receiverEmail'] == email,
                chatDocs[index]['userId'],
                chatDocs[index]['receiverEmail'],
                key: ValueKey(chatDocs[index].documentID),
              ),
            );
          },
        );
      },
    );
  }
}
