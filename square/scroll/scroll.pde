/*
 * Porting game-js-tiles to Java
 * sinbrive June 2020
 * scrolling tilemaps : https://mozdevs.github.io/gamedev-js-tiles/ 
 * and articles https://developer.mozilla.org/en-US/docs/Games/Techniques/Tilemaps
 */

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
    return this.layers[layer][row * map.cols + col];
  }
}

class Camera {

  float x;
  int widthc;
  float y;
  int heightc;
  int SPEED = 256;
  int maxY, maxX;

  Camera(Map map, int wmap, int hmap) {
    this.x = 0;
    this.y = 0;
    this.widthc = wmap;
    this.heightc = hmap;
    this.maxX = map.cols * map.tsize - wmap;  
    this.maxY = map.rows * map.tsize - hmap;
  }

  void move(float delta, int dirx, int diry) {
    // move camera
    this.x += dirx * this.SPEED*delta;
    this.y += diry * this.SPEED*delta;

    //clamp values : first but not optimal solution
    /*
    if (this.x > map.rows*map.tsize-this.widthc)
     x=map.rows*map.tsize-this.widthc;
     if (this.y > map.rows*map.tsize-this.heightc)
     this.y=map.rows*map.tsize-this.heightc;
     
     if (this.x < 0 ) this.x=0;
     if (this.y <0) this.y=0;
     */

    // clamp values : second better solution
    this.x = max(0, min(this.x, this.maxX));
    this.y = max(0, min(this.y, this.maxY));
  }
}

PImage tileAtlas, character;
Camera camera;
Map map;
boolean left=false, right=false, up=false, down=false;
double t0=millis();


//------------------
void setup() {
  size(512, 512);  // 64*8 64 is tile size)

  tileAtlas= loadImage("tiles.png");

  map = new Map();
  camera = new Camera(map, width, height);  // 512, 512

  //frameRate(10);
}


//------------------
void draw() {

  update();

  render(0);
  render(1);
}

//------------------
void update() {

  float delta = (int)(millis()-t0);
  delta = min(delta, 250)/1000;
  t0=millis();


  int dirx=0, diry=0;

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

  camera.move(delta, dirx, diry);
}

//------------------
void render(int layer) {

  int startCol =(int) (camera.x / map.tsize);
  int endCol = startCol + (camera.widthc / map.tsize);
  int startRow = (int) (camera.y / map.tsize);
  int endRow = startRow + (camera.heightc / map.tsize);

  //int offsetX = -camera.x + startCol * map.tsize;
  //int offsetY = -camera.y + startRow * map.tsize;

  for (int c = startCol; c <= endCol; c++) {      
    for (int r = startRow; r <= endRow; r++) {    

      // [row * map.cols + col could be out of range due to : c <= endCol et r <= endRow
      int tile = (c<0 || c>=map.cols || r<0 || r>=map.rows) ? 0 : map.getTile(layer, c, r);

      //int tile = map.getTile(layer, c, r);

      //int x = (c - startCol) * map.tsize + offsetX;
      //int y = (r - startRow) * map.tsize + offsetY;

      // no need to use offsetX and offsetY
      float x = c * map.tsize - camera.x;
      float y = r * map.tsize - camera.y;

      if (tile != 0) { 
        image(tileAtlas.get((tile - 1) * map.tsize, 0, map.tsize, map.tsize), 
          round(x), round(y) );
      }
    }
  }
}

void keyPressed() {

  if (key== CODED) { 

    if (keyCode == LEFT) {
      left=true;
    }

    if (keyCode == RIGHT) {
      right=true;
    }

    if (keyCode == DOWN) {
      down=true;
    }

    if (keyCode == UP) {
      up=true;
    }
  }
}


void keyReleased() {

  if (key== CODED) { 

    if (keyCode == LEFT) {
      left=false;
    }

    if (keyCode == RIGHT) {
      right=false;
    }

    if (keyCode == DOWN) {
      down=false;
    }

    if (keyCode == UP) {
      up=false;
    }
  }
}
