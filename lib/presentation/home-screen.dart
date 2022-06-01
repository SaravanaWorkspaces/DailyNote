import 'package:daily_note/repo/database-helper.dart';
import 'package:daily_note/model/Word.dart';
import 'package:daily_note/presentation/word-list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String word;
  late String meaning;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WordListPage()));
                    },
                    child: const Icon(
                      Icons.list,
                      size: 26.0,
                    ),
                  ))
            ],
            title: const Text("Home"),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Add Word",
                        suffixIcon: Icon(Icons.mic)),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please enter word";
                      }
                      return null;
                    },
                    onChanged: (value) => word = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Add Meaning",
                        suffixIcon: Icon(Icons.mic)),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please enter meaning";
                      }
                      return null;
                    },
                    onChanged: (value) => meaning = value,
                  ),
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Text(
                        "Tap mic icon to record specific values",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40)),
                        onPressed: addWord,
                        child: const Text(" Add Word")),
                    alignment: Alignment.bottomCenter,
                  ))
                ],
              ),
            ),
          )),
    );
  }

  addWord() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      try {
        await DatabaseHelper.instance
            .create(Word(word: word, meaning: meaning));
      } catch (e) {}
    }
  }
}
