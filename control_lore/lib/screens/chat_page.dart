import 'package:control_lore/models/chat_message.dart';
import 'package:control_lore/screens/app_bar.dart';
import 'package:control_lore/screens/background_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:control_lore/api_key.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _sendMessage = TextEditingController();

  final ValueNotifier<List<ChatMessage>> _messagesNotifier =
      ValueNotifier<List<ChatMessage>>([
    ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
    ),
    ChatMessage(
      messageContent: "How have you been?",
      messageType: "receiver",
    ),
    ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender",
    ),
    ChatMessage(
      messageContent: "ehhhh, doing OK.",
      messageType: "receiver",
    ),
    ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageType: "sender",
    ),
  ]);

  Future<String?> initGemini() async {
    final model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: apiKey,
    );
    const prompt = "Write a story about a magic backpack";
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    print(response.text);
    return response.text;
  }

  void _sendMessageItem() {
    if (_sendMessage.text.isNotEmpty) {
      setState(() {
        // messages.add(ChatMessage(
        //     messageContent: _sendMessage.text, messageType: "sender"));
        _messagesNotifier.value = [
          ..._messagesNotifier.value,
          ChatMessage(messageContent: _sendMessage.text, messageType: "sender")
        ];
        _sendMessage.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _messagesNotifier.addListener(_onMessagesChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messagesNotifier.removeListener(_onMessagesChanged);
    _messagesNotifier.dispose();
    _sendMessage.dispose();
    super.dispose();
  }

  void _onMessagesChanged() {
    print("New itemm addded : ${_messagesNotifier.value.last}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
        // theChildWidget: Center(
        //   child: Column(
        //     children: [
        //       Text("Welcome to chat page"),
        //       ElevatedButton(
        //         onPressed: () async {},
        //         child: Text("Bruh"),
        //       )
        //     ],
        //   ),
        // ),
        theChildWidget: Stack(
          children: [
            ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: _messagesNotifier,
              builder: (context, messages, _) {
                return ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _sendMessage,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: _sendMessageItem,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
