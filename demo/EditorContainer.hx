import Helpers.*;

import Doom.*;

class EditorContainer extends Doom {
  override function render() {
    return div(createEditor("# title", "markdown"));
  }
}
