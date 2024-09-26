import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
      sender: "AI Assistant",
      time: "9:48 AM",
      text: "Hello, how can I help you today?",
      isMe: false,
      profileImage: "assets/ai_assistant.png",
    ),
    Message(
      sender: "Arman Lee",
      time: "9:49 AM",
      text: "What's the weather like in San Francisco tomorrow?",
      isMe: true,
      profileImage: "assets/arman_lee.png",
    ),
    Message(
      sender: "AI Assistant",
      time: "9:50 AM",
      text: "The forecast for tomorrow is partly cloudy with a high of 68 and a low of 53.",
      isMe: false,
      profileImage: "assets/ai_assistant.png",
    ),
  ];

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        title: const Column(
          children: [
            Text(
              'AI Assistant',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Dec 30th, 2022',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(message: message);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  // asdad

  var teste = 12;

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: const Color(0xFF1E1E2C),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(
                'assets/white-robot-with-wires-wires-generative-ai-art_158863-15517.jpg'),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String time;
  final String text;
  final bool isMe;
  final String profileImage;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isMe,
    required this.profileImage,
  });
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              backgroundImage: AssetImage(message.profileImage),
              radius: 18,
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message.time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: message.isMe ? Colors.blueGrey : Colors.grey[800],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
