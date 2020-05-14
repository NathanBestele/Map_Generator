import 'Room.dart';
import 'Block.dart';

/*
* Block(0-3, true) == door n, e, s, w
* Block(0, false) == part of room
* Block(1, false) == null
*/

class MapLayouts{

  List<Room> makeRooms(){
    List<Room> rooms = new List<Room>();

    rooms.add(new Room([
      [b(0)],
    ]));

    rooms.add(new Room([
      [b(0), b(1)],
      [b(3), b(2)],
    ]));

    rooms.add(new Room([
      [b(4), b(0), b(4)],
      [b(3), b(4), b(1)],
      [b(4), b(2), b(4)],
    ]));

    return rooms;
  }

  List<Room> makeHalls(){
    List<Room> halls = new List<Room>();

    halls.add(new Room([
      [b(0), b(5)],
      [b(2), b(5)],
    ]));

    halls.add(new Room([
      [b(0), b(5)],
      [b(4), b(1)],
    ]));

    halls.add(new Room([
      [b(5), b(0), b(5)],
      [b(5), b(4), b(5)],
      [b(5), b(2), b(5)],
    ]));

    halls.add(new Room([
      [b(0), b(5)],
      [b(4), b(1)],
      [b(2), b(5)],
    ]));

    halls.add(new Room([
      [b(0), b(5), b(5)],
      [b(4), b(5), b(5)],
      [b(4), b(4), b(1)],
    ]));

    halls.add(new Room([
      [b(5), b(0), b(5)],
      [b(3), b(4), b(1)],
      [b(5), b(2), b(5)],
    ]));

    return halls;
  }

  Block b(int x){
    switch(x){
      case 0:
        return new Block(0, true);
        break;

      case 1:
        return new Block(1, true);
        break;

      case 2:
        return new Block(2, true);
        break;

      case 3:
        return new Block(3, true);
        break;

      case 4:
        return new Block(0, false);
        break;

      case 5:
        return new Block(1, false);
        break;
    }
    return null;
  }
}