"
PNGReadWriter putForm: GLMUIThemeExtraIcons glamorousGrayCircle onFileNamed: 'glamorousGrayCircle.png'.

"
Class {
	#name : #GLMForm,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMForm class >> increaseFormExtentCentered: aForm to: aPoint [
	| icon rect destination |
	
	aForm ifNil: [ ^ nil ].
	rect := Rectangle origin: 0@0 extent: aPoint.
	destination := (rect extent - aForm extent) / 2.
	icon := Form extent: rect extent depth: aForm depth.
	icon copyBits: rect from: aForm at: destination clippingBox: icon boundingBox rule: Form over fillColor: nil.
	^ icon
]

{ #category : #'as yet unclassified' }
GLMForm class >> makeForm32Bit: aForm [
	aForm ifNil: [ ^ nil ].
	aForm depth = 32 ifTrue: [ ^ aForm ].
	aForm depth: 32.
	aForm fixAlpha.
	^ aForm.
]

{ #category : #'as yet unclassified' }
GLMForm class >> makeFormTransparent: aForm factor: aFloat [
	"a float must be in interval [0.0, 1.0]"
	| a |
	
	aForm ifNil: [ ^ nil ].
	aForm depth = 32 ifFalse: [^ aForm ].
	
	a := (aFloat * 255) asInteger.
	1 to: aForm bits size do: [:i |
		| v r g b |
		v := aForm bits at: i.
		r := ((v bitShift: -16) bitAnd: 255) * a // 255.
		g := ((v bitShift: -8) bitAnd: 255) * a // 255.
		b := (v bitAnd: 255) * a // 255.
		aForm bits at: i put: (a bitShift: 24) + (r bitShift: 16) + (g bitShift: 8) + b ].
	^ aForm 
]

{ #category : #'as yet unclassified' }
GLMForm class >> scaleForm: aForm by: aPoint [

	aForm ifNil: [ ^ nil ].
	^ aForm magnify: aForm boundingBox by: aPoint smoothing: 2
]

{ #category : #'as yet unclassified' }
GLMForm class >> scaleForm: aForm to: aPoint [
	|scaleX scaleY|
	
	aForm ifNil: [ ^ nil ].
	scaleX := aPoint x / aForm width.
	scaleY := aPoint y / aForm height.
	^ self scaleForm: aForm by: scaleX @ scaleY.
]

{ #category : #'as yet unclassified' }
GLMForm class >> scalePatchForm: aForm size: aPoint [
	"aPoint - width and height of new form
	
|form|

form := PatchForm scalePatchForm: (ImageReadWriter formFromFileNamed: 'abc_calculator_button_normal.p.png') size:800@800.
(ImageMorph withForm: form) openInWindow.

form := ImageReadWriter formFromFileNamed: 'abc_calculator_button_normal.png'.
form := PatchForm scaleForm: form by: (800/(form extent x))@(800/(form extent y)).
(ImageMorph withForm: form) openInWindow.
	
	"
	
	|x0 x1 y0 y1 width height newForm tmpForm color bottomHeight rightWidth newMiddleWidth newMiddleHeight|
	
	aForm ifNil: [ ^ nil ].
	
	color := Color red.
	x0 := x1 := y0 := y1 := 0.
	width := aForm extent x.
	height := aForm extent y.
	
	(0 to: width-1) collect: [ :each |
		(aForm colorAt: each@0) = color ifTrue: [ 
			x0 = 0 ifTrue: [ 
				x0 := each.
			]
		] ifFalse:[
			(x0 > 0 & x1 = 0) ifTrue:[
				x1 := each.
			].
		].
	].

	(0 to: height) collect: [ :each |
		(aForm colorAt: 0@each) = color ifTrue: [ 
			y0 = 0 ifTrue: [ 
				y0 := each.
			]
		] ifFalse:[
			(y0 > 0 & y1 = 0) ifTrue:[
				y1 := each.
			].
		].
	].

	rightWidth := width - x1 -1.
	bottomHeight := height - y1 - 1.
	newMiddleWidth := aPoint x - x0 - rightWidth + 1.
	newMiddleHeight := aPoint y - y0 - bottomHeight + 1.
	
	newForm := Form extent: aPoint depth: aForm depth.
	"left top corner"
	newForm copyBits: (1@1 corner: x0@y0)
		from: aForm at: 0@0 clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	"left bottom corner"
	newForm copyBits: (1@y1 corner: x0@(height - 1))
		from: aForm at: 0@(aPoint y - bottomHeight) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	"right top corner"
	newForm copyBits: (x1@1 corner: (width-1)@y0)
		from: aForm at: (aPoint x - rightWidth)@0 clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	"right bottom corner"
	newForm copyBits: (x1@y1 corner: (width - 1)@(height - 1))
		from: aForm at: (aPoint x - rightWidth)@(aPoint y - bottomHeight) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	"top middle block"
	tmpForm := aForm copy: (x0@1 corner: x1@y0).
	tmpForm := self scaleForm: tmpForm by: ((newMiddleWidth)/(x1-x0))@1.
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (x0-1)@0 clippingBox: newForm boundingBox rule: Form over fillColor: nil.
		
	"bottom middle block"
	tmpForm := aForm copy: (x0@y1 corner: x1@height).
	tmpForm := self scaleForm: tmpForm by: ((newMiddleWidth)/(x1-x0))@1.
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (x0-1)@(aPoint y - bottomHeight) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	"left middle block"
	tmpForm := aForm copy: (1@y0 corner: x0@y1).
	tmpForm := self scaleForm: tmpForm by: 1@((newMiddleHeight)/(y1-y0)).
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: 0@(y0-1) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	"right middle block"
	tmpForm := aForm copy: (x1@y0 corner: width@y1).
	tmpForm := self scaleForm: tmpForm by: 1@((newMiddleHeight)/(y1-y0)).
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (aPoint x - rightWidth)@(y0-1) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
		
	"middle block"
	tmpForm := aForm copy: (x0@y0 corner: x1@y1).
	tmpForm := self scaleForm: tmpForm by: ((newMiddleWidth)/(x1-x0))@((newMiddleHeight)/(y1-y0)).
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (x0-1)@(y0-1) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	^ newForm.
	

]
