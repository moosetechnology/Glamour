Class {
	#name : #GLMUITheme,
	#superclass : #UIThemeWatery2,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMUITheme class >> newDefaultSettings [
    ^super newDefaultSettings standardColorsOnly: true

]

{ #category : #'as yet unclassified' }
GLMUITheme class >> themeName [
	^ 'Glamorous'
]

{ #category : #defaults }
GLMUITheme >> buttonMinHeight [
	"Answer the minumum height of a button for this theme."
	
	^16
]

{ #category : #defaults }
GLMUITheme >> buttonMinWidth [
	"Answer the minumum width of a button for this theme."
	
	^16
]

{ #category : #'fill-styles' }
GLMUITheme >> resizerGripNormalFillStyleFor: aResizer [
	"Return the normal fillStyle for the given resizer.
	For the moment, answer a transparent colour for no drawing,
	non transparent to draw as normal."
	
	^Color transparent
]

{ #category : #'fill-styles' }
GLMUITheme >> splitterNormalFillStyleFor: aSplitter [
	"Return the normal splitter fillStyle for the given splitter."
	
	^SolidFillStyle color: Color transparent
]

{ #category : #'fill-styles' }
GLMUITheme >> splitterPressedFillStyleFor: aSplitter [
	"Return the pressed splitter fillStyle for the given splitter."
	
	|aColor|
	aColor := aSplitter paneColor twiceDarker.
	^(GradientFillStyle ramp: {
			0.0->Color white. 0.4-> aColor twiceLighter.
			1.0->aColor darker duller})
		origin: aSplitter topLeft;
		direction: (aSplitter splitsTopAndBottom
			ifTrue: [0 @ aSplitter height]
			ifFalse: [aSplitter width @ 0]);
		radial: false
]
