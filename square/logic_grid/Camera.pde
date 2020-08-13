class Camera {

  float x;
  int widthc;
  float y;
  int heightc;
  int maxY, maxX;
  Hero following;

  Camera(Map map, int wmap, int hmap) {
    this.x = 0;
    this.y = 0;
    this.widthc = wmap;
    this.heightc = hmap;
    this.maxX = map.cols * map.tsize - wmap;  
    this.maxY = map.rows * map.tsize - hmap;  
  }
  
  void follow(Hero sprite) {
    this.following = sprite;
    sprite.screenX = 0;
    sprite.screenY = 0;
}

void update() {
    // assume followed sprite should be placed at the center of the screen
    // whenever possible
    this.following.screenX = this.widthc / 2;
    this.following.screenY = this.heightc / 2;

    // make the camera follow the sprite
    this.x = this.following.x - this.widthc / 2;
    this.y = this.following.y - this.heightc / 2;
    // clamp values
    this.x = max(0, Math.min(this.x, this.maxX));
    this.y = max(0, Math.min(this.y, this.maxY));

    // in map corners, the sprite cannot be placed in the center of the screen
    // and we have to change its screen coordinates

    // left and right sides
    if (this.following.x < this.widthc / 2 ||
        this.following.x > this.maxX + this.widthc / 2) {
        this.following.screenX = this.following.x - this.x;
    }
    // top and bottom sides
    if (this.following.y < this.heightc / 2 ||
        this.following.y > this.maxY + this.heightc / 2) {
        this.following.screenY = this.following.y - this.y;
    }
}
  
}
