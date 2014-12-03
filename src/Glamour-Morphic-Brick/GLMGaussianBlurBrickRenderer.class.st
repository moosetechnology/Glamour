Class {
	#name : #GLMGaussianBlurBrickRenderer,
	#superclass : #GLMBrickRenderer,
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer class >> example [

	|morph|
	morph := GLMFoundationBrick new.
	morph brickRoot renderer: self new.
	morph extent: 300@300.
	morph openCenteredInWorld color: Color transparent.
	morph color: Color transparent.
	morph borderWidth: 3.
	morph borderColor: Color gray.
	morph wantsToBeTopmost
]

{ #category : #algorithm }
GLMGaussianBlurBrickRenderer >> boxBlur: scl dest: tcl width: w height: h radius: r [

	1 to: scl size do: [ :i | tcl at: i put: (scl at: i) ].
	self boxBlurH: tcl dest: scl width: w height: h radius: r.
	self boxBlurT: scl dest: tcl width: w height: h radius: r

]

{ #category : #algorithm }
GLMGaussianBlurBrickRenderer >> boxBlurH: scl dest: tcl width: w height: h radius: mR [
	|iarr r|
	
	r := (w min: h)/2 < (mR) ifTrue: [ ^ self ] ifFalse: [ mR ].
	
   iarr := 1.0 / (r+r+1).

	0 to: (h-1) do: [ :i |
		|ti li ri fv lv val|
		ti := i * w.
		li := ti.
		ri := ti + r.
		fv := scl at: (ti+1).
		lv := scl at: (ti + w).
		val := (r+1)*fv.
		0 to: (r-1) do: [ :j | val := val + (scl at: (ti+j+1)) ].
		
		0 to: r do: [ :j |
			val := val + (scl at: (ri+1)) - fv.
			tcl at: (ti+1) put: ((val*iarr)).
			ri := ri + 1.
			ti := ti + 1 ].
		
		(r+1) to: (w-r-1) do: [ :j |
			val := val + (scl at: (ri+1)) - (scl at: (li+1)).
			tcl at: (ti+1) put: ((val*iarr)).
			li := li + 1.
			ri := ri + 1.
			ti := ti + 1 ].
		
		(w-r) to: (w-1) do: [ :j |
			val := val + lv - (scl at: (li+1)).
			tcl at: (ti+1) put: ((val*iarr)).
			li := li + 1.
			ti := ti + 1 ] 	]

]

{ #category : #algorithm }
GLMGaussianBlurBrickRenderer >> boxBlurT: scl dest: tcl width: w height: h radius: mR [
	|iarr r|
	
	r := (w min: h)/2 < (mR) ifTrue: [ ^ self ] ifFalse: [ mR ].
	
   iarr := 1.0 / (r+r+1).

	0 to: (w-1) do: [ :i |
		|ti li ri fv lv val|
		ti := i.
		li := ti.
		ri := ti + (r*w).
		fv := scl at: (ti+1).
		lv := scl at: (ti+(w*(h-1))+1).
		val := (r+1)*fv.
		
		0 to: (r-1) do: [ :j | val := val + (scl at:(ti+(j*w))+1) ].
		
		0 to: r do: [ :j |
			val := val + (scl at: (ri+1)) - fv.
			tcl at: (ti+1) put: ((val*iarr)).
			ri := ri + w.
			ti := ti + w ].
		
		(r+1) to: (h-r-1) do: [ :j |
			val := val + (scl at: (ri+1)) - (scl at: (li+1)).
			tcl at: (ti+1) put: ((val*iarr)).
			li := li + w.
			ri := ri + w.
			ti := ti + w ].
		
		(h-r) to: (h-1) do: [ :j |
			val := val + lv - (scl at: (li+1)).
			tcl at: (ti+1) put: ((val*iarr)).
			li := li + w.
			ti := ti + w ] 	]

]

{ #category : #algorithm }
GLMGaussianBlurBrickRenderer >> boxesForGauss: sigma count: n [
	"standard deviation, number of boxes"

	| wIdeal wl wu mIdeal m sizes |
	wIdeal := (12 * sigma * sigma / n + 1) sqrt.	"Ideal averaging filter width"
	wl := wIdeal floor.
	wl % 2 = 0
		ifTrue: [ wl := wl - 1 ].
	wu := wl + 2.
	mIdeal := (12 * sigma * sigma - (n * wl * wl) - (4 * n * wl) - (3 * n)) / (-4 * wl - 4).
	m := mIdeal rounded.
	sizes := OrderedCollection new: n.
	1 to: n do: [ :i | 
		sizes
			add:
				(i < m
					ifTrue: [ wl ]
					ifFalse: [ wu ]) ].
	^ sizes
]

{ #category : #algorithm }
GLMGaussianBlurBrickRenderer >> gaussBlur: scl dest: tcl width: w height: h radius: r [
	|bxs|
	
	bxs := self boxesForGauss: r count: 3.
	self boxBlur: scl dest: tcl width: w height: h radius: (bxs first asFloat - 1)/2.
	self boxBlur: tcl dest: scl width: w height: h radius: (bxs second asFloat - 1)/2.
	self boxBlur: scl dest: tcl width: w height: h radius: (bxs third asFloat - 1)/2


]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> getChannelsFrom: aForm [

	
]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> putChannelValuesFromPixelValue: p depth: d r: mR g: mG b: mB a: mA at: index [
	"Convert a pixel value for the given display depth into a color."
	"Details: For depths of 8 or less, the pixel value is simply looked up in a table. For greater depths, the color components are extracted and converted into a color."
	| r g b alpha |
	d = 8 ifTrue: [ ^ self putColorInChannels: (Color indexedColors at: (p bitAnd: 255) + 1) r: mR g: mG b: mB a: mA at: index ].
	d = 4 ifTrue: [ ^ self putColorInChannels: (Color indexedColors at: (p bitAnd: 15) + 1) r: mR g: mG b: mB a: mA at: index ].
	d = 2 ifTrue: [ ^ self putColorInChannels: (Color indexedColors at: (p bitAnd: 3) + 1) r: mR g: mG b: mB a: mA at: index ].
	d = 1 ifTrue: [ ^ self putColorInChannels: (Color indexedColors at: (p bitAnd: 1) + 1) r: mR g: mG b: mB a: mA at: index ].
	d = 16 | (d = 15) ifTrue: 
		[ "five bits per component"
		r := (p bitShift: -10) bitAnd: 31.
		g := (p bitShift: -5) bitAnd: 31.
		b := p bitAnd: 31.
		(r = 0 and: [ g = 0 ]) ifTrue: 
			[ b = 0 ifTrue: [ ^ self putColorInChannels: (Color transparent) r: mR g: mG b: mB a: mA at: index ].
			b = 1 ifTrue: [ ^ self putColorInChannels: (self black) r: mR g: mG b: mB a: mA at: index ] ].
		^ self putRGBChannelsRed: r green: g blue: b alpha: 31.0 range: 31.0 r: mR g: mG b: mB a: mA at: index ].
	d = 32 ifTrue: 
		[ "eight bits per component; 8 bits of alpha"
		r := (p bitShift: -16) bitAnd: 255.
		g := (p bitShift: -8) bitAnd: 255.
		b := p bitAnd: 255.
		alpha := p bitShift: -24.
		alpha = 0 ifTrue: [ ^ self putColorInChannels: (Color transparent) r: mR g: mG b: mB a: mA at: index ].
		(r = 0 and: [ g = 0 and: [ b = 0 ] ]) ifTrue: [ ^ self putColorInChannels: (Color transparent) r: mR g: mG b: mB a: mA at: index ].
		alpha < 255 
			ifTrue: 
				[ ^ self putRGBChannelsRed: r green: g blue: b alpha: alpha range: 255.0 r: mR g: mG b: mB a: mA at: index ]
			ifFalse:
				[ ^ self putRGBChannelsRed: r green: g blue: b alpha: 255.0 range: 255.0 r: mR g: mG b: mB a: mA at: index ] ].
	d = 12 ifTrue: 
		[ "four bits per component"
		r := (p bitShift: -8) bitAnd: 15.
		g := (p bitShift: -4) bitAnd: 15.
		b := p bitAnd: 15.
		^ self putRGBChannelsRed: r green: g blue: b alpha: 15.0 range: 15.0 r: mR g: mG b: mB a: mA at: index ].
	d = 9 ifTrue: 
		[ "three bits per component"
		r := (p bitShift: -6) bitAnd: 7.
		g := (p bitShift: -3) bitAnd: 7.
		b := p bitAnd: 7.
		^ self putRGBChannelsRed: r green: g blue: b alpha: 7.0 range: 7.0 r: mR g: mG b: mB a: mA at: index ].
	self error: 'unknown pixel depth: ' , d printString
]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> putColorInChannels: aColor r: r g: g b: b a: a at: index [
	
	r atWrap: index put: aColor red.
	g atWrap: index put: aColor green.
	b atWrap: index put: aColor blue.
	a atWrap: index put: aColor alpha.
]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> putRGBChannelsRed: red green: green blue: blue alpha: alpha range: range r: r g: g b: b a: a at: index [
	
	r atWrap: index put: (red asFloat/range).
	g atWrap: index put: (green asFloat/range).
	b atWrap: index put: (blue asFloat/range).
	a atWrap: index put: (alpha asFloat/range).
]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> render: aBrick on: aCanvas [
	| origin corner height width  poker form formDest r g b a depth destR destG destB destA|
	
	height := aCanvas privateClipRect height.
	width := aCanvas privateClipRect width.
	poker := aCanvas privatePort.
		
	origin := aCanvas origin.
	corner := aCanvas privateClipRect corner.
	
	
	form := aCanvas form copy: aCanvas privateClipRect.
	depth := form depth.
	formDest := Form extent: form extent depth: form depth.
	
	r := Array new: form bits size.
	g := Array new: form bits size.
	b := Array new: form bits size.
	a := Array new: form bits size.
	
	destR := Array new: form bits size.
	destG := Array new: form bits size.
	destB := Array new: form bits size.
	destA := Array new: form bits size.
	
	form bits doWithIndex: [ :each :index | self putChannelValuesFromPixelValue: each depth: depth r: r g: g b: b a: a at: index ].
	
	self gaussBlur: r dest: destR width: form width height: form height radius: 5.
	self gaussBlur: g dest: destG width: form width height: form height radius: 5.
	self gaussBlur: b dest: destB width: form width height: form height radius: 5.
"	self gaussBlur_4: a dest: destA width: form width height: form height radius: 4."
	
	self storeChannelsRed: destR green: destG blue: destB alpha: a in: formDest bits depth: depth.
	
	aCanvas drawImage: formDest at: (aCanvas clipRect origin).
	super render: aBrick on: aCanvas
]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> storeChannelsRed: r green: g blue: b alpha: a in: aBitmap depth: depth [

	1 to: aBitmap size do: [ :index | aBitmap integerAt: index put: (self toPixelValueRed: (r atWrap: index)  green: (g atWrap: index) blue: (b atWrap: index) alpha: (a atWrap: index) depth: depth )  ]
]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> toPixelValueRed: r green: g blue: b alpha: a depth: depth [

	^ (Color r: r g: g b: b alpha: a) pixelValueForDepth: depth
]
