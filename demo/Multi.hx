import Doom.*;
import Helpers.*;
using thx.Objects;

class Multi extends Doom {
  @:state var a : String;
  @:state var b : String;
  @:state var c : String;
  override function render() {
    return ul([
      li(createEditor(a, "markdown", function(editor) {
        var value = editor.getValue();
        update(state.merge({ a : value }));
      })),
      li(createEditor(b, "javascript", function(editor) {
        var value = editor.getValue();
        update(state.merge({ b : value }));
      })),
      li(createEditor(c, "http", function(editor) {
        var value = editor.getValue();
        update(state.merge({ c : value }));
      }))
    ]);
  }
}
