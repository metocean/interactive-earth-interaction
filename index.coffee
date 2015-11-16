hammerjs = require 'hammerjs'

module.exports = (options) ->
  options ?= {}
  options.onStart ?= ->
  options.onEnd ?= ->
  options.onPan ?= ->
  options.onPinch ?= ->
  options.onPress ?= ->
  options.onDoubleTap ?= ->
  options.onWheel ?= ->
  options.wheeltimeout = 250
  concurrentEvents = 0
  onStart = ->
    concurrentEvents++
    options.onStart() if concurrentEvents is 1
  onEnd = ->
    concurrentEvents--
    options.onEnd() if concurrentEvents is 0
  wheelTimeout = null
  onWheelTimeout = ->
    wheelTimeout = null
    onEnd()
  hammer = null
  afterMount: (el, projection) ->
    hammer = new hammerjs el, {}
    hammer.get('pan').set direction: hammerjs.DIRECTION_ALL
    hammer.get('pinch').set enable: yes
    hammer.get('swipe').set enable: no
    hammer.on 'pan', options.onPan
    hammer.on 'pinch', options.onPinch
    hammer.on 'press', options.onPress
    hammer.on 'doubletap', options.onDoubleTap
    el.addEventListener 'wheel', (e) ->
      if !wheelTimeout?
        onStart()
        wheelTimeout = setTimeout onWheelTimeout, options.wheeltimeout
      else
        clearTimeout wheelTimeout
        wheelTimeout = setTimeout onWheelTimeout, options.wheeltimeout
      e.preventDefault()
      options.onWheel e
    hammer.on 'panstart pinchstart', onStart
    hammer.on 'panend pinchend', onEnd
  beforeUnmount: (el, projection) ->
    onEnd() while concurrentEvents > 0
    hammer.destroy()