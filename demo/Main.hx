import Helpers.*;

class Main {
  static function main() {
    mountComponent();
    buildFromComponent();
    sequence();
    multiUpdate();
    multiSequence();
  }

  static function mountComponent() {
    var comp = createEditor("var a = 1;", "javascript");
    Doom.browser.mount(comp, getContainer("mount component"));
  }

  static function buildFromComponent() {
    var comp = new EditorContainer({});
    Doom.browser.mount(comp, getContainer("build from component"));
  }

  static function sequence() {
    var comp = new Div({ n : createEditor("var a = 1;", "javascript").asNode() });
    Doom.browser.mount(comp, getContainer("sequence"));
    comp.update({ n : createEditor("var a = 2;", "javascript") });
    comp.update({ n : createEditor("# title;", "markdown") });
  }

  static function multiUpdate() {
    var comp = new Multi({
      a : "# title A",
      b : "var v = 2;",
      c : "GET /some HTTP/1.1\nHost: example.com"
    });
    Doom.browser.mount(comp, getContainer("multi update"));
  }

  static function multiSequence() {
    var comp = new MultiSequence({
      a : "# title A",
      b : "var v = 2;",
      c : "GET /some HTTP/1.1\nHost: example.com"
    });
    Doom.browser.mount(comp, getContainer("multi sequence"));
  }
}
