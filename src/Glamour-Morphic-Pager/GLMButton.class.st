"
|form newForm|

form := ImageReadWriter formFromFileNamed: '9patch.png'.
newForm := Patch9Form scalePatch9Form: form size:  100@100.
(ImageMorph withForm: newForm) openInWindow.
"
Class {
	#name : #GLMButton,
	#superclass : #BorderedMorph,
	#instVars : [
		'fontModel',
		'buttonModel',
		'imageModel',
		'geometryModel',
		'buttonRenderer',
		'labelMorph',
		'labelModel'
	],
	#classInstVars : [
		'model'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMButton class >> with: aModel [
	^ ABCButtonView new model: aModel
]

{ #category : #accessing }
GLMButton >> buttonModel [
	^ buttonModel
]

{ #category : #accessing }
GLMButton >> buttonModel: aModel [
	buttonModel := aModel.
	
	buttonModel announcer weak
		on: GLMPagerButtonPressed send: #onPressed to: self.
	
	buttonModel announcer weak
		on: GLMPagerButtonDepressed send: #onDepressed to: self.
		
	buttonModel announcer weak
		on: GLMPagerButtonSelected send: #onSelected to: self.
		
	buttonModel announcer weak
		on: GLMPagerButtonDeselected send: #onDeselected to: self.
		
	buttonModel announcer weak
		on: GLMPagerButtonChecked send: #onChecked to: self.
	
	buttonModel announcer weak
		on: GLMPagerButtonUnChecked send: #onUnChecked to: self.
		
	buttonModel announcer weak
		on: GLMPagerButtonClicked send: #onClicked: to: self.
]

{ #category : #accessing }
GLMButton >> buttonRenderer [
	^ buttonRenderer
]

{ #category : #accessing }
GLMButton >> buttonRenderer: aRenderer [
	buttonRenderer := aRenderer
]

{ #category : #drawing }
GLMButton >> currentColor [
	^ self image pressedColor: (self buttonModel isPressed) selectedColor: (self buttonModel isSelected) checkedColor: (self buttonModel isChecked).
]

{ #category : #drawing }
GLMButton >> currentImage [
	^ self image pressed: (self buttonModel isPressed) selected: (self buttonModel isSelected) checked: (self buttonModel isChecked).
]

{ #category : #drawing }
GLMButton >> drawOn: aCanvas [

	self buttonRenderer render: self on: aCanvas. 
	super drawOn: aCanvas.
]

{ #category : #geometry }
GLMButton >> extent: newExtent [

	super extent: newExtent.
	
	labelMorph ifNotNil: [ self positionLabel ].
	
]

{ #category : #accessing }
GLMButton >> font [
	^ fontModel
]

{ #category : #accessing }
GLMButton >> font: aModel [
	fontModel := aModel.
	
	fontModel announcer weak
		on: GLMPagerButtonFontUpdated send: #onFontUpdated to: self.
]

{ #category : #accessing }
GLMButton >> geometry [
	^ geometryModel
]

{ #category : #accessing }
GLMButton >> geometry: aGeometryModel [
	geometryModel := aGeometryModel.
	
	geometryModel announcer weak
		on: GLMPagerButtonGeometryChanged send: #onGeometryChanged to: self.
]

{ #category : #'event-mouse' }
GLMButton >> handlesMouseDown: evt [
	^  true
]

{ #category : #'event-mouse' }
GLMButton >> handlesMouseOver: evt [
	^ true
]

{ #category : #accessing }
GLMButton >> image [
	^ imageModel.
]

{ #category : #accessing }
GLMButton >> image: anImageModel [
	imageModel := anImageModel.
	
	imageModel state announcer weak
		on: GLMPagerButtonImageUpdated send: #onImageUpdated to: self.
]

{ #category : #initialization }
GLMButton >> initialize [

	self image: GLMPagerButtonImageModel new.
	self label: GLMPagerButtonLabelModel new.
	self font: GLMPagerButtonFontModel new.
	self geometry: GLMPagerButtonGeometryModel new.
	self buttonModel: GLMPagerButtonModel new.
	self buttonRenderer: GLMPagerButtonRenderer new.
	
	super initialize.
	
	self borderWidth: 0.
	
	self color: (Color transparent).
]

{ #category : #accessing }
GLMButton >> label [
	
	^ labelModel
]

{ #category : #accessing }
GLMButton >> label: aLabelModel [

	labelModel := aLabelModel.
	
	labelModel announcer weak
		on: GLMPagerButtonLabelPositionChanged send: #onLabelPositionChanged to: self.
		
	labelModel announcer weak
		on: GLMPagerButtonLabelTextChanged send: #onLabelTextChanged to: self.
]

{ #category : #accessing }
GLMButton >> logicalFont [
	^ self font logicalFont
]

{ #category : #'event-mouse' }
GLMButton >> mouseDown: evt [
	self buttonModel press
	
]

{ #category : #'event-mouse' }
GLMButton >> mouseEnter: evt [
	self buttonModel select
]

{ #category : #'event-mouse' }
GLMButton >> mouseLeave: evt [
	self buttonModel deselect
]

{ #category : #'event-mouse' }
GLMButton >> mouseUp: evt [
	self buttonModel depress.
	(bounds containsPoint: evt position)
		ifFalse: [ self buttonModel deselect ] 
]

{ #category : #'event-handling' }
GLMButton >> onChecked [
	self changed
]

{ #category : #'event-handling' }
GLMButton >> onClicked: announcement [
]

{ #category : #'event-handling' }
GLMButton >> onDepressed [
	self changed
]

{ #category : #'event-handling' }
GLMButton >> onDeselected [
	self changed
]

{ #category : #'event-handling' }
GLMButton >> onFontUpdated [
	self label: self label.
]

{ #category : #'event-handling' }
GLMButton >> onGeometryChanged [
	self updateExtent.
]

{ #category : #'event-handling' }
GLMButton >> onImageUpdated [
	self changed
]

{ #category : #'event-handling' }
GLMButton >> onLabelPositionChanged [

	self positionLabel
]

{ #category : #'event-handling' }
GLMButton >> onLabelTextChanged [

	labelMorph ifNotNil: [labelMorph delete].
	labelMorph := StringMorph contents: self label text font: self logicalFont.
	self updateExtent.
	self addMorph: labelMorph.
	labelMorph lock
]

{ #category : #'event-handling' }
GLMButton >> onPressed [
	self changed
]

{ #category : #'event-handling' }
GLMButton >> onSelected [
	self changed
]

{ #category : #'event-handling' }
GLMButton >> onUnChecked [
	self changed
]

{ #category : #geometry }
GLMButton >> positionLabel [

	self label position = #center ifTrue: [
		labelMorph position: self center - (labelMorph extent // 2)
	].

	self label position = #leftCenter ifTrue: [
		labelMorph position: self leftCenter - (0@(labelMorph height // 2)) + (self geometry paddingLeft @ 0)
	].

	self label position = #rightCenter ifTrue: [ 
		labelMorph position: self rightCenter - (labelMorph width@(labelMorph height // 2)) - (self geometry paddingRight @ 0)
	].

	self label position = #leftTop ifTrue: [
		labelMorph position: self topLeft + (self geometry paddingLeft @ self geometry paddingTop)
	].

	self label position = #rightTop ifTrue: [ 
		labelMorph position: self topRight - (labelMorph width@0) - (self geometry paddingRight @ (self geometry paddingTop * (-1)))
	].

	self label position = #leftBottom ifTrue: [ 
		labelMorph position: self bottomLeft - (0@labelMorph height) + (self geometry paddingLeft @ (self geometry paddingBottom  * (-1)))
	].

	self label position = #rightBottom ifTrue: [ 
		labelMorph position: self bottomRight - (labelMorph width@labelMorph height) - (self geometry paddingRight @ self geometry paddingBottom )
	].
]

{ #category : #drawing }
GLMButton >> resizeImage: anImage scale: aScale [

	((aScale > (1@0)) | (aScale > (0@1))) ifTrue: [
		^ GLMForm increaseFormExtentCentered: anImage to: (anImage extent * aScale).
	].

	aScale = (1@1) ifTrue: [
		^ anImage
	].
	
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2.
]

{ #category : #geometry }
GLMButton >> updateExtent [

	labelMorph ifNotNil: [ 
		self extent: (self geometry calculateExtent: ((labelMorph width) @ (labelMorph height))).
	]
]
