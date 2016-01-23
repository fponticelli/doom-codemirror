import Helpers.*;

class Main {
  static function main() {
    // mountComponent();
    // buildFromComponent();
    // sequence();
    // multiUpdate();
    multiSequence();
  }

  static function mountComponent() {
    var comp = createEditor("var a = 1;", "javascript");
    Doom.mount(comp, getContainer("mount component"));
  }

  static function buildFromComponent() {
    var comp = EditorContainer.with();
    Doom.mount(comp, getContainer("build from component"));
  }

  static function sequence() {
    var comp = new DivWithNode({}, { n : createEditor("var a = 1;", "javascript") });
    Doom.mount(comp, getContainer("sequence"));
    comp.update({ n : createEditor("var a = 2;", "javascript") });
    comp.update({ n : createEditor("# title;", "markdown") });
  }

  static function multiUpdate() {
    var comp = Multi.with(
      "# title A",
      "var v = 2;",
      "GET /some HTTP/1.1\nHost: example.com"
    );
    Doom.mount(comp, getContainer("multi update"));
  }

  static function multiSequence() {
    var comp = MultiSequence.with(
      "# title A",
      "var v = 2;",
      "GET /some HTTP/1.1\nHost: example.com"
    );
    Doom.mount(comp, getContainer("multi sequence"));
  }
}
