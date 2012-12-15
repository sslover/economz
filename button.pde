class Button {
  PImage button;
  boolean isClicked = false;
  int buttonX;
  int buttonY;

  Button (PImage _button, boolean _isClicked, int _buttonX, int _buttonY) {
    button = _button;
    isClicked = _isClicked;
    buttonX = _buttonX;
    buttonY = _buttonY;
  }
  void display() {
    image(button, buttonX, buttonY);
  }
  boolean clearPlate() {
    if (mouseX>(buttonX-2) && mouseX<(buttonX + 103) && mouseY>(buttonY-2) && mouseY<(buttonY+26)) {
      return true;
    }
    else {
      return false;
    }
  }
  boolean goClick(){
    if (mouseX>(buttonX-2) && mouseX<(buttonX + 177) && mouseY>(buttonY-2) && mouseY<(buttonY+49)) {
      return true;
    }
    else {
      return false;
    }
  }
  boolean splashClick(){
    if (mouseX>(buttonX-2) && mouseX<(buttonX + 265) && mouseY>(buttonY-2) && mouseY<(buttonY+63)) {
      return true;
    }
    else {
      return false;
    }
  }
}
