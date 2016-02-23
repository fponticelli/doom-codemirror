import Helpers.*;

import doom.html.Html.*;

class Div extends doom.html.Component<{ n : doom.core.VChild }> {
  override function render()
    return div(props.n);
}
