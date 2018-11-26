import 'dart:math';

enum GameState { game, win, stop }

final dim = 16;

class Puzzle {
  var _moves = 0;
  var _tiles = List.generate(dim, (int index) => (index + 1));
  GameState status = GameState.stop;

  int get steps => _moves;

  List get tiles => _tiles;

  List getIndices(int index) {
    var suitableIndices = List();
    final type = [(index ~/ 4), index % 4];
    final shift = [4, 1];
    for (int i = 0; i < 2; i++) {
      if ([1, 2].contains(type[i])) {
        suitableIndices.addAll([index + shift[i], index - shift[i]]);
      }
      if (type[i] == 0) suitableIndices.add(index + shift[i]);
      if (type[i] == 3) suitableIndices.add(index - shift[i]);
    }
    return suitableIndices;
  }

  void _tilesExchange(var firstIndex, var secondIndex) {
    _tiles[secondIndex] = _tiles[firstIndex];
    _tiles[firstIndex] = dim;
  }

  bool _notExist(var index) {
    if ((index >= 0) & (index < dim)) return false;
    return true;
  }

  void _generateBoard() {
    var rand = Random();
    var i = 100;
    var indexOfZero;
    var randIndex;
    List suitableIndices;
    while (i != 0) {
      indexOfZero = _tiles.indexOf(dim);
      suitableIndices = getIndices(indexOfZero);
      randIndex = suitableIndices[rand.nextInt(suitableIndices.length)];
      if (_notExist(randIndex)) continue;
      _tilesExchange(randIndex, indexOfZero);
      i--;
    }
  }

  bool _win() {
    var n = 0;
    while ((_tiles[n] == ++n) & (n < dim)) {}
    if (n == 16) return true;
    return false;
  }

  bool move(var index) {
    if (status != GameState.game) return false;
    if (_notExist(index)) return false;

    final indexOfZero = _tiles.indexOf(dim);
    final colCheck = getIndices(indexOfZero);
    if (colCheck.contains(index)) {
      _tilesExchange(index, indexOfZero);
      _moves++;
      if (_win()) status = GameState.win;
      return true;
    }
    return false;
  }

  void restart() {
    _generateBoard();
    _moves = 0;
    status = GameState.game;
  }

  void start() {
    if (status == GameState.stop) {
      restart();
    }
  }
}
