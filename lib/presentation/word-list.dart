import 'package:daily_note/business_logic/word_list_cubit.dart';
import 'package:daily_note/business_logic/word_list_state.dart';
import 'package:daily_note/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocProvider<WordListCubit>(
          create: (_) => getItInstance<WordListCubit>(),
          child: const WordListView(),
        ),
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
  @override
  void initState() {
    context.read<WordListCubit>().loadWordList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordListCubit, WordListState>(builder: (context, state) {
      if (state is WordList) {
        return _buildListView(state.data);
      }
      return _buildFriendlyText();
    });
  }

  ListView _buildListView(List<Word> wordList) {
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

  Center _buildFriendlyText() {
    return const Center(
      child: Text(
        "Nothing to display",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
