Class {
	#name : #GLMRubricTextPresentation,
	#superclass : #GLMTextualPresentation,
	#instVars : [
		'withLineNumbers',
		'withAnnotation',
		'wrapped',
		'tabWidth',
		'withColumns'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #rendering }
GLMRubricTextPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricTextPresentation: self
]

{ #category : #accessing }
GLMRubricTextPresentation >> tabWidth [
	^ tabWidth ifNil: [ TextStyle default rubTabWidth ]
]

{ #category : #accessing }
GLMRubricTextPresentation >> tabWidth: anInteger [
	tabWidth := anInteger
]

{ #category : #accessing }
GLMRubricTextPresentation >> withAnnotation [
	
	^ withAnnotation ifNil: [ withAnnotation := false ]
]

{ #category : #accessing }
GLMRubricTextPresentation >> withAnnotation: aBoolean [
	
	withAnnotation := aBoolean
]

{ #category : #accessing }
GLMRubricTextPresentation >> withLineNumbers [
	
	^ withLineNumbers ifNil: [ withLineNumbers := false ]
]

{ #category : #accessing }
GLMRubricTextPresentation >> withLineNumbers: aBoolean [
	
	withLineNumbers := aBoolean
]

{ #category : #accessing }
GLMRubricTextPresentation >> wrapped [
	
	^  wrapped ifNil: [ wrapped := true ]
]

{ #category : #accessing }
GLMRubricTextPresentation >> wrapped: aBoolean [
	
	wrapped := aBoolean
]
