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
		display: [ :x | (x + 3) asString ];
		styled: [ :aBrick | aBrick textPosition: #center; textColor: Color random ];
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
			evaluated: [:assoc |	GTObjectPrinter new asNonTruncatedTextFrom: assoc key ]
			styled: [ :aBrick | aBrick textPosition: #rightCenter; margin: #(0 15 0 0); textColor: Color lightGray ];
		column: 'Variable'
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ]
			styled: [ :aBrick | aBrick margin: #(0 0 0 15) ];
		entity: Morph new.
	
	composite asBrickedMorph
		color: Color white;
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
