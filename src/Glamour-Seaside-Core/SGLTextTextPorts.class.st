Class {
	#name : #SGLTextTextPorts,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLTextTextPorts class >> initialize [
	self registerAsApplication: 'glamour/text/textPorts'
]

{ #category : #accessing }
SGLTextTextPorts >> browser [
	"self new browser openOn: self new model."

	| browser |
	GLMLogger instance: GLMMemoryLogger new.
	browser := GLMTabulator new.
	browser 
		row: #main; 
		row: [:r | r column: #full1; column: #fullFromTransmision1]; 
		row: [:r | r column: #full2; column: #fullFromTransmision2].
	browser showOn: #main; using: [browser text].
	
	browser showOn: #full1; from: #main->#text; using: [browser text].
	browser showOn: #fullFromTransmision1; using: [browser text].
	browser transmit to: #fullFromTransmision1->#text; from: #main->#text; when: [:text| text notNil].
	
	browser showOn: #full2; from: #full1->#text; using: [browser text].
	browser showOn: #fullFromTransmision2; using: [browser text].
	browser transmit to: #fullFromTransmision2->#text; from: #fullFromTransmision1->#text; when: [:text| text notNil].
	
	^ browser
]

{ #category : #accessing }
SGLTextTextPorts >> model [
	^'Type and select to see the 
	results previewed.'
]
