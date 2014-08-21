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
		'label'
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
	
	label ifNotNil: [ self positionLabel ].
	
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

	| s |
	s := ''.
	self allMorphsDo: [:m | (m isKindOf: StringMorph) ifTrue: [s := m contents]].
	^ s
]

{ #category : #accessing }
GLMButton >> label: aString [
	
	self label: aString font: self logicalFont.
]

{ #category : #accessing }
GLMButton >> label: aString font: aFont [

	label ifNotNil: [label delete].
	label := StringMorph contents: aString font: (aFont ifNil: [StandardFonts buttonFont]).
	self updateExtent.
	self addMorph: label.
	label lock
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

	self geometry labelPosition = #center ifTrue: [
		label position: self center - (label extent // 2)
	].

	self geometry labelPosition = #leftCenter ifTrue: [
		label position: self leftCenter - (0@(label height // 2)) + (self geometry paddingLeft @ 0)
	].

	self geometry labelPosition = #rightCenter ifTrue: [ 
		label position: self rightCenter - (label width@(label height // 2)) - (self geometry paddingRight @ 0)
	].

	self geometry labelPosition = #leftTop ifTrue: [
		label position: self topLeft + (self geometry paddingLeft @ self geometry paddingTop)
	].

	self geometry labelPosition = #rightTop ifTrue: [ 
		label position: self topRight - (label width@0) - (self geometry paddingRight @ (self geometry paddingTop * (-1)))
	].

	self geometry labelPosition = #leftBottom ifTrue: [ 
		label position: self bottomLeft - (0@label height) + (self geometry paddingLeft @ (self geometry paddingBottom  * (-1)))
	].

	self geometry labelPosition = #rightBottom ifTrue: [ 
		label position: self bottomRight - (label width@label height) - (self geometry paddingRight @ self geometry paddingBottom )
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

	label ifNotNil: [ 
		self extent: (self geometry calculateExtent: ((label width) @ (label height))).
	]
]
