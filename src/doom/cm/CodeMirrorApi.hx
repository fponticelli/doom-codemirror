package doom.cm;

import codemirror.Doc;
import codemirror.ChangeObject;
import codemirror.CodeMirror as CM;
import codemirror.LineHandle;
import codemirror.SelectionChange;
import js.html.Element;
import js.html.Event;

typedef CodeMirrorApi = {
  ?change : Doc -> ChangeObject -> Void,
  ?beforeChange : Doc -> ChangeObject -> Void,
  ?cursorActivity : Doc -> Void,
  ?beforeSelectionChange : Doc -> SelectionChange -> Void,
  ?changes : CM -> Array<ChangeObject>,
  ?keyHandled : CM -> String -> Event -> Void,
  ?inputRead : CM -> ChangeObject -> Void,
  ?electrictInput : CM -> Int -> Void,
  ?viewportChange : CM -> Float -> Float -> Void,
  ?swapDoc : CM -> Doc -> Void,
  ?gutterClick : CM -> Int -> String -> Event -> Void,
  ?gutterContextMenu : CM -> Int -> String -> Event -> Void,
  ?focus : CM -> Void,
  ?blur : CM -> Void,
  ?scroll : CM -> Void,
  ?scrollCursorIntoView : CM -> Event -> Void,
  ?update : CM -> Void,
  ?renderLine : CM -> LineHandle -> Element -> Void,
  ?mousedown : CM -> Event -> Void,
  ?dblclick : CM -> Event -> Void,
  ?contextmenu : CM -> Event -> Void,
  ?keydown : CM -> Event -> Void,
  ?keypress : CM -> Event -> Void,
  ?keyup : CM -> Event -> Void,
  ?cut : CM -> Event -> Void,
  ?copy : CM -> Event -> Void,
  ?paste : CM -> Event -> Void,
  ?dragstart : CM -> Event -> Void,
  ?dragenter : CM -> Event -> Void,
  ?dragover : CM -> Event -> Void,
  ?drop : CM -> Event -> Void,
}
