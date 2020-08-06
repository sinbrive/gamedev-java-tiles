/*
 * Porting game-js-tiles to Processing(Java)
 * sinbrive June 2020
 * Tilemaps with layers : https://mozdevs.github.io/gamedev-js-tiles/ 
 * and articles https://developer.mozilla.org/en-US/docs/Games/Techniques/Tilemaps
 */

class Map {
  int cols=8;
  int rows=8;
  int tsize=64;
  int [] [] layers={{
      3, 3, 3, 3, 3, 3, 3, 3, 
      3, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 1, 1, 2, 1, 3, 
      3, 1, 1, 1, 1, 1, 1, 3, 
      3, 1, 1, 2, 1, 1, 1, 3, 
      3, 1, 1, 1, 2, 1, 1, 3, 
      3, 1, 1, 1, 2, 1, 1, 3, 
      3, 3, 3, 1, 2, 3, 3, 3
    }, {
      4, 3, 3, 3, 3, 3, 3, 4, 
      4, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 5, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 4, 
      4, 0, 0, 0, 0, 0, 0, 4, 
      4, 4, 4, 0, 5, 4, 4, 4, 
      0, 3, 3, 0, 0, 3, 3, 3
  }};

  int  getTile(int layer, int col, int row) {
    return this.layers[layer][row * map.cols + col];
  }
}

class Hero {

  int x;
  int y;

  PImage character;

  Hero(int x, int y) {
    this.x=x;
    this.y=y;
    character=loadImage("character.png");
  }

  void display() {
    image(character, x, y);
  }
}


PImage tileAtlas;
Map map;
Hero hero;
//------------------
void setup() {
  size(512, 512);  

  tileAtlas= loadImage("tiles.png");

  map = new Map();

  hero = new Hero(128, 384);

  frameRate(10);
}


//------------------
void render(int layer) {

  for (int c = 0; c < map.cols; c++) {      
    for (int r = 0; r < map.rows; r++) {    

      int tile = map.getTile(layer, c, r);

      if (tile != 0) { // 0 => empty tile
        image(tileAtlas.get((tile - 1) * map.tsize, 0, map.tsize, map.tsize), c*map.tsize, r*map.tsize);
      }
    }
  }
}

//------------------
void draw() {

  render(0);

  hero.display(); 

  render(1);
}
