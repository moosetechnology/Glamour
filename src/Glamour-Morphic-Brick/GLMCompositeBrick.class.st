"
asdasd
a
sd
asd

"
Class {
	#name : #GLMCompositeBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'examples-transmissions' }
GLMCompositeBrick class >> exampleExternalLabelChangeOnResize [
	<example: 'Table transmission'>
	|first second|
	first := GLMLabelBrick new.
	second := GLMLabelBrick new.
	
	(first transmit)
		from: #brickBounds; toPort: #text:;
		when: [ :value | value extent >= (300@150) ];
		transformed: [ :value | 'resize me! ', value asString ].
		
	(first transmit)
		from: #brickBounds; to: second port: #extent:;
		transformed: [ :value | value extent ];
		with: [ :secondBrick | secondBrick owner owner extent: secondBrick extent ].
		
	(first transmit)
		from: #label slot: #text;
		to: second port: #text:;
		transformed: [ :value | 'Do not ', value asString ];
		with: [ :label |
			label
				color: Color random muchLighter;
				changed ].
		
	((second 
		textPosition: #center;
		color: Color lightBlue)
			asBrickedMorph
			extent: 300@100;
			openInWindow) position: 200@200.
			
	((first 
		textPosition: #center;
		color: Color lightGreen)
			asBrickedMorph
			extent: 300@200;
			openInWindow)position: 500@500
]

{ #category : #'examples-transmissions' }
GLMCompositeBrick class >> exampleExternalLabelChangeOnResizeMultiple [
	<example: 'Transmission from multiple origins'>
	|first second third|
	first := GLMLabelBrick new.
	second := GLMLabelBrick new.
	third := GLMLabelBrick new.
	
	(first transmit + second transmit + third transmit)
		from: #brickBounds; toPort: #text:;
		transformed: [ :value | 'My bounds: ', value asString ].
	
	(third transmit)
		from: first slot: #brickBounds;
		from: second slot: #brickBounds;
		to: [:brick | brick owner owner ] port: #extent:;
		when: [ :firstBounds :secondBounds | firstBounds isNotNil & secondBounds isNotNil ];
		transformed: [ :firstBounds :secondBounds | firstBounds extent + secondBounds extent ].
		
	
	"just showing widgets"
	 ((third 
		textPosition: #center;
		color: Color lightBlue)
			asBrickedMorph
			extent: 300@100;
			openInWindow) position: 500@50.
			
	((second 
		textPosition: #center;
		color: Color lightRed)
			asBrickedMorph
			extent: 300@100;
			openInWindow) position: 50@50.
			
	((first 
		textPosition: #center;
		color: Color lightGreen)
			asBrickedMorph
			extent: 300@200;
			openInWindow)position: 500@300
]

{ #category : #'examples-transmissions' }
GLMCompositeBrick class >> exampleInternalLabelChangeOnResize [
	<example: 'Table transmission'>
	|first|
	first := GLMLabelBrick new.
	
	(first transmit)
		from: #brickBounds; toPort: #text:;
		when: [ :value | value extent >= (300@150) ];
		transformed: [ :value | 'resize me! ', value asString ].
			
	(first 
		textPosition: #center;
		color: Color lightGreen)
			asBrickedMorph
			extent: 300@200;
			openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> exampleList [
	<example: 'Phlowr simple list'>
	|composite|
	
	composite := self new.
	composite list
		title: 'Example';
		display: [ :x | x + 3 ];
		format: [ :anInteger | anInteger asString, ')' ];
		entity: (1 to: 100).
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> exampleListWithCustomItem [
	<example: 'Phlowr list with custom items'>
	|composite|
	
	composite := self new.
	composite list
		title: 'Example with custom items';
		display: [ :x | x + 3 ];
		format: [ :anInteger | anInteger asString ];
		styled: [ :aBrick | aBrick textPosition: #center; textColor: Color random ];
		entity: (1 to: 100).
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> examplePharoMethod [
	<example: 'Phlowr Pharo method'>
	|composite|
	
	composite := self new.
	composite pharoMethod
		title: #printString;
		display: #getSource;
		smalltalkClass: #methodClass;
		entity: Morph>>#bounds.
	
	composite asBrickedMorph
		extent: 600@400;
		openInWindow
]

{ #category : #examples }
GLMCompositeBrick class >> exampleTable [
	<example: 'Phlowr table'>
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

{ #category : #'as yet unclassified' }
GLMCompositeBrick >> custom: aBrick [

	self hasSubbricks ifFalse: [ self addBrickBack: aBrick ].
	^ self lastSubbrick 
]

{ #category : #phlowr }
GLMCompositeBrick >> list [

	^ self custom: GLMPhlowrListBrick new
]

{ #category : #phlowr }
GLMCompositeBrick >> pharoMethod [

	^ self custom: GLMPhlowrPharoMethodBrick new
]

{ #category : #phlowr }
GLMCompositeBrick >> table [

	^ self custom: GLMPhlowrTableBrick new
]

{ #category : #phlowr }
GLMCompositeBrick >> tree [
]
