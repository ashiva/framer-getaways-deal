Utils.domLoadScriptSync('framer/iphone-5s-white.js')

scrollingLayer = new Layer
	width:  640
	height: 1136
	clip: true
	
newddLayers = Framer.Importer.load "imported/newdd"
newddLayers.Main.superLayer = scrollingLayer

scrollingLayer.scrollVertical = true

newddLayers.CTA.y = 1017

newddLayers.CTA.states.add
	hide: {y:1136}

scrollingLayer.states.add
	options: {scrollY: newddLayers.Options.y}
	reviews: {scrollY: 2354}

scrollingLayer.states.animationOptions =
  curve: "spring(200, 20, 10)",
	time: 0.1

newddLayers.CTA.states.animationOptions =
	curve: "ease-out",
	time: 0.1
	
newddLayers.CTA.on Events.TouchStart, ->
	scrollingLayer.states.switch "options"
	this.states.switch "hide"

newddLayers.ReviewJump.on Events.TouchStart, ->
	scrollingLayer.states.switch "reviews"
	
scrollingLayer.on Events.TouchMove, ->
	if  this.scrollY > (newddLayers.Options.y - 1000)
		if this.scrollY > (newddLayers.Options.y + 800)
			newddLayers.CTA.states.switch "default"
		else
			newddLayers.CTA.states.switch "hide"
	else
		newddLayers.CTA.states.switch "default"