import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/model/message_model.dart';
import 'package:sarahah_chat/model/user_model.dart';
import 'package:sarahah_chat/provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  static final String routeNamed = '/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  var _enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    final chatProvier = Provider.of<ChatProvider>(context, listen: false);
    final user = ModalRoute.of(context).settings.arguments as UserModel;
    chatProvier.fetchMessages(user.fierbaseUID);
    AppConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: AppConfig.blockSizeVertical * 1),
          child: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            backgroundImage: NetworkImage(user.photoUrl),
            radius: 35,
          ),
        ),
        title: Text(user.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: chatProvier.getMessages,
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data.length > 0
                        ? buildMessage(snapshot.data, user.fierbaseUID)
                        : Center(
                            child: Text('Say Hello'),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppConfig.blockSizeVertical * 2,
                horizontal: AppConfig.blockSizeHorizontal * 5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write a message...',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _enteredMessage = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _enteredMessage.trim().isEmpty
                      ? null
                      : () {
                          FocusScope.of(context).unfocus();
                          chatProvier.sendMessage(user.fierbaseUID,
                              _enteredMessage, Timestamp.now());
                          _controller.clear();
                        },
                  color: Colors.pinkAccent,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMessage(List<MessageModel> userMessage, String user) {
    AppConfig().init(context);
    return ListView.builder(
      itemCount: userMessage.length,
      reverse: true,
      itemBuilder: (context, index) => Row(
        mainAxisAlignment: user !=
                userMessage[index]
                    .facebookUIDOfOther // this is the second user not me,
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Container(
            width: userMessage[index].message.length < 25
                ? null
                : MediaQuery.of(context).size.width / 1.5,
            margin: EdgeInsets.symmetric(
                horizontal: AppConfig.blockSizeHorizontal * 2,
                vertical: AppConfig.blockSizeVertical * 0.5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: user !=
                      userMessage[index]
                          .facebookUIDOfOther // this is the second user not me,
                  ? Colors.purple
                  : Colors.grey[300],
              borderRadius: user !=
                      userMessage[index]
                          .facebookUIDOfOther // this is the second user not me
                  ? BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    )
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
            ),
            child: Text(
              userMessage[index].message,
              style: TextStyle(
                color: user !=
                        userMessage[index]
                            .facebookUIDOfOther // this is the second user not me,
                    ? Colors.white
                    : Colors.black,
                fontSize: AppConfig.blockSizeVertical * 2.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
