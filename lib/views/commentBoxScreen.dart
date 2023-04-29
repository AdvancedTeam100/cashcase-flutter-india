import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cashfuse/utils/images.dart';

class CommentboxScreen extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<CommentboxScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Admin',
      //Amdin's name
      'pic':
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fimg.freepik.com%2Fpremium-photo%2Fportrait-young-handsome-indian-man-white_251136-79297.jpg%3Fw%3D2000&tbnid=IttNisqQjFwonM&vet=12ahUKEwiqhbb_58v-AhUSwioKHXN6Ai0QMygTegUIARCUAg..i&imgrefurl=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Findian-male-face&docid=x9lBgAZcMK6xqM&w=2000&h=1500&q=india%20man%20face&ved=2ahUKEwiqhbb_58v-AhUSwioKHXN6Ai0QMygTegUIARCUAg',
      //Admin's picture
      'message': 'I love to code',
      //the message that admin send to me
      'date': '2021-01-01 12:00:00'
      //the date of admin send a message to me
    },
  ];

  Widget commentChild(data) {
    //comment list
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(data[i]['date'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //comment input
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath:
                  "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn1.vectorstock.com%2Fi%2F1000x1000%2F94%2F40%2Findian-man-face-avatar-cartoon-vector-25919440.jpg&tbnid=6PFcZfoC5lCpxM&vet=12ahUKEwifzMGK5Mv-AhURuyoKHTtBBRUQMygregUIARC9Ag..i&imgrefurl=https%3A%2F%2Fwww.vectorstock.com%2Froyalty-free-vector%2Findian-man-face-avatar-cartoon-vector-25919440&docid=-JbtX1c0pIvndM&w=800&h=1080&q=india%20man%20face%20images&ved=2ahUKEwifzMGK5Mv-AhURuyoKHTtBBRUQMygregUIARC9Ag"),
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                      'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                  //user's picture
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.grey[200],
          textColor: Colors.black,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.black),
        ),
      ),
    );
  }
}
