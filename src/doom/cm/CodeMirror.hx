package doom.cm;

import thx.Dynamics;
import js.html.Element;
import Doom.*;
import codemirror.Options as CodeMirrorOptions;
import haxe.Constraints.Function;
using thx.Objects;

class CodeMirror extends doom.Component<CodeMirrorApi, CodeMirrorOptions> {
  static var eventNames = ["change", "beforeChange", "cursorActivity", "beforeSelectionChange", "changes", "keyHandled", "inputRead", "electrictInput", "viewportChange", "swapDoc", "gutterClick", "gutterContextMenu", "focus", "blur", "scroll", "scrollCursorIntoView", "update", "renderLine", "mousedown", "dblclick", "contextmenu", "keydown", "keypress", "keyup", "cut", "copy", "paste", "dragstart", "dragenter", "dragover", "drop"];
  static var optionNames = ["mode", "lineSeparator", "theme", "indentUnit", "smartIndent", "tabSize", "indentWithTabs", "electricChars", "specialChars", "specialCharPlaceholder", "rtlMoveVisually", "keyMap", "extraKeys", "lineWrapping", "lineNumbers", "firstLineNumber", "lineNumberFormatter", "gutters", "fixedGutter", "scrollbarStyle", "coverGutterNextToScrollbar", "inputStyle", "readOnly", "showCursorWhenSelecting", "lineWiseCopyCut", "undoDepth", "historyEventDelay", "tabindex", "autofocus", "dragDrop", "allowDropFileTypes", "cursorBlinkRate", "cursorScrollMargin", "cursorHeight", "resetSelectionOnContextMenu", "workTime", "workDelay", "pollInterval", "flattenSpans", "addModeClass", "maxHighlightLength", "viewportMargin"];

  var editor : codemirror.CodeMirror;
  var events : Map<String, Function>;
  var options : CodeMirrorOptions;

  override function render()
    return div(["class" => "doom-codemirror"]);

  override function didMount() {
    options = state.clone();

    editor = new codemirror.CodeMirror(function(el : Element) {
      element.appendChild(el);
      thx.Timer.immediate(attach);
    }, state);
  }

  function attach() {
    trace("ATTACH");
    events = new Map();
    // attach api events
    for(field in Reflect.fields(api)) {
      var fn = Reflect.field(api, field);
      editor.on(field, fn);
      events.set(field, fn);
    }
  }

  function detach() {
    trace("DETACH");
    if(null == events)
      return;
    // remove api from events
    for(field in events.keys()) {
      var fn = events.get(field);
      editor.off(field, fn);
    }
  }

  override function didRefresh() {
    if(null == editor) return;
    detach();
    for(field in optionNames) {
      var current = editor.getOption(field),
          value = Reflect.field(state, field);
      if(null == value)
        value = Reflect.field(codemirror.CodeMirror.defaults, field);
      if(current != value) {
        editor.setOption(field, value);
      }
    }
    if(editor.getValue() != state.value)
      editor.setValue(state.value);
    attach();
  }

  function migrate(old : CodeMirror) {
    editor = old.editor;
    old.detach();
    // TODO is attach needed here? it seems like didRefresh will invoke it just after
    // attach();
  }

  override function didUnmount()
    detach();
}
