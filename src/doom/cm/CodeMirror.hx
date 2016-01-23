package doom.cm;

import thx.Dynamics;
import js.html.Element;
import Doom.*;
import codemirror.Options as CodeMirrorOptions;
import haxe.Constraints.Function;
using thx.Objects;

class CodeMirror extends doom.Component<CodeMirrorApi, CodeMirrorOptions> {
  static var optionNames = ["mode", "lineSeparator", "theme", "indentUnit", "smartIndent", "tabSize", "indentWithTabs", "electricChars", "specialChars", "specialCharPlaceholder", "rtlMoveVisually", "keyMap", "extraKeys", "lineWrapping", "lineNumbers", "firstLineNumber", "lineNumberFormatter", "gutters", "fixedGutter", "scrollbarStyle", "coverGutterNextToScrollbar", "inputStyle", "readOnly", "showCursorWhenSelecting", "lineWiseCopyCut", "undoDepth", "historyEventDelay", "tabindex", "autofocus", "dragDrop", "allowDropFileTypes", "cursorBlinkRate", "cursorScrollMargin", "cursorHeight", "resetSelectionOnContextMenu", "workTime", "workDelay", "pollInterval", "flattenSpans", "addModeClass", "maxHighlightLength", "viewportMargin"];
  static var eventNames = ["mount", "refresh", "changes", "keyHandled", "inputRead", "electricInput", "viewportChange", "swapDoc", "gutterClick", "gutterContextMenu", "focus", "blur", "scroll", "scrollCursorIntoView", "update", "renderLine", "mousedown", "dblclick", "contextmenu", "keydown", "keypress", "keyup", "cut", "copy", "paste", "dragstart", "dragenter", "dragover", "drop"];

  var editor : codemirror.CodeMirror;
  var events : Map<String, haxe.Constraints.Function>;

  override function render()
    return div(["class" => "doom-codemirror"]);

  override function didMount() {
    editor = new codemirror.CodeMirror(element, state);
    setupEvents();
    if(null != api.mount)
      api.mount(editor);
  }

  function setupEvents() {
    events = new Map();
    for(name in eventNames) {
      var f = Reflect.field(api, name);
      if(null == f) continue;
      events.set(name, f);
      editor.on(name, f);
    }
  }

  function clearEvents() {
    if(null == events)
      return;
    for(name in events.keys()) {
      editor.off(name, events.get(name));
    }
  }

  override function didRefresh() {
    if(null == editor) return;
    for(field in optionNames) {
      var current = editor.getOption(field),
          value = Reflect.field(state, field);
      if(null == value)
        value = Reflect.field(codemirror.CodeMirror.defaults, field);
      if(current != value) {
        editor.setOption(field, value);
      }
    }
    editor.setValue(state.value);
    if(null != api.refresh)
      api.refresh(editor);
  }

  function migrate(old : CodeMirror) {
    if(null == old.editor) return;
    old.clearEvents();
    editor = old.editor;
    editor.setValue(state.value);
    setupEvents();
  }
}
