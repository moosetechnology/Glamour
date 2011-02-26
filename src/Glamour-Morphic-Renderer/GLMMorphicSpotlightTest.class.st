Class {
	#name : #GLMMorphicSpotlightTest,
	#superclass : #TestCase,
	#category : #'Glamour-Morphic-Renderer-Spotter'
}

{ #category : #'as yet unclassified' }
GLMMorphicSpotlightTest >> testCreation [
	| composite classRequest methodRequest thirdRequest |
	composite  := GLMCompositeCompletionRequest new.

	classRequest := GLMCompletionRequest new 
			prompt: 'Find Class';
			searchBlock: [ :string | OBCmdFindClass new findClassIn: Smalltalk pattern: string ];
			labelBlock: [ :class | class name ];
			iconBlock: [ :class | class browserIcon ].

	methodRequest := GLMCompletionRequest new 
			prompt: 'Object Selectors';
			searchBlock: [ :string | Object selectors select: [:e| '*', string, '*' match: e asString] ];
			labelBlock: [ :e | e ].

	thirdRequest := GLMCompletionRequest new 
			prompt: 'Other Selectors';
			searchBlock: [ :string | Object selectors select: [:e| string, '*' match: e asString] ];
			labelBlock: [ :e | e ].
			
	(composite 
		add: classRequest;
		add: methodRequest;
		add: thirdRequest;
				signal) inspect.
]

{ #category : #'as yet unclassified' }
GLMMorphicSpotlightTest >> testCreationOriginal [
	OBCompletionRequest new
			prompt: 'Find Class';
			searchBlock: [ :string | OBCmdFindClass new findClassIn: Smalltalk pattern: string ];
			labelBlock: [ :class | class name ];
			iconBlock: [ :class | class browserIcon ];
			signal.
]
