import 'package:chatia/widgets/contacts/contact_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Contacts extends StatelessWidget {
  Future getUser()async{
    return await FirebaseAuth.instance.currentUser;
  }

  checkMyContacts(String email) async{
    final QuerySnapshot theContact = await FirebaseFirestore.instance.collection('contacts').where('email' , isEqualTo: email).get();
    return theContact.docs[0]['email'];
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
              .orderBy('addedAt', descending: true)
              .snapshots(),
          builder: (ctx, contactSnapshot) {
            if (contactSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
            }
              final chatDocs = contactSnapshot.data.docs;
              return ListView.builder(

                itemCount: chatDocs.length ,
                itemBuilder: (ctx, index) => ContactBar(
                  chatDocs[index]['email'],
                  chatDocs[index]['username'],
                  chatDocs[index]['userId'],
                  chatDocs[index]['userId'] == futureSnapshot.data.uid,
                  chatDocs[index]['email'] == futureSnapshot.data.email,
                  key: ValueKey(chatDocs[index].documentID),
                ),
              );
          },
        );
      },
    );

  }
}
