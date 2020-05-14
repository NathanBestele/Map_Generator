import 'package:flutter/material.dart';
import 'dart:math';
import 'MapLayouts.dart';
import 'Room.dart';
import 'Block.dart';

/*
* Block(0-3, true) == door n, e, s, w
* Block(0, false) == part of room
* Block(1, false) == null
*/

void main() => runApp(Layout());

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

int size = 10;
int lowerLimit = 5;
int upperLimit = 30;

MapLayouts mapLayouts = new MapLayouts();
List<Room> rooms = mapLayouts.makeRooms();
List<Room> halls = mapLayouts.makeHalls();

var grid = List.generate(size, (_) => List(size));

class _LayoutState extends State<Layout> {

  void addBlock(Block b, int x, int y){
    setState(() {
      if(b.door){
        switch(b.dir){
          case(0):
            grid[x][y] = 0;
            break;

          case(1):
            grid[x][y] = 1;
            break;

          case(2):
            grid[x][y] = 2;
            break;

          case(3):
            grid[x][y] = 3;
            break;
        }
      } else if(b.dir == 0){
        grid[x][y] = 4;
      }
    });
  }

  void scale(int x){
    setState(() {
      if(size > lowerLimit && x < 0){
        size += x;
        grid = List.generate(size, (_) => List(size));
      } else if(size < upperLimit && x > 0){
        size += x;
        grid = List.generate(size, (_) => List(size));
      }
    });
  }

  void genMap(){
    setState(() {
      grid = List.generate(size, (_) => List(size));
    });
    //TODO write map gen

    /*
    try{
      Room r = new Room([
        [Block(0, false), Block(0, true), Block(0, false)],
        [Block(3, true), Block(0, false), Block(1, true)],
        [Block(0, false), Block(2, true), Block(0, false)],
      ]);

      //r.rotate();

      int rgl = r.roomGrid.length;
      for(int x = 0; x < rgl; x++){
        for(int y = 0; y < rgl; y++){
          if(r.roomGrid[x][y] != null){
            addBlock(r.roomGrid[x][y], x, y);
          }
        }
      }
    }catch(Exception){}
    */

    var rng = new Random();
    int xMap;
    int yMap;

    Room landing = new Room([
      [Block(0, false), Block(0, true), Block(0, false)],
      [Block(3, true), Block(0, false), Block(1, true)],
      [Block(0, false), Block(2, true), Block(0, false)],
    ]);
    int sizeOfLanding = landing.roomGrid.length-1;

    setState(() {
      switch(rng.nextInt(4)){
        case(0):
          xMap = 0;
          yMap = rng.nextInt(grid.length - sizeOfLanding);
          break;

        case(1):
          xMap = rng.nextInt(grid.length - sizeOfLanding);
          yMap = grid.length - sizeOfLanding - 1;
          break;

        case(2):
          xMap = grid.length - sizeOfLanding - 1;
          yMap = rng.nextInt(grid.length - sizeOfLanding);
          break;

        case(3):
          xMap = rng.nextInt(grid.length - sizeOfLanding);
          yMap = 0;
          break;
      }

      placeRoom(landing, xMap, yMap);


    });
  }

  void setRoomPlacement(){

  }

  void placeRoom(Room room, int xMap, yMap){
    int rgl = room.roomGrid.length;
    int tempX = xMap;
    int tempY = yMap;
    bool possible = true;

    for(int x = 0; x < rgl; x++){
      for(int y = 0; y < rgl; y++){
        if(grid[tempX][tempY] != null){
          return;
        }
        tempY++;
      }
      tempY = yMap;
      tempX++;
    }

    for(int x = 0; x < rgl; x++){
      for(int y = 0; y < rgl; y++){
        if(grid[tempX][tempY] == null){
          addBlock(room.roomGrid[x][y], tempX, tempY);

          room.roomGrid[x][y].onMapX = tempX;
          room.roomGrid[x][y].onMapY = tempY;
        }
        tempY++;
      }
      tempY = yMap;
      tempX++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
            backgroundColor: Colors.grey.shade600,
            title: Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        child: Text(
                          '<=',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        onPressed: (){
                          scale(-1);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        child: Text(
                          '$size' 'x' '$size',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        onPressed: (){
                          genMap();
                        },
                      ),
                    ),
                  ),Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        child: Text(
                          '=>',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        onPressed: (){
                          scale(1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size,
            ),
            itemCount: size*size,
            itemBuilder: _buildGridItems,
          ),
        ),
      ),
    );
  }
}

Widget _buildGridItems(BuildContext context, int index){
  int x, y = 0;
  x = (index/size).floor();
  y = (index%size);
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: _buildGridItem(x, y),
  );
}

Widget _buildGridItem(int x, int y){
  switch(grid[x][y]){
    case 0:
      return Icon(
        Icons.arrow_upward,
        color: Colors.white,
      );
      break;

    case 1:
      return Icon(
        Icons.arrow_forward,
        color: Colors.white,
      );
      break;

    case 2:
      return Icon(
        Icons.arrow_downward,
        color: Colors.white,
      );
      break;

    case 3:
      return Icon(
        Icons.arrow_back,
        color: Colors.white,
      );
      break;

    case 4:
      return Container(
        child: Icon(
          Icons.texture,
          color: Colors.white,
        ),
      );
      break;

    default:
      return Container(
        color: Colors.grey.shade400,
      );
  }

}