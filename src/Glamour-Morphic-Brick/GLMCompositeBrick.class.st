Class {
	#name : #GLMCompositeBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #examples }
GLMCompositeBrick class >> exampleList [
	|composite|
	
	composite := self new.
	composite list
		display: [ :x | x + 3 ];
		title: 'Example';
		entity: (1 to: 100).
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> exampleListWithCustomItem [
	|composite|
	
	composite := self new.
	composite list
		display: [ :x | GLMLabelBrick new text: (x + 3) asString; textPosition: #center; textColor: Color random; yourself ];
		title: 'Example with custom items';
		entity: (1 to: 100).
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> examplePharoMethod [
	|composite|
	
	composite := self new.
	composite pharoMethod
		display: #getSource;
		smalltalkClass: #methodClass;
		title: #printString;
		entity: Morph>>#bounds.
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> exampleTable [
	|composite|
	
	composite := self new.
	composite table
		title: #asString;
		display: [ :anObject | (anObject gtInspectorVariableValuePairs asSortedCollection asOrderedCollection yourself) addFirst: 'self' -> anObject; yourself ];
		column: 'Variable'
			evaluated: [:assoc | '  ',(GTObjectPrinter new asNonTruncatedTextFrom: assoc key) ];
		column: 'Variable'
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ];
		entity: Morph new.
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #phlowr }
GLMCompositeBrick >> list [

	^ self addBrickBack: GLMPhlowrListBrick new
]

{ #category : #phlowr }
GLMCompositeBrick >> pharoMethod [

	^ self addBrickBack: GLMPhlowrPharoMethodBrick new
]

{ #category : #phlowr }
GLMCompositeBrick >> table [

	^ self addBrickBack: GLMPhlowrTableBrick new
]

{ #category : #phlowr }
GLMCompositeBrick >> tree [
]
