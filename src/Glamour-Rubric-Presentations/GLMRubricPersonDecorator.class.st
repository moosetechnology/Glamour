Class {
	#name : #GLMRubricPersonDecorator,
	#superclass : #GLMHighlighterTextStylerDecorator,
	#category : #'Glamour-Rubric-Presentations-Examples'
}

{ #category : #querying }
GLMRubricPersonDecorator class >> key [
	^ #registryStyler
]

{ #category : #example }
GLMRubricPersonDecorator class >> scrolledText1 [
	"self scrolledText1"

	RubScrolledTextMorph  new
		extent: 500@300;
		editingMode: (RbEPersonRegistryMode new);
		updateTextWith: '
person {	
	name	=	''Phil'';
	age = ''23'';	
}
person {}
';
		openInWorld
]

{ #category : #example }
GLMRubricPersonDecorator class >> textArea1 [
	"self textArea1"

	RubEditingArea new
		beWrapped;
		width: 500;
		withDecoratorNamed: #registryStyler;
		updateTextWith: '
person {	
	name	=	''Phil'';
	age = ''23'';	
}
person {}
';
		openInWorld
]

{ #category : #'as yet unclassified' }
GLMRubricPersonDecorator >> parser [

	^ GLMRubricPersonColorizer new
]
