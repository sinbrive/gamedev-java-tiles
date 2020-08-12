class Game {


  Game() {
  }

  void update () {
    // handle hero movement with arrow keys
    int  dirx = 0;
    int diry = 0;


    if (left) {
      dirx = -1;
    }

    if (right) {
      dirx = 1;
    }

    if (down) {
      diry = 1;
    }

    if (up) {
      diry = -1;
    }

    hero.move(dirx, diry);
    camera.update();
  }

  //------------------
  void render() {
    // draw map background layer
    this.drawLayer(0);

    // draw main character
    image(hero.image, hero.screenX - hero.w / 2, 
      hero.screenY - hero.h / 2);
    // draw map top layer
    this.drawLayer(1);

    this.drawGrid();
  }

  //------------------
  void drawLayer(int layer) {

    int startCol = (camera.x / map.tsize);
    int endCol = startCol + (camera.widthc / map.tsize);
    int startRow = (camera.y / map.tsize);
    int endRow = startRow + (camera.heightc / map.tsize);

    //int offsetX = -camera.x + startCol * map.tsize;
    //int offsetY = -camera.y + startRow * map.tsize;

    for (int c = startCol; c <= endCol; c++) {      
      for (int r = startRow; r <= endRow; r++) {    
        println("game");
        // [row * map.cols + col could be out of range due to : c <= endCol et r <= endRow
        int tile = (c<0 || c>=map.cols || r<0 || r>=map.rows) ? 0 : map.getTile(layer, c, r);

        //int tile = map.getTile(layer, c, r);

        //int x = (c - startCol) * map.tsize + offsetX;
        //int y = (r - startRow) * map.tsize + offsetY;

        // no need to use offsetX and offsetY
        int x = c * map.tsize - camera.x;
        int y = r * map.tsize - camera.y;

        if (tile != 0) { 
          image(tileAtlas.get((tile - 1) * map.tsize, 0, map.tsize, map.tsize), 
            round(x), round(y) );
        }
      }
    }
  }


  void drawGrid() {
    int ww = map.cols * map.tsize;
    int hh = map.rows * map.tsize;
    int x, y;

    stroke(0);
    strokeWeight(1);

    for (int r = 0; r < map.rows; r++) {
      x = - camera.x;
      y = r * map.tsize - camera.y;
      line(x, y, ww, y);
    }
    for (int c = 0; c < map.cols; c++) {
      x = c * map.tsize - camera.x;
      y = - camera.y;

      line(x, y, x, hh);
    }
  }
}
