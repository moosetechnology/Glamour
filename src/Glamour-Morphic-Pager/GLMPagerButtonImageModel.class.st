Class {
	#name : #GLMPagerButtonImageModel,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #initialization }
GLMPagerButtonImageModel >> initialize [
	super initialize.
	
	state := GLMPagerButtonImageState new.
]

{ #category : #states }
GLMPagerButtonImageModel >> normal [
	^ self pressed: false selected: false
]

{ #category : #states }
GLMPagerButtonImageModel >> normalColor [
	^ self pressedColor: false selectedColor: false
]

{ #category : #states }
GLMPagerButtonImageModel >> pressed: isPressed [
	^ self pressed: isPressed selected: false
]

{ #category : #states }
GLMPagerButtonImageModel >> pressed: isPressed selected: isSelected [
	^ self pressed: isPressed selected: isSelected checked: false
]

{ #category : #states }
GLMPagerButtonImageModel >> pressed: isPressed selected: isSelected checked: isChecked [
	"answers sender with image, corresponding specified state"
	
	"pressed has the highest priority"
	(isPressed & self state pressed notNil)
		ifTrue: [ ^ self state pressed ].
	
	(((isPressed & self state pressed isNil) | isSelected) & self state selected notNil)
		ifTrue: [ ^ self state selected ].
		
	(isChecked & self state checked notNil)
		ifTrue: [ ^ self state checked ].
	
	^ self state normal.
]

{ #category : #states }
GLMPagerButtonImageModel >> pressedColor: isPressed [
	^ self pressedColor: isPressed selectedColor: false
]

{ #category : #states }
GLMPagerButtonImageModel >> pressedColor: isPressed selectedColor: isSelected [
	^ self pressedColor: isPressed selectedColor: isSelected checkedColor: false
]

{ #category : #states }
GLMPagerButtonImageModel >> pressedColor: isPressed selectedColor: isSelected checkedColor: isChecked [
	"answers sender with image, corresponding specified state"
	
	"pressed has the highest priority"
	(isPressed & self state pressedColor notNil)
		ifTrue: [ ^ self state pressedColor ].
	
	(((isPressed & self state pressedColor isNil) | isSelected) & self state selectedColor notNil)
		ifTrue: [ ^ self state selectedColor ].
		
	(isChecked & self state checkedColor notNil)
		ifTrue: [ ^ self state checkedColor ].
	
	^ self state normalColor.
]

{ #category : #states }
GLMPagerButtonImageModel >> selected: isSelected [
	^ self pressed: false selected: isSelected
]

{ #category : #states }
GLMPagerButtonImageModel >> selectedColor: isSelected [
	^ self pressedColor: false selectedColor: isSelected
]

{ #category : #accessing }
GLMPagerButtonImageModel >> state [
	^ state
]

{ #category : #accessing }
GLMPagerButtonImageModel >> state: anImageState [
	state := anImageState.
]
