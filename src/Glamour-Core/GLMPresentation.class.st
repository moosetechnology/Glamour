"
A GLMPresentation is the abstract class for the hierarchy of presentations. A presentation specifies how the pane is going to be displayed. It typically reads at least the #entity port of a pane and populates at least the #selection port.
"
Class {
	#name : #GLMPresentation,
	#superclass : #Announcer,
	#instVars : [
		'pane',
		'title',
		'titleIcon',
		'transformation',
		'actions',
		'condition',
		'isInspectable',
		'implicitNotNil',
		'postTransformation',
		'dynamicActionsBlock',
		'updateAnnouncementsToBlocks',
		'color',
		'customValidation',
		'shouldValidate'
	],
	#category : #'Glamour-Core'
}

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

{ #category : #accessing }
GLMPresentation >> beInspectable [ 
	self flag: 'reconsider this part'.
	^isInspectable := true
]

{ #category : #accessing }
GLMPresentation >> color [
	^ color
]

{ #category : #accessing }
GLMPresentation >> color: aSymbolOrColor [
	color := aSymbolOrColor
]

{ #category : #accessing }
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

{ #category : #accessing }
GLMPresentation >> customValidation [
	^ customValidation
]

{ #category : #accessing }
GLMPresentation >> customValidation: aBlock [
	customValidation := aBlock.
	shouldValidate := true.
]

{ #category : #validation }
GLMPresentation >> defaultValidate: anObject on: aPort [ 
	"by default any object is allowed in any port"
	^ true
]

{ #category : #accessing }
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
GLMPresentation >> hasTitleIcon [
	^ self titleIcon notNil
]

{ #category : #accessing }
GLMPresentation >> initialize [
	updateAnnouncementsToBlocks := Dictionary new
]

{ #category : #events }
GLMPresentation >> innerPortEvent: aPortEvent [ 
	 "Regular presentations do not have inner ports,
	  so the default behaviour is to do nothing"
]

{ #category : #accessing }
GLMPresentation >> isInspectable [ 
	 
	^isInspectable ifNil: [isInspectable := false]
]

{ #category : #testing }
GLMPresentation >> matches [ 
	^(self usesImplicitNotNil 
		ifTrue: [GLMNotNilCondition new glamourValue: self entity] 
		ifFalse: [true]) and: [(self condition glamourValue: self entity) = true]
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
	 
	^pane 
		ifNil: 
			[pane := (GLMPane in: GLMNoBrowser new) 
				addPresentation: self; 
				yourself]
]

{ #category : #accessing }
GLMPresentation >> pane: aPane [ 
	 
	pane := aPane
]

{ #category : #copying }
GLMPresentation >> postCopy [ 
	 
	super postCopy
]

{ #category : #accessing }
GLMPresentation >> postTransformation [
	"this is used for transforming the object before updating the selection"
	^ postTransformation ifNil: [postTransformation := #yourself]
]

{ #category : #updating }
GLMPresentation >> registerAnnouncements [
	self flag: 'The announcements should potentially be interested in any ports, not just in entity'.
	updateAnnouncementsToBlocks keysAndValuesDo: [ :key :value |
		value do: [ :eachValue | 
			(eachValue glamourValue: self entity) on: key do: [ :announcement | self update ]]]
]

{ #category : #rendering }
GLMPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^aRenderer renderPresentation: self
]

{ #category : #'accessing ports' }
GLMPresentation >> selection [
	^ (self pane port: #selection) value
]

{ #category : #'accessing ports' }
GLMPresentation >> selection: anObject [ 
	self flag: 'perhaps it would be better to provide 2 ports: a transformed one and a normal one'.
	(self pane port: #selection) value: (self postTransformation glamourValue: anObject)
]

{ #category : #accessing }
GLMPresentation >> selectionTransformation: anObject [ 
	postTransformation := anObject
]

{ #category : #accessing }
GLMPresentation >> shouldValidate [
	^ shouldValidate ifNil: [shouldValidate := false]
]

{ #category : #accessing }
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
	 
	^title ifNil: [title := #glamourString]
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

{ #category : #accessing }
GLMPresentation >> titleIconValue [
	^ self titleIcon notNil
		ifTrue: [ self titleIcon glamourValue: self entity ]
		ifFalse: [ self titleIcon ]
]

{ #category : #accessing }
GLMPresentation >> titleValue [
	| value |
	^ title isNil
		ifTrue: [
			value := self entity glamourString.
			value size > 16 ifTrue: [ value := (value copyFrom: 1 to: 12), ' ...' ].	
			value ]
		ifFalse: [ self title glamourValue: self entity ]
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
GLMPresentation >> update [
	self flag: 'the value of all ports should be checked now and reset to nil if they are not the right ones'.
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
GLMPresentation >> whenContextChanged: aBlock [
	^ self when: GLMContextChanged do: aBlock
]
