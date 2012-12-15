class Menu {
  PImage active;
  PImage deactive;
  boolean menuSelected;
  int menuX;
  int menuY;

  Menu(PImage _active, PImage _deactive, boolean _menuSelected, int _menuX, int _menuY) {
    active = _active;
    deactive = _deactive;
    menuSelected = _menuSelected;
    menuX = _menuX;
    menuY = _menuY;
  }
  // if the menu has been selected, show active icon; otherwise, show deactive icon
  void display() {
    if (menuSelected == true) {
      image(active, menuX, menuY);
    }
    if (menuSelected == false) {
      image(deactive, menuX, menuY);
    }
  }
  // if the mouse is over a menu item, and the mouse is clicked, set that menu into active mode
  boolean isMenuSelected() {
    if (mouseX>(menuX-2) && mouseX<(menuX + 40) && mouseY>(menuY-2) && mouseY<(menuY+18)) {
      return true;
    }
    else {
      return false;
    }
  }
  void setSelected() {
    menuSelected = true;
  }
  void setDeselected() {
    menuSelected = false;
  }
}

