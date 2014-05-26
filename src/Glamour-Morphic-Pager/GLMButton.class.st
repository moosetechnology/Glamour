"
|form newForm|

form := ImageReadWriter formFromFileNamed: '9patch.png'.
newForm := Patch9Form scalePatch9Form: form size:  100@100.
(ImageMorph withForm: newForm) openInWindow.
"
Class {
	#name : #GLMButton,
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'fontModel',
		'buttonModel',
		'imageModel'
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
]

{ #category : #drawing }
GLMButton >> drawOn: aCanvas [
	|image|
	image := self image pressed: (self buttonModel isPressed) selected: (self buttonModel isSelected) checked: (self buttonModel isChecked).
	image ifNotNil: [
		aCanvas 
			translucentImage: (self resizeImage: image scale:  (bounds extent / image extent))
			at: bounds origin.
	].
	
	super drawOn: aCanvas.
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
	self buttonModel: GLMPagerButtonModel new.
	
	super initialize.	
	
	self borderWidth: 0.
	
	self color: (Color transparent).
]

{ #category : #accessing }
GLMButton >> label: aString [
	super label: aString font: self logicalFont.
	"we need to update label color because label in button is completely recreated =/ "
	label color: self font color.
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

{ #category : #drawing }
GLMButton >> resizeImage: anImage scale: aScale [
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2
]
