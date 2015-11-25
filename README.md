# Interactive Earth Interaction
Receive mouse and touch events from an interactive earth layer.

Uses the excellent [hammerjs](http://hammerjs.github.io/) library for event detection.

See the [Interactive Earth Handbook](https://github.com/metocean/interactive-earth-handbook) for an example of how to group interactive-earth modules together into a visualisation.

This layer should be added near the end as it needs to intercept all mouse and touch events before other elements. Layers on top will be able to intercept events first and can be used for UI elements anchored to coordinates, for example.

```js
...
var interaction = require('interactive-earth-interaction');
var interactionLayer = interaction({
  onStart: function (e) {},
  onEnd: function (e) {},
  onPan: function (e) {},
  onPinch: function (e) {},
  onDoubleTap: function (e) {},
  onWheel: function (e) {},
  onPress: function (e) {}
});

...

layers.push(['interaction', interactionLayer]);

...
```