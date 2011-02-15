"
A GLMPresentation is the abstract class for the hierarchy of presentations. A presentation specifies how the pane (held in the pane instance variable) is going to be displayed. It typically reads at least the #entity port of a pane and populates at least the #selection port.

updateActions holds a collection of GLMUpdateAction that are used to update the presentation via announcements.

Because Glamour has a prototype-based design it relies on copying the presentations before installing them in panes (via transmissions). The parentPrototype instance variable keeps track of the presentation from which the current one was copied.

It raises:
- GLMContextChanged to let the world know that something has changed in the containing pane. This is typically used by the renderer to update the rendering
"
Class {
	#name : #GLMPresentation,
	#superclass : #GLMLoggedObject,
	#instVars : [
		'pane',
		'title',
		'titleIcon',
		'transformation',
		'actions',
		'condition',
		'implicitNotNil',
		'postTransformation',
		'dynamicActionsBlock',
		'color',
		'customValidation',
		'shouldValidate',
		'acceptsSelection',
		'parentPrototype',
		'registeredAnnouncers',
		'updateActions',
		'selectionActions',
		'selectionDynamicActionsBlock'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPresentation >> acceptsSelection [
	"this flag is used to specify whether the presentation
	is allowed to populate the selection port or not"
	^ acceptsSelection ifNil: [acceptsSelection := true]
]

{ #category : #accessing }
GLMPresentation >> acceptsSelection: aBoolean [
	acceptsSelection := aBoolean
]

{ #category : #accessing }
GLMPresentation >> actions [
	"These are actions that make sense for the entire presentation."
	actions ifNil: [actions := OrderedCollection new].
	^ actions
]

{ #category : #accessing }
GLMPresentation >> addAction: anAction [ 
	 
	self actions addLast: anAction
]

{ #category : #accessing }
GLMPresentation >> addSelectionAction: anAction [
	self selectionActions add: anAction
]

{ #category : #accessing }
GLMPresentation >> allActions [ 
	^ self actions, self dynamicActions
]

{ #category : #accessing }
GLMPresentation >> allSelectionActions [ 
	^ self selectionActions, self dynamicActionsOnSelection
]

{ #category : #accessing }
GLMPresentation >> color [
	^ color
]

{ #category : #accessing }
GLMPresentation >> color: aSymbolOrColor [
	color := aSymbolOrColor
]

{ #category : #'accessing values' }
GLMPresentation >> colorValue [
	^ self color notNil
		ifTrue: [ self color glamourValue: self entity ]
		ifFalse: [ self color ]
"
	
	self color isSymbol
		ifTrue: [ Color perform: self color ]
		ifFalse: [ self color ]"
]

{ #category : #accessing }
GLMPresentation >> condition [ 
	 
	^condition ifNil: [condition := [true]]
]

{ #category : #accessing }
GLMPresentation >> condition: anObject [ 
	 
	condition := anObject
]

{ #category : #copying }
GLMPresentation >> copy [
	| copy |
	copy := super copy.
	copy parentPrototype: self.
	^ copy
]

{ #category : #'accessing validation' }
GLMPresentation >> customValidation [
	^ customValidation
]

{ #category : #'accessing validation' }
GLMPresentation >> customValidation: aBlock [
	customValidation := aBlock.
	shouldValidate := true.
]

{ #category : #validation }
GLMPresentation >> defaultValidate: anObject on: aPort [ 
	"by default any object is allowed in any port"
	^ true
]

{ #category : #'accessing values' }
GLMPresentation >> displayValue [
	^ self transformation glamourValue: self entity
]

{ #category : #validation }
GLMPresentation >> doValidate: anObject on: aPort [ 
	^ self customValidation isNil ifFalse: [ 
		self customValidation glamourValue: (
			anObject asGlamorousMultiValue,
			aPort name asGlamorousMultiValue, 
			self entity asGlamorousMultiValue) ]
	ifTrue: [ self defaultValidate: anObject on: aPort ]
]

{ #category : #accessing }
GLMPresentation >> dynamicActions [
	"These are actions that make sense for the entire presentation.
	They are dynamic in the sense that they will be evaluated lazily by the renderer"
	dynamicActionsBlock isNil ifTrue: [ ^ OrderedCollection new ].
	^ dynamicActionsBlock glamourValue: self
]

{ #category : #accessing }
GLMPresentation >> dynamicActionsOnSelection [
	"These are actions that make sense only in the context of values held in the selection port.
	They are dynamic in the sense that they will be evaluated lazily by the renderer"
	selectionDynamicActionsBlock isNil ifTrue: [ ^ OrderedCollection new ].
	^ selectionDynamicActionsBlock glamourValue: self
]

{ #category : #accessing }
GLMPresentation >> dynamicActionsOnSelection: aBlock [
	selectionDynamicActionsBlock := aBlock
]

{ #category : #'accessing ports' }
GLMPresentation >> entity [
	^ (self pane port: #entity) value
]

{ #category : #'accessing ports' }
GLMPresentation >> entity: anObject [
	(self pane port: #entity) value: anObject
]

{ #category : #testing }
GLMPresentation >> hasActions [
	^ self allActions notEmpty
]

{ #category : #testing }
GLMPresentation >> hasTitle [
	^ title notNil
]

{ #category : #testing }
GLMPresentation >> hasTitleIcon [
	^ self titleIcon notNil
]

{ #category : #'initialize-release' }
GLMPresentation >> initialize [
	super initialize.	
	updateActions := OrderedCollection new
]

{ #category : #events }
GLMPresentation >> innerPortEvent: aPortEvent [ 
	 "Regular presentations do not have inner ports,
	  so the default behaviour is to do nothing"
]

{ #category : #testing }
GLMPresentation >> limitsAmount [
	^ amountToShowBlock notNil
]

{ #category : #testing }
GLMPresentation >> matches [ 
	^ (self usesImplicitNotNil 
		ifTrue: [GLMAllNotNilCondition new glamourValue: self entity] 
		ifFalse: [GLMSomeNotNilCondition new glamourValue: self entity]
	) and: [
			(self condition glamourValue: self entity) = true]
]

{ #category : #events }
GLMPresentation >> outerPortEvent: aPortEvent [
	self announce: (GLMContextChanged new
				presentation: self; 
				property: aPortEvent portName; 
				value: aPortEvent value; 
				oldValue: aPortEvent oldValue; 
				yourself)
]

{ #category : #accessing }
GLMPresentation >> pane [
	^ pane ifNil: [
		pane := (GLMPane in: GLMNoBrowser new) 
				addPresentationSilently: self; 
				yourself]
]

{ #category : #accessing }
GLMPresentation >> pane: aPane [ 
	 
	pane := aPane
]

{ #category : #copying }
GLMPresentation >> parentPrototype [
	^ parentPrototype
]

{ #category : #copying }
GLMPresentation >> parentPrototype: aPresentation [
	"used to keep track of the (prototype) presentation from which
	the current one was copied"
	parentPrototype := aPresentation
]

{ #category : #copying }
GLMPresentation >> postCopy [
	super postCopy.
	self resetAnnouncer.
	pane := nil.
	updateActions := updateActions collect: [:each | 
		each copy 
			presentation: self;
			yourself
		]
]

{ #category : #accessing }
GLMPresentation >> postTransformation [
	"this is used for transforming the object before updating the selection"
	^ postTransformation ifNil: [postTransformation := #yourself]
]

{ #category : #printing }
GLMPresentation >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '(id=', self identityHash printString.
	aStream nextPutAll: ' title=', self titleValue asString.
	aStream nextPutAll: ' pane=', self pane printString , ')'
]

{ #category : #updating }
GLMPresentation >> registerAnnouncements [
	self flag: 'The announcements should potentially be interested in any ports, not just in entity'.
	updateActions do: [:each | each registerInPresentation ].
]

{ #category : #updating }
GLMPresentation >> registeredAnnouncers [
	^ registeredAnnouncers ifNil: [registeredAnnouncers := OrderedCollection new]
]

{ #category : #rendering }
GLMPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^aRenderer renderPresentation: self
]

{ #category : #copying }
GLMPresentation >> rootPrototype [
	^ self parentPrototype isNil 
		ifTrue: [ self ] 
		ifFalse: [ self parentPrototype rootPrototype ]

]

{ #category : #'accessing ports' }
GLMPresentation >> selection [
	^ (self pane port: #selection) value
]

{ #category : #'accessing ports' }
GLMPresentation >> selection: anObject [ 
	self acceptsSelection ifFalse: [^ self].
	self flag: 'perhaps it would be better to provide 2 ports: a transformed one and a normal onewsho'.
	(self pane port: #selection) value: (self postTransformation glamourValue: anObject)
]

{ #category : #accessing }
GLMPresentation >> selectionActions [
	"These are actions that make sense only in the context of values held in the selection port."
	^ selectionActions ifNil: [ selectionActions := OrderedCollection new ]
]

{ #category : #accessing }
GLMPresentation >> selectionActions: anObject [
	selectionActions := anObject
]

{ #category : #accessing }
GLMPresentation >> selectionTransformation: anObject [ 
	postTransformation := anObject
]

{ #category : #'accessing validation' }
GLMPresentation >> shouldValidate [
	^ shouldValidate ifNil: [shouldValidate := false]
]

{ #category : #'accessing validation' }
GLMPresentation >> shouldValidate: aBoolean [
	shouldValidate := aBoolean 
]

{ #category : #'accessing ports' }
GLMPresentation >> status: anObject [ 
	self flag: 'what kind of transformation should we want here?'.
	(self pane port: #status) value: (self postTransformation glamourValue: anObject)
]

{ #category : #'accessing ports' }
GLMPresentation >> strongSelection [
	^ (self pane port: #strongSelection) value
]

{ #category : #'accessing ports' }
GLMPresentation >> strongSelection: anObject [
	(self pane port: #strongSelection) value: (self postTransformation glamourValue: anObject)
]

{ #category : #accessing }
GLMPresentation >> title [
	^ title
]

{ #category : #accessing }
GLMPresentation >> title: aStringOrBlock [ 
	 
	title := aStringOrBlock
]

{ #category : #accessing }
GLMPresentation >> titleIcon [
	^ titleIcon
]

{ #category : #accessing }
GLMPresentation >> titleIcon: anObject [
	titleIcon := anObject
]

{ #category : #'accessing values' }
GLMPresentation >> titleIconValue [
	^ self titleIcon notNil
		ifTrue: [ self titleIcon glamourValue: self entity ]
		ifFalse: [ self titleIcon ]
]

{ #category : #'accessing values' }
GLMPresentation >> titleValue [
	^ self title glamourValue: self entity
]

{ #category : #accessing }
GLMPresentation >> transformation [ 
	 
	^transformation ifNil: [transformation := #yourself]
]

{ #category : #accessing }
GLMPresentation >> transformation: aBlock [ 
	 
	transformation := aBlock
]

{ #category : #updating }
GLMPresentation >> unregisterFromAllAnnouncements [
	"this method should be called every time the presentation is not needed"
	updateActions do: [ :each | each unregisterFromAllAnnouncements ]
]

{ #category : #updating }
GLMPresentation >> update [
	self pane ports do: [:each |
		(self validate: each value on: each) ifFalse: [each resetValue] ].
	self announce: (GLMPresentationUpdated new presentation: self)
]

{ #category : #updating }
GLMPresentation >> updateOn: anAnnouncement from: aBlockOrSymbol [ 
	updateActions add: (GLMSingleUpdateAction new 
		presentation: self;
		announcement: anAnnouncement; 
		transformation: aBlockOrSymbol;
		yourself)
]

{ #category : #updating }
GLMPresentation >> updateOn: anAnnouncement from: aBlockOrSymbol when: aConditionBlock [
	updateActions add: (GLMSingleUpdateAction new
		presentation: self; 
		announcement: anAnnouncement; 
		transformation: aBlockOrSymbol;
		condition: aConditionBlock;
		yourself)
]

{ #category : #updating }
GLMPresentation >> updateOn: anAnnouncement fromAll: aBlockOrSymbol [ 
	updateActions add: (GLMMultipleUpdateAction new
		presentation: self; 
		announcement: anAnnouncement; 
		transformation: aBlockOrSymbol;
		yourself)
]

{ #category : #accessing }
GLMPresentation >> useExplicitNotNil [ 
	 
	implicitNotNil := false
]

{ #category : #accessing }
GLMPresentation >> useImplicitNotNil [ 
	 
	implicitNotNil := true
]

{ #category : #testing }
GLMPresentation >> usesExplicitNotNil [ 
	 
	^self usesImplicitNotNil not
]

{ #category : #testing }
GLMPresentation >> usesImplicitNotNil [ 
	 
	^implicitNotNil ifNil: [implicitNotNil := true]
]

{ #category : #validation }
GLMPresentation >> validate: anObject on: aPort [ 
	"This gets triggered when aPort wants to be changed.
	The presentation has a chance to veto the value."
	self shouldValidate ifFalse: [ ^ true ].
	^ self doValidate: anObject on: aPort.
]

{ #category : #enumeration }
GLMPresentation >> withAllDo: aBlock [
	^ aBlock value: self
]
