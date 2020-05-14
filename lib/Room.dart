import 'Block.dart';

class Room{
  List<List<Block>> roomGrid;

  Room(List<List<Block>> r){
    roomGrid = r;
  }

  List<List<Block>> rotate(){
    int rg = roomGrid.length;
    List<List<Block>> temp = List.generate(rg, (_) => List(rg));

    for(int x = 0; x < rg; x++){
      for(int y = 0; y < rg; y++){
        Block b = roomGrid[x][y];
        if(b.door){
          b.rotate();
        }
        temp[y][rg-x-1] = b;
      }
    }
    roomGrid = temp;
    return roomGrid;
  }
}


