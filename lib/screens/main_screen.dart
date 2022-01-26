
import 'package:chatia/widgets/contacts/add_contact.dart';
import 'package:chatia/widgets/contacts/contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2 ,
        title: Text("Chatia"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              //First item -logout
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
              //Second item - Add Contact
                DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_comment),
                      SizedBox(
                        width: 8,
                      ),
                      Text('addContact'),
                    ],
                  ),
                ),
                value: 'addContact',
              ),

            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
              else if (itemIdentifier == 'addContact') {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> AddContact()));
              }
            },
          ),
        ], // actions
      ),
      body: Container(
        color: Colors.amber[50],
        child: Column(
          children: <Widget>[
            Expanded(
              child: Contacts(),
            ),
          ],
        ),
      ),
    );
  }
}
