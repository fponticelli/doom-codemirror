import Helpers.*;

import doom.html.Html.*;

class EditorContainer extends doom.html.Component<{}> {
  override function render() {
    return div(createEditor("# title", "markdown"));
  }
}
