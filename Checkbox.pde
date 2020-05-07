class Checkbox {
  public int x, y;
  private String text;
  private boolean clicked;

  Checkbox(int x, int y, String text) {
    this.x = x;
    this.y = y;
    this.text = text;
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
      fill(20, 240, 20);
    } else {
      fill(240, 20, 20);
    }

    rect(this.x, this.y, 50, 50);
    
    PFont SegoeUI_Light_17 = loadFont("SegoeUI-Light-17.vlw");
    textFont(SegoeUI_Light_17);
    fill(0, 0, 0);
    text(this.text, this.x-15, this.y+75);
  }
}
