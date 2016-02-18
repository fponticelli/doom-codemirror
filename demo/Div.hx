import Helpers.*;

import doom.html.Html.*;

class Div extends doom.html.Component<{ n : doom.core.VNode }> {
  override function render()
    return div(props.n);
}
