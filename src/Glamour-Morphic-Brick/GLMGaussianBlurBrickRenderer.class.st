Class {
	#name : #GLMGaussianBlurBrickRenderer,
	#superclass : #GLMBrickRenderer,
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> gaussBlur_1: scl dest: tcl width: w height: h radius: r [
	| rs |
	rs := (r * 2.57) ceiling.	"significant radius"
	1 to: h do: [ :i | 
		1 to: w do: [ :j | 
			| val wsum |
			val := 0.
			wsum := 0.
			i - rs to: i + rs do: [ :iy | 
				j - rs to: j + rs do: [ :ix | 
					| x y dsq wght |
					x := w min: (1 max: ix).
					y := h min: (1 max: iy).
					dsq := ((ix - j) * (ix - j) + (iy - i)) * (iy - i).
					wght := (-1 * dsq / (2 * r * r)) exp / (Float pi * 2 * r * r).
					val := val + ((scl colorAt: x@y)asRGBInteger * wght).
					wsum := wsum + wght ] ].
			tcl colorAt: j@i put: (Color colorFromRGBInteger: (val / wsum) rounded) ] ]

]

{ #category : #'as yet unclassified' }
GLMGaussianBlurBrickRenderer >> render: aBrick on: aCanvas [
	| origin corner height width  poker form formDest|
	
	height := aCanvas privateClipRect height.
	width := aCanvas privateClipRect width.
	poker := aCanvas privatePort.
		
	origin := aCanvas origin.
	corner := aCanvas privateClipRect corner.
	
	form := aCanvas form copy: aCanvas privateClipRect.
	formDest := aCanvas form copy: aCanvas privateClipRect.
	
	self gaussBlur_1: form dest: formDest width: 10 height: 10 radius: 4.
	
	"poker := (BitBlt bitPokerToForm: form).
	
	boxes := self boxesForGauss: 10 count: 3.
	self halt.
	
	(0 to: width - 1 ) do: [ :x | 
		(0 to: 5) do: [ :y |
			poker pixelAt: x@y put: (form pixelValueFor: Color red) ] ]."
	
	"self halt."
	
	aCanvas drawImage: formDest at: (aCanvas clipRect origin).
	
"	(origin x to: (corner x - 1) ) do: [ :x | 
		(origin y to: origin y + 5) do: [ :y |
			poker pixelAt: x@y put: (poker pixelAt: x@y) ] ]."
	
	
"	(aBrick globalBounds origin x to: height-1) do: [ :y | 
		(aBrick globalBounds origin y to: width-1) do: [ :x |
			poker pixelAt: x@y put: (Color red pixelWordForDepth: aCanvas form depth) ] ]."
	
	super render: aBrick on: aCanvas
]
