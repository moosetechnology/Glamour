Class {
	#name : #GLMDropDownListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'selectedIndex'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMDropDownListPresentation >> defaultValidate: anObject on: aPort [
	"we only allow objects that are in the display value"

	(aPort name == #selection) ifFalse: [ ^ true ].
	self entity isNil ifTrue: [ ^ false ].
	^ self displayValue includes: anObject 
]

{ #category : #rendering }
GLMDropDownListPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderDropDownListPresentation: self
]

{ #category : #accessing }
GLMDropDownListPresentation >> selectedIndex [
	^ selectedIndex ifNil:[ selectedIndex := 0 ] 
]

{ #category : #accessing }
GLMDropDownListPresentation >> selectedIndex: index [
	
	selectedIndex:= index
]
