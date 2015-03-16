Class {
	#name : #GLMRubricTextFieldMorph,
	#superclass : #RubTextFieldMorph,
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #accessing }
GLMRubricTextFieldMorph >> container: aMorph [

	self textArea container: aMorph.
]

{ #category : #accessing }
GLMRubricTextFieldMorph >> font: aFont [

	self textArea font: aFont
]

{ #category : #'event handling' }
GLMRubricTextFieldMorph >> handlesMouseWheel: evt [
	"Do I want to receive mouseWheel events?" 

	^ false
]

{ #category : #'initialize-release' }
GLMRubricTextFieldMorph >> newScrollPane [
	| sp |
	sp := GLMRubricTextFieldScrollPane new.
	sp scrollTarget: self defaultScrollTarget.
	^ sp
]

{ #category : #'initialize-release' }
GLMRubricTextFieldMorph >> textAreaClass [
	^ GLMRubricTextFieldArea
]

{ #category : #'event handling' }
GLMRubricTextFieldMorph >> whenGotForcus: anAnnouncement [
	super whenGotForcus: anAnnouncement.
	
	self color: Smalltalk ui theme backgroundColor.
]

{ #category : #'event handling' }
GLMRubricTextFieldMorph >> whenLostForcus: anAnnouncement [
	super whenLostForcus: anAnnouncement.
	
	self color: Color transparent.
]
