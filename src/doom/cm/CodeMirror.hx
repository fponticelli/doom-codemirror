package doom.cm;

import doom.html.Html.*;

class CodeMirror extends doom.html.Component<CodeMirrorProps> {
  static var optionNames = ["mode", "lineSeparator", "theme", "indentUnit", "smartIndent", "tabSize", "indentWithTabs", "electricChars", "specialChars", "specialCharPlaceholder", "rtlMoveVisually", "keyMap", "extraKeys", "lineWrapping", "lineNumbers", "firstLineNumber", "lineNumberFormatter", "gutters", "fixedGutter", "scrollbarStyle", "coverGutterNextToScrollbar", "inputStyle", "readOnly", "showCursorWhenSelecting", "lineWiseCopyCut", "undoDepth", "historyEventDelay", "tabindex", "autofocus", "dragDrop", "allowDropFileTypes", "cursorBlinkRate", "cursorScrollMargin", "cursorHeight", "resetSelectionOnContextMenu", "workTime", "workDelay", "pollInterval", "flattenSpans", "addModeClass", "maxHighlightLength", "viewportMargin"];
  static var eventNames  = ["changes", "keyHandled", "inputRead", "electricInput", "viewportChange", "swapDoc", "gutterClick", "gutterContextMenu", "focus", "blur", "scroll", "scrollCursorIntoView", "update", "renderLine", "mousedown", "dblclick", "contextmenu", "keydown", "keypress", "keyup", "cut", "copy", "paste", "dragstart", "dragenter", "dragover", "drop"];

  var editor : codemirror.CodeMirror;
  var events : Map<String, haxe.Constraints.Function>;

  override function render()
    return div(["class" => "doom-codemirror"]);

  override function shouldRender()
    return false;

  override function didMount() {
    editor = new codemirror.CodeMirror(element, props.options);
    setupEvents();
    if(null != props.mount)
      props.mount(editor);
  }

  function setupEvents() {
    events = new Map();
    for(name in eventNames) {
      var f = Reflect.field(props, name);
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

  override function didUpdate() {
    clearEvents();
    for(field in optionNames) {
      var current = editor.getOption(field),
          value = Reflect.field(props.options, field);
      if(null == value)
        value = Reflect.field(codemirror.CodeMirror.defaults, field);
      if(current != value) {
        editor.setOption(field, value);
      }
    }
    if(props.options.value != editor.getValue())
      editor.setValue(props.options.value);
    if(null != props.refresh)
      props.refresh(editor);
    setupEvents();
  }

  override function willUnmount()
    clearEvents();
}
