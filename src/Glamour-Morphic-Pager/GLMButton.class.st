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
		
	buttonModel announcer weak
		on: GLMPagerButtonEnabled send: #onEnabled to: self.
		
	buttonModel announcer weak
		on: GLMPagerButtonDisabled send: #onDisabled to: self.
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

{ #category : #status }
GLMButton >> disable [

	self buttonModel disable
]

{ #category : #drawing }
GLMButton >> drawOn: aCanvas [

	self buttonRenderer render: self on: aCanvas. 
	super drawOn: aCanvas.
]

{ #category : #status }
GLMButton >> enable [

	self buttonModel enable
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

	^  self buttonModel isEnabled
]

{ #category : #'event-mouse' }
GLMButton >> handlesMouseOver: evt [
	
	^  self buttonModel isEnabled
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

{ #category : #label }
GLMButton >> measureLabelWidthFor: aText [
	| f |
	
	labelMorph ifNil: [ ^ 0 ].
	
	f := labelMorph fontToUse.
	^(((((f widthOfString: aText) max: labelMorph minimumWidth)  @ f height) + (labelMorph layoutInset * 2)) ceiling) x
]

{ #category : #geometry }
GLMButton >> measureWidth [
	"Returns theoretical width of the morph. If label has no text returns current width"
	
	labelMorph ifNil: [ ^ self width ].

	^ (self geometry calculateExtent: ((self measureLabelWidthFor: self label text) @ (labelMorph height))) x
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
GLMButton >> onDisabled [

	self changed.
]

{ #category : #'event-handling' }
GLMButton >> onEnabled [

	self changed.
]

{ #category : #'event-handling' }
GLMButton >> onFontUpdated [
	labelMorph ifNotNil: [
		labelMorph font: self logicalFont.
		labelMorph color: self font color.
		self updateExtent.
	].
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

	labelMorph ifNil: [ 
		self label text size = 0 ifTrue: [ ^ self ].
		labelMorph := StringMorph contents: self label text font: self logicalFont.
		self updateExtent.
		self addMorph: labelMorph.
		^ self.
	].

	self label text size = 0 ifTrue: [
		labelMorph delete.
		labelMorph := nil.
		self updateExtent.
		^ self
	].

	self setLabelText: self label text.
	self updateExtent.

	
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

{ #category : #label }
GLMButton >> positionLabel [

	labelMorph ifNil: [ ^ self ].

	self label position == #center ifTrue: [
		labelMorph position: self center - (labelMorph extent // 2)
	].

	self label position == #leftCenter ifTrue: [
		labelMorph position: self leftCenter - (0@(labelMorph height // 2)) + (self geometry paddingLeft @ 0)
	].

	self label position == #rightCenter ifTrue: [ 
		labelMorph position: self rightCenter - (labelMorph width@(labelMorph height // 2)) - (self geometry paddingRight @ 0)
	].

	self label position == #leftTop ifTrue: [
		labelMorph position: self topLeft + (self geometry paddingLeft @ self geometry paddingTop)
	].

	self label position == #rightTop ifTrue: [ 
		labelMorph position: self topRight - (labelMorph width@0) - (self geometry paddingRight @ (self geometry paddingTop * (-1)))
	].

	self label position == #leftBottom ifTrue: [ 
		labelMorph position: self bottomLeft - (0@labelMorph height) + (self geometry paddingLeft @ (self geometry paddingBottom  * (-1)))
	].

	self label position == #rightBottom ifTrue: [ 
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

{ #category : #label }
GLMButton >> setLabelText: aString [

	labelMorph ifNotNil: [ labelMorph contents: aString ].
]

{ #category : #geometry }
GLMButton >> updateExtent [
	"Updated extent to fit label' size"
	
	labelMorph ifNotNil: [
		self extent: (self geometry calculateExtent: ((labelMorph measureContents x) @ (labelMorph height))).
	]
]

{ #category : #label }
GLMButton >> updateLabelTextToFit: width [
	|index text|
	"cuts displayed label text to fit passed width"
	
	(self measureWidth <= width) & (self measureWidth <= self width) ifTrue: [
		^ self
	].

	(self measureWidth <= width) ifTrue: [ 
		self label text: self label text.
	].
	
	text := self label text.
	index := text size.
	[ ((self measureLabelWidthFor: text) > width) & (index > 1) ] whileTrue: [
		text := (self label text copyReplaceFrom: index
		to: self label text size with: '...').
		index := index - 1.
	].
	
	self setLabelText: text.
	self updateExtent.
]
