
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:TicTacTicTacToe/gamescreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'TicTacTicTacToe',
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _boardSize = "19x19";
  String _difficulty = "easy";
  Color delftblue = const Color.fromARGB(255, 29, 47, 111);
  Color chestnut = const Color.fromARGB(255, 142, 68, 61);
  Color alabaster = const Color.fromARGB(255, 221, 229, 220);
  Color smokyblack = const Color.fromARGB(255, 17, 14, 3);
  bool _isLoading = false;


  //Navigate to the Game
  void _navigateToGamePage() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 3500)); // Add a delay for demonstration purposes only
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GamePage(_difficulty, _boardSize)),
    );

  }

  //Disable back button
  Future<bool> onWillPop() async {
    return false;
  }

  //Build the UI
  @override
  Widget build(BuildContext context) {
    return  WillPopScope( onWillPop: onWillPop ,child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: const Center(
          child : Text('TicTacTicTacToe',
          style:  TextStyle(


          fontWeight: FontWeight.bold, // set the font weight of the text

        ),),
    )),
    body:  _isLoading
        ? Center( child:CircularProgressIndicator())// Show a loading indicator if isLoading is true
        : Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      const Text(
        'HOW TO PLAY: You have to put at least 5 pieces in line (horizontal, vertical diagonal) before your opponent does',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),




        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const Center(
          child: Text(
          'Board Size',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 200, // set the width to your desired value
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _boardSize = '19x19';
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              primary: _boardSize == '19x19' ? Colors.blue : Colors.cyan[400],
              elevation: _boardSize == '19x19' ? 2 : 0,
            ),
            child: const Text('19x19'),
          ),
        ),
        SizedBox(
          width: 200, // set the width to your desired value
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _boardSize = '30x30';
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              primary: _boardSize == '30x30' ? Colors.blue : Colors.cyan[400],
              elevation: _boardSize == '30x30' ? 2 : 0,
            ),
            child: const Text('30x30'),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Difficulty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 200, // set the width to your desired value
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _difficulty = 'easy';
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              primary: _difficulty == 'easy' ? Colors.blue : Colors.cyan[400],
              elevation: _difficulty == 'easy' ? 2 : 0,
            ),
            child: const Text('Easy'),
          ),
        ),
        SizedBox(
          width: 200, // set the width to your desired value
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _difficulty = 'medium';
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              primary: _difficulty == 'medium' ? Colors.blue : Colors.cyan[400],
              elevation: _difficulty == 'medium' ? 2 : 0,
            ),
            child: const Text('Medium'),
          ),
        ),
        SizedBox(
            width: 200, // set the width to your desired value
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulty = 'expert';
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                primary: _difficulty == 'expert' ? Colors.blue : Colors.cyan[400],
                elevation: _difficulty == 'expert' ? 2 : 0,
              ),
              child: const Text('Expert'),
            ),),



            ])),








      ElevatedButton(
        onPressed: () {
          _navigateToGamePage();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          primary: Colors.grey[700],
          elevation: 2,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 13),
          child: Text(
            'PLAY NOW',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () {
          exit(0);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          primary: Colors.redAccent,
          elevation: 2,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 13),
          child: Text(
            'EXIT',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      )
    ],
    ),
    ),
    ));
  }
}

