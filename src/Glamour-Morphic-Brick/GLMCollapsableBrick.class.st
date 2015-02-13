Class {
	#name : #GLMCollapsableBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'headerBrick',
		'contentBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #'instance creation' }
GLMCollapsableBrick class >> createCollapsable [

	^ self new
		with: [ :collapsable | 
			collapsable headerBrick:
				(GLMBrick new
					addBrickBack:
						(GLMActionButtonBrick new
							icon: GLMUIThemeExtraIcons glamorousRight;
							marginLeft: 10;
							height: [ :b | b icon height * 1.2 ];
							width: [ :b | b icon width * 1.2 ];
							checkedImage: GLMUIThemeExtraIcons glamorousDown;
							addUpAction: [ :b | 
								collapsable toggle.
								collapsable isExpanded
									ifTrue: [ b check ]
									ifFalse: [ b uncheck ] ]);
					addBrickBack:
						(GLMLabelBrick new
							marginLeft: 10;
							text: 'Header';
							hSpaceFill;
							height: [ :b | b approximateHeight ]);
					vShrinkWrap;
					hSpaceFill) ];
		contentBrick:
			(GLMBrick new
				useVerticalLinearLayout;
				hSpaceFill;
				addAllBricks: {
					(GLMBrick new color: Color random; hSpaceFill).
					(GLMBrick new color: Color random; hSpaceFill).
					(GLMBrick new color: Color random; hSpaceFill).
					(GLMBrick new color: Color random; hSpaceFill)};
				yourself)
]

{ #category : #'instance creation' }
GLMCollapsableBrick class >> createCollapsableArray: anInteger [

	^ (1 to: anInteger) collect: [ :index | self createCollapsable hSpaceFill  ]
]

{ #category : #examples }
GLMCollapsableBrick class >> exampleInScrollPane [
	<example>
	
	(GLMScrollPaneBrick new
		addAllBricks: (self createCollapsableArray: 10);
		yourself)
			asBrickedMorph
				extent: 500@300;
				color: (Color r: 249 g: 249 b: 249 range: 255);
				openInWindow
]

{ #category : #examples }
GLMCollapsableBrick class >> exampleSimple [
	<example>
	(self createCollapsable)
			asBrickedMorph
				extent: 300 @ 500;
				openInWindow
]

{ #category : #actions }
GLMCollapsableBrick >> collapse [

	self contentBrick ifNil: [ ^ self ].

	self isExpanded
		ifTrue: [ self removeBrick: self contentBrick ]
]

{ #category : #accessing }
GLMCollapsableBrick >> contentBrick [
	^ contentBrick
]

{ #category : #accessing }
GLMCollapsableBrick >> contentBrick: aBrick [
	contentBrick := aBrick.
	
	self contentBrick
		hSpaceFill;
		vShrinkWrap
]

{ #category : #actions }
GLMCollapsableBrick >> expand [

	self contentBrick ifNil: [ ^ self ].

	self isExpanded
		ifFalse: [ self addBrickBack: self contentBrick ]
]

{ #category : #accessing }
GLMCollapsableBrick >> headerBrick [
	^ headerBrick
]

{ #category : #accessing }
GLMCollapsableBrick >> headerBrick: aBrick [
	headerBrick := aBrick.
	
	self headerBrick hSpaceFill.
	
	self addBrickFirst: self headerBrick
]

{ #category : #initialization }
GLMCollapsableBrick >> initialize [
	super initialize.
	
	self
		useVerticalLinearLayout;
		vShrinkWrap
]

{ #category : #testing }
GLMCollapsableBrick >> isExpanded [

	^ self hasSubbrick: self contentBrick
]

{ #category : #actions }
GLMCollapsableBrick >> toggle [

	self isExpanded
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ]
]