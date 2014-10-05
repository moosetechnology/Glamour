Class {
	#name : #GLMTurboImageState,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-Model'
}

{ #category : #states }
GLMTurboImageState class >> normalColorOf: aTrick [
	^ self pressedColor: false selectedColor: false of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> normalOf: aTrick [
	^ self pressed: false selected: false of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> pressed: isPressed of: aTrick [
	^ self pressed: isPressed selected: false of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> pressed: isPressed selected: isSelected checked: isChecked of: aTrick [
	"answers sender with image, corresponding specified state"
	
	"pressed has the highest priority"
	(isPressed & aTrick pressedImage notNil)
		ifTrue: [ ^ aTrick pressedImage ].
	
	(((isPressed & aTrick pressedImage isNil) | isSelected) & aTrick selectedImage notNil)
		ifTrue: [ ^ aTrick selectedImage ].
		
	(isChecked & aTrick checkedImage notNil)
		ifTrue: [ ^ aTrick checkedImage ].
	
	^ aTrick normalImage.
]

{ #category : #states }
GLMTurboImageState class >> pressed: isPressed selected: isSelected of: aTrick [
	^ self pressed: isPressed selected: isSelected checked: false of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> pressedColor: isPressed of: aTrick [
	^ self pressedColor: isPressed selectedColor: false of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> pressedColor: isPressed selectedColor: isSelected checkedColor: isChecked of:aTrick [
	"answers sender with image, corresponding specified state"
	
	"pressed has the highest priority"
	(isPressed & aTrick pressedColor notNil)
		ifTrue: [ ^ aTrick pressedColor ].
	
	(((isPressed & aTrick pressedColor isNil) | isSelected) & aTrick selectedColor notNil)
		ifTrue: [ ^ aTrick selectedColor ].
		
	(isChecked & aTrick checkedColor notNil)
		ifTrue: [ ^ aTrick checkedColor ].
	
	^ aTrick normalColor.
]

{ #category : #states }
GLMTurboImageState class >> pressedColor: isPressed selectedColor: isSelected of: aTrick [
	^ self pressedColor: isPressed selectedColor: isSelected checkedColor: false of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> selected: isSelected of: aTrick [
	^ self pressed: false selected: isSelected of: aTrick
]

{ #category : #states }
GLMTurboImageState class >> selectedColor: isSelected of: aTrick [
	^ self pressedColor: false selectedColor: isSelected of: aTrick
]
