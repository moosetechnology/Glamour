Class {
	#name : #GLMPagerButtonLabelModel,
	#superclass : #Object,
	#instVars : [
		'position',
		'text',
		'announcer'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerButtonLabelModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GLMPagerButtonLabelModel >> initialize [
	super initialize.
	
	text := ''.
	position := #center.
]

{ #category : #private }
GLMPagerButtonLabelModel >> notifyLabelPositionChanged [
	self announcer announce: GLMPagerButtonLabelPositionChanged new.
]

{ #category : #private }
GLMPagerButtonLabelModel >> notifyLabelTextChanged [
	self announcer announce: GLMPagerButtonLabelTextChanged new.
]

{ #category : #accessing }
GLMPagerButtonLabelModel >> position [
	^ position
]

{ #category : #accessing }
GLMPagerButtonLabelModel >> position: aSymbol [
		"aSymbol can be:
		#center 			- 	will be centered vertically and horizontally;
		#leftCenter 		- 	will be moved to the left and be centered vertically
		#rightCenter 	- 	will be moved to the right an be centered vertically
		#leftTop 			-	will be moved to the left and top
		#rightTop 		-	will be moved to the right and top
		#leftBottom 		- 	will be moved to the left and bottom
		#rightBottom 	-	will be moved to the right and bottom"
				
	position := aSymbol.
	self notifyLabelPositionChanged.
]

{ #category : #accessing }
GLMPagerButtonLabelModel >> text [
	^ text
]

{ #category : #accessing }
GLMPagerButtonLabelModel >> text: aString [
	text := aString.
	self notifyLabelTextChanged.
]
