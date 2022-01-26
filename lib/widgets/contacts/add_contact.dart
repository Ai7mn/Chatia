import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _controller = new TextEditingController();
  var _enteredEmail = '';
  bool isMyEmail = false;
  bool emailExists = false;
  String msg = '';

  void _addContact() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final QuerySnapshot theContact = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _enteredEmail.trim())
        .get();

    final QuerySnapshot myContacts = await FirebaseFirestore.instance
        .collection('contacts')
        .where('userId', isEqualTo: user.uid)
        .get();

      if(myContacts.docs.contains(_enteredEmail)){
        emailExists = true;
      }
    if (user.email == theContact.docs[0]['email']) {
      isMyEmail = true;
    }
    else if(emailExists){
      msg = "This email is already a contact.";
    }
    else {
      FirebaseFirestore.instance.collection('contacts').add({
        'email': theContact.docs[0]['email'],
        'username': theContact.docs[0]['username'],
        'addedAt': Timestamp.now(),
        'userId': user.uid,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(
            bottom: 9,
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Insert Email"),
                  onChanged: (value) {
                    setState(() {
                      _enteredEmail = value;
                    });
                  },
                ),
              ),
              IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.check_circle),
                  //onPressed: _enteredEmail.trim().isEmpty ? null : _addContact ,
                  onPressed: () {
                    if (_enteredEmail.trim().isEmpty) {
                    } else if (isMyEmail) {
                    } else {
                      _addContact();
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
