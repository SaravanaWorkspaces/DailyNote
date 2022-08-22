import 'package:daily_note/business_logic/home_screen_bloc.dart';
import 'package:daily_note/business_logic/home_screen_event.dart';
import 'package:daily_note/business_logic/home_screen_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/presentation/word-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBloc>(
          create: (_) => getItInstance<HomeScreenBloc>(),
        ),
      ],
      child: const HomePage(),
    ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            ),)
      ],
      title: const Text("Home"),
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

  BlocConsumer<HomeScreenBloc, HomeScreenState> _buildWordTextFormField() {
    return BlocConsumer(
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
                  context.read<HomeScreenBloc>().add(ListenWord());
                },
                icon: const Icon(Icons.mic),
              ),
            ),
            onChanged: (value) => word = value);
      },
    );
  }

  BlocConsumer<HomeScreenBloc, HomeScreenState> _buildMeaningTextFormField() {
    return BlocConsumer(
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
                    context.read<HomeScreenBloc>().add(ListenMeaning());
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

  BlocListener<HomeScreenBloc, HomeScreenState> _elevatedButton() {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
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
      word    = _wordEditController.text;
      meaning = _meaningEditController.text;
      context.read<HomeScreenBloc>().add(AddWord(word, meaning));
    }
  }

  void _launchWordList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WordListPage()));
  }
}
