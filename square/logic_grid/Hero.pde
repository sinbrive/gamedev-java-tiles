class Hero {
  int SPEED = 4; // pixels per second
  int x;
  int y;
  Map map;
  int w;
  int h;
  PImage image;
  int screenX;
  int screenY;

  Hero(Map map, int x, int y) {
    this.map = map;
    this.x = x;
    this.y = y;
    this.w = map.tsize;
    this.h = map.tsize;

    this.image = loadImage("character.png");
  }

  void move(int dirx, int diry) {
    // move hero
    this.x += dirx * this.SPEED;
    this.y += diry * this.SPEED;

    // check if we walked into a non-walkable tile
    collide(dirx, diry);

    // clamp values
    int maxX = this.map.cols * this.map.tsize;
    int maxY = this.map.rows * this.map.tsize;
    this.x = max(0, min(this.x, maxX));
    this.y = max(0, min(this.y, maxY));
  }

  void collide(int dirx, int diry) {
    int  row, col;
    // -1 in right and bottom is because image ranges from 0..63
    // and not up to 64
    int left = this.x - this.w / 2;
    int right = this.x + this.w / 2 - 1;
    int top = this.y - this.h / 2;
    int bottom = this.y + this.h / 2 - 1;

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
