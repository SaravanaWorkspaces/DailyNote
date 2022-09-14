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
    return _pageContainer();
  }
}

Widget _pageContainer() {
  return Container(
    child: _tileView(),
  );
}

GridView _tileView() {
  return GridView.count(
    primary: false,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 2,
    children: <Widget>[
      _buildTileView("Today", "Count", "10"),
      _buildTileView("Test", "Today test", ""),
    ],
  );
}

Widget _buildTileView(String title, String secondaryText, String value) {
  return Center(
    child: Card(
      elevation: 8,
      color:const Color.fromARGB(255, 66, 146, 226),
      child: InkWell(
        splashColor: Colors.black.withAlpha(30),
        onTap: () {},
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  secondaryText + ": " + value,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
