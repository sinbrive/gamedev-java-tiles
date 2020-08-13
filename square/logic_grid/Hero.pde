class Hero {
  int SPEED = 256; // pixels per second
  float x;
  float y;
  Map map;
  int w;
  int h;
  PImage image;
  float screenX;
  float screenY;

  Hero(Map map, float x, float y) {
    this.map = map;
    this.x = x;
    this.y = y;
    this.w = map.tsize;
    this.h = map.tsize;

    this.image = loadImage("character.png");
  }

  void move(float delta, int dirx, int diry) {
    // move hero
    this.x += dirx * this.SPEED * delta;
    this.y += diry * this.SPEED * delta;

    // check if we walked into a non-walkable tile
    collide(dirx, diry);

    // clamp values
    int maxX = this.map.cols * this.map.tsize;
    int maxY = this.map.rows * this.map.tsize;
    this.x = max(0, min(this.x, maxX));
    this.y = max(0, min(this.y, maxY));
  }

  void collide(int dirx, int diry) {
    float  row, col;
    // -1 in right and bottom is because image ranges from 0..63
    // and not up to 64
    float left = this.x - this.w / 2;
    float right = this.x + this.w / 2 - 1;
    float top = this.y - this.h / 2;
    float bottom = this.y + this.h / 2 - 1;

    // check for collisions on sprite sides
    boolean collision =
      this.map.isSolidTileAtXY(left, top) ||
      this.map.isSolidTileAtXY(right, top) ||
      this.map.isSolidTileAtXY(right, bottom) ||
      this.map.isSolidTileAtXY(left, bottom);
    if (!collision) return; 

    if (diry > 0) {
      row = this.map.getRow(bottom);
      this.y = -this.h / 2 + this.map.getY(row);
    } else if (diry < 0) {
      row = this.map.getRow(top);
      this.y = this.h / 2 + this.map.getY(row + 1);
    } else if (dirx > 0) {
      col = this.map.getCol(right);
      this.x = -this.w / 2 + this.map.getX(col);
    } else if (dirx < 0) {
      col = this.map.getCol(left);
      this.x = this.w / 2 + this.map.getX(col + 1);
    }
  }
}
