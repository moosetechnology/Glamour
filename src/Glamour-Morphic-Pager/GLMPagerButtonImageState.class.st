Class {
	#name : #GLMPagerButtonImageState,
	#superclass : #Object,
	#instVars : [
		'normalImage',
		'pressedImage',
		'selectedImage',
		'checkedImage',
		'announcer',
		'checkedColor',
		'normalColor',
		'pressedColor',
		'selectedColor'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #'as yet unclassified' }
GLMPagerButtonImageState >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #getters }
GLMPagerButtonImageState >> checked [
	^ checkedImage
]

{ #category : #'setters-image' }
GLMPagerButtonImageState >> checked: anImage [
	checkedImage := anImage.
	self stateUpdated.
]

{ #category : #getters }
GLMPagerButtonImageState >> checkedColor [
	^ checkedColor
]

{ #category : #'setters-color' }
GLMPagerButtonImageState >> checkedColor: aColor [
	self checked: (self imageFromColor: aColor).
	checkedColor:= aColor.
]

{ #category : #'setters-file' }
GLMPagerButtonImageState >> checkedFromFile: aString [
	self checked: (self imageFromFile: aString)
]

{ #category : #'setters-color' }
GLMPagerButtonImageState >> imageFromColor: aColor [
	^ Morph new color: aColor; imageForm
]

{ #category : #'setters-file' }
GLMPagerButtonImageState >> imageFromFile: aString [
	^ ImageReadWriter formFromFileNamed: aString.
]

{ #category : #getters }
GLMPagerButtonImageState >> normal [
	^ normalImage
]

{ #category : #'setters-image' }
GLMPagerButtonImageState >> normal: anImage [
	normalImage := anImage.
	self stateUpdated.
]

{ #category : #getters }
GLMPagerButtonImageState >> normalColor [
	^ normalColor
]

{ #category : #'setters-color' }
GLMPagerButtonImageState >> normalColor: aColor [
	self normal: (self imageFromColor: aColor).
	normalColor := aColor.
]

{ #category : #'setters-file' }
GLMPagerButtonImageState >> normalFromFile: aString [
	self normal: (self imageFromFile: aString)
]

{ #category : #getters }
GLMPagerButtonImageState >> pressed [
	^ pressedImage
]

{ #category : #'setters-image' }
GLMPagerButtonImageState >> pressed: anImage [
	pressedImage := anImage.
	self stateUpdated.
]

{ #category : #getters }
GLMPagerButtonImageState >> pressedColor [
	^ pressedColor
]

{ #category : #'setters-color' }
GLMPagerButtonImageState >> pressedColor: aColor [
	self pressed: (self imageFromColor: aColor).
	pressedColor := aColor.
]

{ #category : #'setters-file' }
GLMPagerButtonImageState >> pressedFromFile: aString [
	self pressed: (self imageFromFile: aString)
]

{ #category : #getters }
GLMPagerButtonImageState >> selected [
	^ selectedImage
]

{ #category : #'setters-image' }
GLMPagerButtonImageState >> selected: anImage [
	selectedImage := anImage.
	self stateUpdated.
]

{ #category : #getters }
GLMPagerButtonImageState >> selectedColor [
	^ selectedColor
]

{ #category : #'setters-color' }
GLMPagerButtonImageState >> selectedColor: aColor [
	self selected: (self imageFromColor: aColor).
	selectedColor := aColor.
]

{ #category : #'setters-file' }
GLMPagerButtonImageState >> selectedFromFile: aString [
	self selected: (self imageFromFile: aString)
]

{ #category : #'as yet unclassified' }
GLMPagerButtonImageState >> stateUpdated [
	self announcer announce: GLMPagerButtonImageUpdated new.
]
