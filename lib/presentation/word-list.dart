import 'package:daily_note/locator.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:flutter/material.dart';

import '../model/Word.dart';

class WordListPage extends StatelessWidget {
  const WordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Word list"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
        ),
        body: const WordListView(),
      ),
    );
  }
}

class WordListView extends StatefulWidget {
  const WordListView({Key? key}) : super(key: key);

  @override
  _WordListViewState createState() => _WordListViewState();
}

class _WordListViewState extends State<WordListView> {
  List<Word> wordList = [];

  @override
  void initState() {
    _fetchWords();
    super.initState();
  }

  Future _fetchWords() async {
    final dbInstance = getItInstance<DatabaseHelper>();
    wordList = await dbInstance.readAllWords();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return wordList.isEmpty ? _buildFriendlyText() : _buildListView();
  }

  _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: wordList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 50,
              child: ListTile(
                title: Text(wordList[index].word),
                subtitle: Text(wordList[index].meaning),
              ));
        });
  }

  _buildFriendlyText() {
    return const Center(
      child: Text(
        "Nothing to display",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
