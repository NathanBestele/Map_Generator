class Block{
  bool door;
  int dir;

  int onMapX = -1;
  int onMapY = -1;

  Block(int d, bool door){
    dir = d;
    this.door = door;
  }
  
  void rotate(){
    if(dir < 3){
      dir++;
    } else {
      dir = 0;
    }
  }
}