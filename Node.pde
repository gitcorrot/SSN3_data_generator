class Node {
  private int x, y;
  private boolean clicked;

  Node(int x, int y) {
    this.x = x;
    this.y = y;
    this.clicked = false;
  }

  /*--------------------------------------------------------*/

  int isClicked() {
    return this.clicked ? 1 : 0;
  }
  
  void clicked() {
    this.clicked = !this.clicked;
  }

  void show() {
    if (clicked) {
      fill(66, 66, 66);
    } else {
      fill(222, 222, 222);
    }

    rect(this.x*nodeSize, this.y*nodeSize, nodeSize, nodeSize);
  }
}
