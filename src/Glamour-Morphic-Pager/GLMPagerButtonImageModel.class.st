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
GLMPagerButtonImageModel >> selected: isSelected [
	^ self pressed: false selected: isSelected
]

{ #category : #accessing }
GLMPagerButtonImageModel >> state [
	^ state
]

{ #category : #accessing }
GLMPagerButtonImageModel >> state: anImageState [
	state := anImageState.
]
