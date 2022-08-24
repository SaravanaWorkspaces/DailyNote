import 'package:daily_note/presentation/add_word.dart';
import 'package:daily_note/presentation/word_list.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddWordScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WordListScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.list,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: const _DashboardPage(),
      );
  }
}

class _DashboardPage extends StatefulWidget {
  const _DashboardPage({Key? key}) : super(key: key);

  @override
  State<_DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<_DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("Hey");
  }
}
