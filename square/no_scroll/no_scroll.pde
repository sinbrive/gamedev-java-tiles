/*
 * Porting game-js-tiles to Java
 * sinbrive June 2020
 * scrolling tilemaps : https://mozdevs.github.io/gamedev-js-tiles/ 
 * and articles https://developer.mozilla.org/en-US/docs/Games/Techniques/Tilemaps
*/

class Map {
    int cols=8;
    int rows=8;
    int tsize=64;
    int [] tiles={
        1, 3, 3, 3, 1, 1, 3, 1,
        1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 2, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 2, 1, 1, 1, 1,
        1, 1, 1, 1, 2, 1, 1, 1,
        1, 1, 1, 1, 2, 1, 1, 1,
        1, 1, 1, 1, 2, 1, 1, 1
    };
    
    int  getTile(int col, int row) {
        return this.tiles[row * this.cols + col];
    }
};

PImage tileAtlas;

Map map;
void setup() {
  size(512,512);  // 64*8

  tileAtlas= loadImage("tiles.png");
  map = new Map();
  
  for (int c = 0; c < map.cols; c++) {
        for (int r = 0; r < map.rows; r++) {
            int tile = map.getTile(c, r);
            if (tile != 0) { // 0 => empty tile
            print(tile);
                image(tileAtlas.get(((tile - 1) * map.tsize), 0, map.tsize, map.tsize), c * map.tsize, r * map.tsize);
            }
        }
    }
}

void draw(){

}
