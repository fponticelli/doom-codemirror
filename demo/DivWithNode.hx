import Helpers.*;

import Doom.*;
import doom.Node;

class DivWithNode extends Doom {
  @:state var n : Node;
  override function render() {
    return div(n);
  }
}
