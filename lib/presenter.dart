import 'package:fifteenpuzzle/core.dart';

class BoardView {
  void updateView(List tiles) {}

  void win(bool grats) {}
}

class Presenter {
  var _game = Puzzle();
  BoardView board;

  int updateStepCounter() {
    return _game.steps;
  }

  void tapToTile(int index) {
    if (_game.move(index)) {
      board.updateView(_game.tiles);
      if (_game.status == GameState.win) board.win(true);
    }
  }

  void restart() {
    _game.restart();
    board.win(false);
    board.updateView(_game.tiles);
  }

  void start() {
    _game.start();
    board.updateView(_game.tiles);
  }
}
