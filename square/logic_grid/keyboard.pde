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
