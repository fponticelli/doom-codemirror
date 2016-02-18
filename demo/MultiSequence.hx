import doom.html.Html.*;
import Helpers.*;
using thx.Objects;

class MultiSequence extends doom.html.Component<{ a : String, b : String, c : String }> {
  var counter = 0;
  override function render() {
    return switch (counter++) {
      case 0: render0();
      case 1: render1();
      case _: render2();
    };
  }

  function render0() {
    thx.Timer.delay(update.bind(props), 100);
    return ul([
      li(createEditor(props.c, "http", blurC))
    ]);
  }

  function render1() {
    thx.Timer.delay(update.bind(props), 100);
    return ul([
      li(createEditor(props.b, "javascript", blurB)),
      li(createEditor(props.c, "http", blurC))
    ]);
  }

  function render2() {
    return ul([
      li(createEditor(props.a, "markdown", blurA)),
      li(createEditor(props.b, "javascript", blurB)),
      li(createEditor(props.c, "http", blurC))
    ]);
  }

  function blurA(editor : codemirror.CodeMirror) {
    var value = editor.getValue();
    update(props.merge({ a : value }));
  }

  function blurB(editor : codemirror.CodeMirror) {
    var value = editor.getValue();
    update(props.merge({ b : value }));
  }

  function blurC(editor : codemirror.CodeMirror) {
    var value = editor.getValue();
    update(props.merge({ c : value }));
  }

  // override function migrationFields()
  //   return super.migrationFields().concat(["counter"]);
}
