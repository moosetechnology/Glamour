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

{ #category : #phlowr }
GLMCompositeBrick >> list [
	|list|
	list := GLMPhlowrListBrick new.
	list layoutProperties
		horizontalPercent: 100;
		verticalPercent: 100.
		
	^ self addBrickBack: list
]

{ #category : #phlowr }
GLMCompositeBrick >> pharoMethod [
]

{ #category : #phlowr }
GLMCompositeBrick >> tree [
]
