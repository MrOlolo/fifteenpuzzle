import 'package:flutter/material.dart';
import 'package:fifteenpuzzle/presenter.dart';

class GameBoard extends StatefulWidget {
  @override
  GameBoardState createState() => GameBoardState();
}

class GameBoardState extends State<GameBoard> implements BoardView {
  var _presenter = Presenter();
  var _info = 0;
  var _tiles = List();
  var _grats = false;
  static final dimension = 16;
  final barTitle = 'Fifteen Puzzle';

  @override
  void updateView(List list) {
    setState(() {
      _tiles = list;
      _info = _presenter.updateStepCounter();
    });
  }

  @override
  void win(bool grats) {
    _grats = grats;
  }

  @override
  Widget build(BuildContext context) {
    _boardView();
    _presenter.start();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(barTitle)),
      ),
      body: Center(
        child: Column(children: [
          Text('$_info', style: TextStyle(fontSize: 20)),
          GridView.count(
              primary: true,
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: _buildGridTileList(_tiles),
              shrinkWrap: true),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _presenter.restart,
        child: Icon(Icons.repeat),
      ),
    );
  }

  _boardView() {
    _presenter.board = this;
  }

  List<Widget> _buildGridTileList(List list) {
    return List.generate(dimension, (int index) => _buildTile(list, index));
  }

  Widget _buildTile(var list, var index) {
    var tileColor;
    var tileIndex;
    var gratsString = 'YOU WIN';
    var numberInTile = list[index];

    if (numberInTile == dimension) {
      //tileColor = Colors;
      tileIndex = '';
    } else {
      tileColor = Colors.green;
      tileIndex = '$numberInTile';
    }

    if (_grats) {
      tileColor = Colors.deepPurple;
      tileIndex = gratsString;
    }

    final tileContainer = Container(
        color: tileColor,
        child: Center(
          child: Text(
            tileIndex,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));

    final tapToTileDetector = GestureDetector(
      onTap: () {
        _presenter.tapToTile(index);
      },
      child: tileContainer,
    );

    return tapToTileDetector;
  }
}
