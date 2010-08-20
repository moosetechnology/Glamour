Class {
	#name : #SGLTextPorts,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLTextPorts class >> initialize [
	self registerAsApplication: 'glamour/text/textPorts'
]

{ #category : #accessing }
SGLTextPorts >> browser [
	"self new browser openOn: self new model."

	| browser |
	GLMLogger instance: GLMMemoryLogger new.
	browser := GLMTabulator new.
	browser row: #main; row: [:r | r column: #full; column: #fullFromTransmision].
	browser showOn: #main; using: [browser text].
	"browser showOn: #full; from: #main->#text; using: [browser text]."
	
	"browser transmit to: #textFromTransmision->#text; from: #main->#text; when: [:text| text notNil]; andShow: [:a| a text]."
	
	browser showOn: #fullFromTransmision; using: [browser text].
	browser transmit to: #fullFromTransmision->#text; from: #main->#text; when: [:text| text notNil].
	^ browser
]

{ #category : #accessing }
SGLTextPorts >> model [
	^'Type and select to see the 
	results previewed.'
]
