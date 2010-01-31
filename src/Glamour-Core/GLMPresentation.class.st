"
A GLMPresentation is the abstract class for the hierarchy of presentations. A presentation specifies how the pane is going to be displayed. It typically reads at least the #entity port of a pane and populates at least the #selection port.
"
Class {
	#name : #GLMPresentation,
	#superclass : #Object,
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
		'updateAnnouncementsToBlocks',
		'color',
		'customValidation',
		'shouldValidate',
		'acceptsSelection',
		'announcer',
		'parentPrototype',
		'registeredAnnouncers'
	],
	#category : #'Glamour-Core'
}

{ #category : #comparison }
GLMPresentation >> = aPresentation [
	^ self class = aPresentation class and: [
		self rootPrototype == aPresentation rootPrototype ]
]

{ #category : #accessing }
GLMPresentation >> acceptsSelection [
	^ acceptsSelection ifNil: [acceptsSelection := true]
]

{ #category : #accessing }
GLMPresentation >> acceptsSelection: aBoolean [
	acceptsSelection := aBoolean
]

{ #category : #accessing }
GLMPresentation >> actions [
	actions ifNil: [actions := OrderedCollection new].
	^ actions
]

{ #category : #accessing }
GLMPresentation >> addAction: anAction [ 
	 
	self actions addLast: anAction
]

{ #category : #accessing }
GLMPresentation >> allActions [ 
	^ self actions, self dynamicActions
]

{ #category : #announcements }
GLMPresentation >> announce: anAnnouncement [
	^ self announcer announce: anAnnouncement
]

{ #category : #announcements }
GLMPresentation >> announcer [
	^ announcer ifNil: [announcer := Announcer new]
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
	dynamicActionsBlock isNil ifTrue: [ ^ OrderedCollection new ].
	^ dynamicActionsBlock glamourValue: self
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
GLMPresentation >> hasTitle [
	^ title notNil
]

{ #category : #testing }
GLMPresentation >> hasTitleIcon [
	^ self titleIcon notNil
]

{ #category : #'initialize-release' }
GLMPresentation >> initialize [
	updateAnnouncementsToBlocks := Dictionary new
]

{ #category : #events }
GLMPresentation >> innerPortEvent: aPortEvent [ 
	 "Regular presentations do not have inner ports,
	  so the default behaviour is to do nothing"
]

{ #category : #testing }
GLMPresentation >> matches [ 
	^ (self usesImplicitNotNil 
		ifTrue: [GLMAllNotNilCondition new glamourValue: self entity] 
		ifFalse: [GLMSomeNotNilCondition new glamourValue: self entity]
	) and: [
			(self condition glamourValue: self entity) = true]
]

{ #category : #announcements }
GLMPresentation >> on: anAnnouncementClass do: aValuable [
	^ self when: anAnnouncementClass do: aValuable 
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
				addPresentation: self; 
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
GLMPresentation >> parentPrototype: anObject [
	parentPrototype := anObject
]

{ #category : #copying }
GLMPresentation >> postCopy [
	super postCopy.
	announcer := nil.
	pane := nil.
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
	| registeredAnnouncers |
	self flag: 'The announcements should potentially be interested in any ports, not just in entity'.
	updateAnnouncementsToBlocks keysAndValuesDo: [ :key :value |
		value do: [ :eachValue | 
			| announcerObject |
			announcerObject := (eachValue glamourValue: self entity).
			announcerObject notNil ifTrue: [
				announcerObject on: key do: [ :announcement | self update ].
				"we remember the announcer object to be able to 
				unregister from it when the presentation goes away"
				self registeredAnnouncers add: announcerObject ]]]
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

{ #category : #announcements }
GLMPresentation >> resetAnnouncer [
	self announcer reset
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
	self flag: 'perhaps it would be better to provide 2 ports: a transformed one and a normal one'.
	(self pane port: #selection) value: (self postTransformation glamourValue: anObject)
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
	self registeredAnnouncers do: [ :each | each unsubscribe: self ]
]

{ #category : #updating }
GLMPresentation >> update [
	self pane ports do: [:each |
		(self validate: each value on: each) ifFalse: [each resetValue] ].
	self announce: GLMPresentationUpdated
]

{ #category : #updating }
GLMPresentation >> updateYourselfOn: anAnnouncement from: aBlockOrSymbol [ 
	(updateAnnouncementsToBlocks at: anAnnouncement ifAbsentPut: [ OrderedCollection new] ) add: aBlockOrSymbol
	
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
	self shouldValidate ifFalse: [ ^ true ].
	^ self doValidate: anObject on: aPort.
]

{ #category : #announcements }
GLMPresentation >> when: anAnnouncementClass do: aValuable [
	^ self announcer when: anAnnouncementClass do: aValuable 
]

{ #category : #announcements }
GLMPresentation >> whenContextChanged: aBlock [
	^ self announcer when: GLMContextChanged do: aBlock
]

{ #category : #enumeration }
GLMPresentation >> withAllDo: aBlock [
	^ aBlock value: self
]
