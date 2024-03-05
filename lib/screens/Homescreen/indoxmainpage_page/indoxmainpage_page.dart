import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndoxmainpagePage extends StatefulWidget {
  const IndoxmainpagePage({Key? key}) : super(key: key);

  @override
  _IndoxmainpagePageState createState() => _IndoxmainpagePageState();
}

class _IndoxmainpagePageState extends State<IndoxmainpagePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<Message> messages = snapshot.data!.docs
                      .map((doc) => Message.fromFirestore(doc))
                      .toList();

                  return ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Message message = messages[index];
                      return FutureBuilder<String?>(
                        future: getNickname(message.senderId),
                        builder: (context, nicknameSnapshot) {
                          if (nicknameSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          String senderNickname =
                              nicknameSnapshot.data ?? 'Unknown User';
                          return _buildMessageWidget(message, senderNickname);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Inbox'),
    );
  }

  Widget _buildMessageWidget(Message message, String senderNickname) {
    return Align(
      alignment: message.senderId == getUserId()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.senderId == getUserId() ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$senderNickname:',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                message.timestamp != null
                    ? _formatDateTime(message.timestamp!)
                    : '',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 100.0,
              ),
              child: TextField(
                controller: _textController,
                maxLines: null,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              sendMessage(_textController.text);
              _textController.clear();
            },
          ),
        ],
      ),
    );
  }

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String amPm = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = dateTime.minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $amPm';
  }

  Future<String?> getNickname(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    return userData['nickname'];
  }

  Future<void> sendMessage(String text) async {
    String? userId = getUserId();
    if (userId != null) {
      await FirebaseFirestore.instance.collection('messages').add({
        'senderId': userId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  String? getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}

class Message {
  final String senderId;
  final String text;
  final Timestamp? timestamp;

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      senderId: data['senderId'],
      text: data['text'],
      timestamp: data['timestamp'],
    );
  }
}
