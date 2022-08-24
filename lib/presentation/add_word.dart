import 'package:daily_note/business_logic/addword/addword_bloc.dart';
import 'package:daily_note/business_logic/addword/addword_event.dart';
import 'package:daily_note/business_logic/addword/addword_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/presentation/word_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({Key? key}) : super(key: key);

  @override
  _AddWordScreenState createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddScreenBloc>(
          create: (_) => getItInstance<AddScreenBloc>(),
        ),
      ],
      child: const AddWordPage(),
    );
  }
}

class AddWordPage extends StatefulWidget {
  const AddWordPage({Key? key}) : super(key: key);

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final _wordEditController = TextEditingController();
  final _meaningEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String word;
  late String meaning;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _addWordForm(),
    );
  }

  void _clearFormField() {
    _wordEditController.clear();
    _meaningEditController.clear();
  }

  //=============Form Widgets =========//
  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: _launchWordList,
            child: const Icon(
              Icons.list,
              size: 26.0,
            ),
          ),
        )
      ],
      title: const Text("Home"),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Form _addWordForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Focus(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildWordTextFormField(),
              const SizedBox(height: 20),
              _buildMeaningTextFormField(),
              const SizedBox(height: 32),
              _micHelperText(),
              Expanded(
                child: Align(
                  child: _elevatedButton(),
                  alignment: Alignment.bottomCenter,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<AddScreenBloc, AddWordState> _buildWordTextFormField() {
    return BlocConsumer<AddScreenBloc, AddWordState>(
      buildWhen: (previous, current) => current is UpdateWord,
      listenWhen: (previous, current) => current is UpdateWord,
      listener: (context, state) {
        if (state is UpdateWord) {
          _wordEditController.text = state.word as String;
        }
      },
      builder: (context, state) {
        return TextFormField(
            controller: _wordEditController,
            autofocus: false,
            validator: (value) {
              if (value != null && value.isEmpty) {
                return "Please enter word";
              }
              return null;
            },
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: "Add Word",
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<AddScreenBloc>().add(ListenWord());
                },
                icon: const Icon(Icons.mic),
              ),
            ),
            onChanged: (value) => word = value);
      },
    );
  }

  BlocConsumer<AddScreenBloc, AddWordState> _buildMeaningTextFormField() {
    return BlocConsumer(
      buildWhen: (previous, current) => current is UpdateMeaning,
      listenWhen: (previous, current) => current is UpdateMeaning,
      listener: (context, state) {
        if (state is UpdateMeaning) {
          _meaningEditController.text = state.word as String;
        }
      },
      builder: (context, state) {
        return TextFormField(
            controller: _meaningEditController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<AddScreenBloc>().add(ListenMeaning());
                  },
                  icon: const Icon(Icons.mic),
                ),
                border: const UnderlineInputBorder(),
                labelText: "Add Meaning"),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return "Please enter meaning";
              }
              return null;
            },
            onChanged: (value) => meaning = value,
            onEditingComplete: _addWord);
      },
    );
  }

  BlocListener<AddScreenBloc, AddWordState> _elevatedButton() {
    return BlocListener<AddScreenBloc, AddWordState>(
        listenWhen: (previous, current) => current is WordAdded,
        listener: (context, state) {
          if (state is WordAdded) {
            _clearFormField();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("New word added successfully!")));
          } else if (state is WordFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40)),
            onPressed: _addWord,
            child: const Text(" Add Word")));
  }

  Padding _micHelperText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Text(
          "Tap mic icon to record specific values",
          style: TextStyle(
              fontSize: 18.0, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

//============ Private functions =======//
  void _addWord() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      word = _wordEditController.text;
      meaning = _meaningEditController.text;
      context.read<AddScreenBloc>().add(AddWord(word, meaning));
    }
  }

  void _launchWordList() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const WordListScreen()));
  }
}
