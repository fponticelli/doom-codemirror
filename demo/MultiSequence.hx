import Doom.*;
import Helpers.*;
using thx.Objects;

class MultiSequence extends Doom {
  @:state var a : String;
  @:state var b : String;
  @:state var c : String;
  var counter = 0;
  override function render() {
    return switch (counter++) {
      case 0: render0();
      case 1: render1();
      case _: render2();
    };
  }

  function render0() {
    thx.Timer.delay(update.bind(state), 100);
    return ul([
      li(createEditor(c, "http", blurC))
    ]);
  }

  function render1() {
    thx.Timer.delay(update.bind(state), 100);
    return ul([
      li(createEditor(b, "javascript", blurB)),
      li(createEditor(c, "http", blurC))
    ]);
  }

  function render2() {
    return ul([
      li(createEditor(a, "markdown", blurA)),
      li(createEditor(b, "javascript", blurB)),
      li(createEditor(c, "http", blurC))
    ]);
  }

  function blurA(editor : codemirror.CodeMirror) {
    var value = editor.getValue();
    update(state.merge({ a : value }));
  }

  function blurB(editor : codemirror.CodeMirror) {
    var value = editor.getValue();
    update(state.merge({ b : value }));
  }

  function blurC(editor : codemirror.CodeMirror) {
    var value = editor.getValue();
    update(state.merge({ c : value }));
  }
}
