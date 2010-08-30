Class {
	#name : #GLMUITheme,
	#superclass : #UIThemeWatery2,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMUITheme class >> beCurrent [
	super beCurrent.
	Preferences textHighlightColor: ((Color r: 122 g: 140 b: 166 range: 255) alpha: 0.8).
	World color: (
		(GradientFillStyle 
			ramp: { 0.0 -> Color white darker.  1.0 -> Color lightGray})
			origin: 100 @ 100;
			direction: 800@0;
			normal: 0@800;
		radial: true).
	
]

{ #category : #'as yet unclassified' }
GLMUITheme class >> newDefaultSettings [
	^super newDefaultSettings
		menuColor: (Color r: 122 g: 140 b: 166 range: 255);
		menuTitleColor: (Color r: 190 g: 190 b: 190 range: 255)

   " ^super newDefaultSettings standardColorsOnly: true
"
]

{ #category : #accessing }
GLMUITheme class >> themeName [
	^ 'Glamorous'
]

{ #category : #'label-styles' }
GLMUITheme >> buttonLabelForText: aTextOrString [
	"Answer the label to use for the given text."
	^aTextOrString isString
		ifTrue: [(LabelMorph contents: aTextOrString capitalized )
					color: Color white]
		ifFalse: [super buttonLabelForText: aTextOrString]
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

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonNormalBorderStyleFor: aButton [
	"Return the normal button borderStyle for the given button."

	| outerColor innerColor |
	outerColor := Color r: 120 g: 120 b: 120 range: 255.
	^(CompositeBorder new width: 1)
		borders: {
		RoundedBorder new
					cornerRadius: 2;
					width: 1;
					baseColor: outerColor.
				 }
]

{ #category : #'as yet unclassified' }
GLMUITheme >> buttonNormalFillStyleFor: aButton [
	"Return the normal button fillStyle for the given button."
	
	| toptop top bottom |
	toptop := Color r:180 g:180 b:180 range:255.
	top := Color r:130 g:130 b:130 range:255.
	bottom := Color r:120 g:120 b:120 range:255.
	^(GradientFillStyle ramp: {
			0.0->toptop.
			0.05->top.
			0.8->bottom.})
		origin: aButton bounds origin;
		direction: 0 @ aButton height;
		radial: false
]

{ #category : #'as yet unclassified' }
GLMUITheme >> buttonSelectedBorderStyleFor: aButton [
	"Return the normal button borderStyle for the given button."

	| outerColor |
	outerColor := Color r: 180 g: 180 b: 180 range: 255.
	^(CompositeBorder new width: 1)
		borders: {
		RoundedBorder new
					cornerRadius: 2;
					width: 1;
					baseColor: outerColor.
				 }
]

{ #category : #'as yet unclassified' }
GLMUITheme >> buttonSelectedFillStyleFor: aButton [
	"Return the normal button fillStyle for the given button."
	
	| toptop top bottom |
	toptop := Color r:133 g:177 b:232 range:255.
	bottom := Color r: 99 g: 120 b: 149 range:255. 		

	top := Color r: 154 g: 169 b: 190 range:255. 		

	^(GradientFillStyle ramp: {
			0.0->toptop.
			0.05->top.
			0.8->bottom.})
		origin: aButton bounds origin;
		direction: 0 @ aButton height;
		radial: false
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
			0.0->Color white. 0.4-> aColor.
			1.0->aColor darker duller})
		origin: aSplitter topLeft;
		direction: (aSplitter splitsTopAndBottom
			ifTrue: [0 @ aSplitter height]
			ifFalse: [aSplitter width @ 0]);
		radial: false
]
