class Map {
  int cols=12;
  int rows=12;
  int tsize=64;
  int [] [] layers={{
      3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 3, 
      3, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 3, 
      3, 3, 3, 1, 1, 2, 3, 3, 3, 3, 3, 3 
    }, {
      4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 5, 0, 0, 0, 0, 0, 5, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 
      4, 4, 4, 0, 5, 4, 4, 4, 4, 4, 4, 4, 
      4, 4, 4, 0, 0, 3, 3, 3, 3, 3, 3, 3
  }};

  int  getTile(int layer, int col, int row) {
    //if ((row * map.cols + col) >= this.rows*this.cols) return 0;
    int tile;
    try {
      tile =this.layers[layer][row * map.cols + col];
      return tile;
    } 
    catch(Exception ignore) {
      return 0;
    }
  }

  boolean isSolidTileAtXY (float x, float y) {
    int col = floor(x / this.tsize);
    int row = floor(y / this.tsize);

    // tiles 3 and 5 are solid -- the rest are walkable
    // loop through all layers and return TRUE if any tile is solid
    for (int index=0; index<2; index++) {
      for (int c = 0; c < map.cols; c++) {      
        for (int r = 0; r < map.rows; r++) {  
          //println(x, y);
          int tile = this.getTile(index, col, row);
          boolean isSolid = tile == 3 || tile == 5;
          if (isSolid) return true;
        }
      }
    }
    return false;
  }

  float getCol(float x) {
    return floor(x / this.tsize);
  }

  float getRow(float y) {
    return floor(y / this.tsize);
  }
  float getX(float col) {
    return col * this.tsize;
  }
  float getY(float row) {
    return row * this.tsize;
  }
}
