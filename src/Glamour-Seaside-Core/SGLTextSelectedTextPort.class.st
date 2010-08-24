Class {
	#name : #SGLTextSelectedTextPort,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #accessing }
SGLTextSelectedTextPort >> browser [
	| browser |
	browser := GLMTabulator new.
	browser 
		row: [:r | r column: #main; column: #selection].
	browser showOn: #main; using: [browser text].

	browser showOn: #selection->#text; from: #main->#text; using: [browser text].
	browser transmit to: #selection->#selection; from: #main->#selection; when: [:text| text notNil].
	
	^ browser
]
