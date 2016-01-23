import doom.cm.CodeMirror;
import doom.cm.CodeMirrorApi;
import Doom.*;

class Helpers {
  public static function createEditor(content : String, mode : String, ?blur : codemirror.CodeMirror -> Void) {
    return new CodeMirror({
      blur : blur
    }, {
      value : content,
      indentUnit : 2,
      tabSize : 2,
      indentWithTabs : false,
      lineNumbers : true,
      mode : mode
    });
  }

  public static function getContainer(name : String) {
    var div = js.Browser.document.createElement("div");
    div.style.width = "400px";
    div.style.float = "left";
    div.innerHTML = '<h3>$name</h1><div/>';
    js.Browser.document.body.appendChild(div);
    return div.querySelector("div");
  }
}
