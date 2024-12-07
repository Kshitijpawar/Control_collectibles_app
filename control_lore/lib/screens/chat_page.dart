import 'package:control_lore/markdown_style.dart';

import 'package:control_lore/screens/app_bar.dart';
import 'package:control_lore/screens/background_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


const String _apiKey = String.fromEnvironment("API_KEY");

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
        // theChildWidget: ChatWidget(apiKey: String.fromEnvironment("API_KEY")),
        theChildWidget: ChatWidget(
          apiKey: _apiKey,
        ),
      ),
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({required this.apiKey, super.key});
  final String apiKey;
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];

  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: widget.apiKey,
    );
    _chat = _model.startChat();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textFieldDecoration = InputDecoration(
      hintStyle: TextStyle(
        fontFamily: 'ITCAvantGardeStd-Demi',
        fontWeight: FontWeight.w700,
        fontSize: 15.0,
        color: Color.fromARGB(255, 231, 0, 13),
      ),
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Ask the Board...',
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          // color: Theme.of(context).colorScheme.secondary,
          color: Color.fromARGB(255, 231, 0, 13),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          // color: Theme.of(context).colorScheme.secondary,
          color: Color.fromARGB(255, 231, 0, 13),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _apiKey.isNotEmpty
                ? ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, idx) {
                      final content = _generatedContent[idx];
                      return MessageWidget(
                        text: content.text,
                        image: content.image,
                        isFromUser: content.fromUser,
                      );
                    },
                    itemCount: _generatedContent.length,
                  )
                : ListView(
                    children: const [
                      Text(
                        'No API key found. Please provide an API Key using '
                        "'--dart-define' to set the 'API_KEY' declaration.",
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'ITCAvantGardeStd-Demi',
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    cursorColor: Color.fromARGB(255, 231, 0, 13),
                    autofocus: true,
                    focusNode: _textFieldFocus,
                    decoration: textFieldDecoration,
                    controller: _textController,
                    // onSubmitted: _sendChatMessage,
                    onSubmitted: _sendJsonPrompt,
                  ),
                ),
                const SizedBox.square(
                  dimension: 15,
                ),
                if (!_loading)
                  IconButton(
                    onPressed: () async {
                      // _sendChatMessage(_textController.text);
                      _sendJsonPrompt(_textController.text);
                    },
                    icon: Icon(
                      Icons.send,
                      // color: Theme.of(context).colorScheme.primary,
                      color: Color.fromARGB(255, 231, 0, 13),
                    ),
                  )
                else
                  const CircularProgressIndicator(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _sendJsonPrompt(String message) async {
    setState(() {
      _loading = true;
    });
    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      ByteData controlLore =
          await rootBundle.load('assets/json_file/master.json');

      final content = [
        Content.multi([
          DataPart("text/plain", controlLore.buffer.asUint8List()),
          TextPart(message),
          // The only accepted mime types are image/*.
        ])
      ];

      var response = await _model.generateContent(content);
      var text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );

      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError("No response from API.");
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Something went wrong"),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, this.image, this.text, required this.isFromUser});

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 520),
          decoration: BoxDecoration(
            color: isFromUser
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              if (text case final text?)
                MarkdownBody(
                  data: text,
                  styleSheet: markdownStyleSheet,
                ),
              if (image case final image?) image,
            ],
          ),
        ))
      ],
    );
  }
}
