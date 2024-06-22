import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndoxmainpagePage extends StatefulWidget {
  const IndoxmainpagePage({super.key});

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

                  return ListView.separated(
                    itemCount: messages.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0.0),
                    reverse: true,
                    itemBuilder: (context, index) {
                      Message message = messages[index];
                      return FutureBuilder<Map<String, String>>(
                        future: getReceiverInfo(message.senderId),
                        builder: (context, receiverInfoSnapshot) {
                          if (receiverInfoSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          String receiverNickname =
                              receiverInfoSnapshot.data?['nickname'] ??
                                  'Unknown User';
                          String receiverProfileIcon =
                              receiverInfoSnapshot.data?['profileIcon'] ?? '';

                          return _buildMessageWidget(
                            message,
                            receiverNickname,
                            receiverProfileIcon,
                          );
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
Widget _buildMessageWidget(
  Message message,
  String receiverNickname,
  String receiverProfileIcon,
) {
  double maxContainerWidth = MediaQuery.of(context).size.width * 0.7;
  BorderRadius borderRadius;

  // Set different border radii based on whether the message is from the sender or receiver
  if (message.senderId == getUserId()) {
    borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),
    );
  } else {
    borderRadius = const BorderRadius.only(
      topRight: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
    );
  }
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Only show profile picture if it's not the current user's message
        if (message.senderId != getUserId())
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(receiverProfileIcon),
          ),
        const SizedBox(width: 3.0),
        Expanded(
          child: Align(
            alignment: message.senderId == getUserId()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: IntrinsicWidth(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 3, bottom: 3),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                constraints: BoxConstraints(
                  maxWidth: maxContainerWidth,
                ),
                decoration: BoxDecoration(
                  color: message.senderId == getUserId()
                      ? Colors.blue
                      : const Color.fromARGB(255, 90, 90, 90),
                  borderRadius: borderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.senderId != getUserId())
                      Text(
                        receiverNickname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 4.0),
                    Text(
                      message.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          message.timestamp != null
                              ? _formatDateTime(message.timestamp!)
                              : '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
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
                  hintText: 'Message...',
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
            icon: const Icon(Icons.send, color: Colors.blue),
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

  Future<Map<String, String>> getReceiverInfo(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        String receiverNickname = userData['nickname'] ?? 'Unknown User';
        String receiverProfileIcon = userData['profileUrl'] ?? '';
        return {
          'nickname': receiverNickname,
          'profileIcon': receiverProfileIcon
        };
      } else {
        return {'nickname': 'Unknown User', 'profileIcon': ''};
      }
    } catch (e) {
      print('Error getting receiver info: $e');
      return {'nickname': 'Unknown User', 'profileIcon': ''};
    }
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
