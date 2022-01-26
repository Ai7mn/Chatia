import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMassage extends StatefulWidget {
  NewMassage(this.email , this.key);

  final String email;
  final Key key;
  @override
  _NewMassageState createState() => _NewMassageState();
}

class _NewMassageState extends State<NewMassage> {

  final _controller = new TextEditingController();

  var _enteredMassage = '';

  void _sendMassage() async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('contacts')
        .doc(widget.key.toString())
        .collection('chats')
        .add({
      'text': _enteredMassage ,
      'createdAt': Timestamp.now(),
      'userId': user.uid ,
      'receiverEmail': widget.email,
    });
    _controller.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 9,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Send massage"),
              onChanged: (value) {
                setState(() {
                  _enteredMassage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMassage.trim().isEmpty ? null : _sendMassage ,
          ),
        ],
      ),
    );
  }
}
