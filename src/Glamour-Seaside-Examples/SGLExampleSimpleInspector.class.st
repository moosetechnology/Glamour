Class {
	#name : #SGLExampleSimpleInspector,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLExampleSimpleInspector class >> initialize [
	self registerAsApplication: 'glamour/development/inspector/objectclass'
]

{ #category : #accessing }
SGLExampleSimpleInspector >> browser [
	"self new browser openOn: self new model."
		| browser |
	browser := GLMTabulator new.
	browser row: #main.

	browser transmit to: #main; andShow: [ :a |
		a custom: (GTInspector new)  ].
		
	^browser
]

{ #category : #accessing }
SGLExampleSimpleInspector >> model [
	^ Object>>#copy
]
