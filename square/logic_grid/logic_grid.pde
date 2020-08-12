/*
 * Porting game-js-tiles to Java
 * sinbrive June 2020
 * Collisions in tilemaps : https://mozdevs.github.io/gamedev-js-tiles/ 
 * and articles https://developer.mozilla.org/en-US/docs/Games/Techniques/Tilemaps
 */

boolean left=false, right=false, up=false, down=false;

PImage tileAtlas, character;  ////////////
Map map;
Camera camera;
Hero hero;
Game game;

//------------------
void setup() {
  size(512, 512);  // 64*8 64 is tile size)

  tileAtlas= loadImage("tiles.png");

  map = new Map();
  
  camera = new Camera(map, width, height);  // 512, 512

  hero = new Hero(map, 160, 160);
  
  game = new Game();
  
  camera.follow(hero);

  frameRate(5);
}


//------------------
void draw() {

  game.update();  
  
  game.render();
 
}
