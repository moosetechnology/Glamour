Class {
	#name : #SGLObjectBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLObjectBrowser class >> initialize [
	self registerAsApplication: 'glamour/objectfinder'
]

{ #category : #accessing }
SGLObjectBrowser >> browser [
	| browser |
	browser := GLMFinder new.
	browser list
		display:  [ :class | 
			class subclasses 
				asSortedCollection: [ :a :b | a name < b name ] ];
		format: [ :class | class name ].
		"
			anObject inspectorFields 
				collect: [ :each | each key ] ].
	"
	"browser text
		display: [:entity | 'self' ];
		title: 'Evaluator';
		update: #selection on: $o entitled: 'Open (o)' with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		act: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ] on: $/ entitled: 'Inspect (/)'."
	
	^ browser
]

{ #category : #accessing }
SGLObjectBrowser >> model [
	^ Object
]
