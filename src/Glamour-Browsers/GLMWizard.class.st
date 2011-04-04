Class {
	#name : #GLMWizard,
	#superclass : #GLMImplicitBrowser,
	#instVars : [
		'wizardSize',
		'steps',
		'genericStep',
		'currentIndex',
		'terminateButtonAction',
		'previousButtonAction',
		'nextButtonAction',
		'cancelButtonAction',
		'specificAnnouncementActions',
		'externalCancelButtonAction',
		'externalNextButtonAction',
		'externalPreviousButtonAction',
		'externalTerminateButtonAction'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #examples }
GLMWizard class >> simpleExample [

	"self simpleExample"
	| wizard |
	wizard := GLMWizard new.
	wizard size: 1.
	wizard genericStep: [:a | GLMTextPresentation new ].
	wizard openOn: (1 to: 100).

]

{ #category : #'building internal' }
GLMWizard >> backSign [
	^ '<< Back'
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> cancelButtonAction [

	self externalCancelButtonAction value: self entity.
	self announce: (GLMBrowserClosed new)		
]

{ #category : #'building internal' }
GLMWizard >> computeFirstPaneValidator [

	|tmpValidator|
	tmpValidator := self computePaneValidator.
	self setFirstPaneButtonsTo: tmpValidator.
	^ tmpValidator  

]

{ #category : #'building internal' }
GLMWizard >> computeLastPaneValidator [

	|tmpValidator|
	tmpValidator := self computePaneValidator.
	self setLastPaneButtonsTo: tmpValidator.
	^ tmpValidator  

]

{ #category : #'building internal' }
GLMWizard >> computeMiddlePaneValidator [

	|tmpValidator|
	tmpValidator := self computePaneValidator.
	self setMiddlePaneButtonsTo: tmpValidator.
	^ tmpValidator  

]

{ #category : #'building pane' }
GLMWizard >> computePane [

	self currentIndex > 1
		ifTrue: [
			self currentIndex < (self valueOf: self size)
				ifTrue: [
					^( self computePaneWith: self computeMiddlePaneValidator)
					]
				ifFalse: [
					^ self computePaneWith: self computeLastPaneValidator 
					] 
			]
		ifFalse: [
			(self valueOf: self size) > 1
				ifTrue: [
					^ self computePaneWith: self computeFirstPaneValidator
					]
				ifFalse: [
					^ self computePaneWith: self computeSinglePaneValidator
					]
			]
]

{ #category : #'building internal' }
GLMWizard >> computePaneValidator [

	|tmpPresentation tmpValidator|
	tmpPresentation := (self stepToUse moValue: self).
	tmpValidator := GLMValidator new.
	tmpValidator show: [:a | a custom: tmpPresentation]. 
	tmpValidator startOn: self entity.
	^ tmpValidator 

]

{ #category : #'building pane' }
GLMWizard >> computePaneWith: aValidator [

	|tmpPane|
	tmpPane := GLMPane in: self.
	tmpPane addPresentation: aValidator.
	
	(tmpPane port: #entity) value:  (self pane port: #entity) value.
	tmpPane presentations presentations do: [:aPresentation |
		(aPresentation pane port: #entity) value: (self pane port: #entity) value
		].
	self title: self stepToUseName.
	^ tmpPane 
	
]

{ #category : #'building internal' }
GLMWizard >> computeSinglePaneValidator [

	|tmpValidator|
	tmpValidator := self computePaneValidator.
	self setSinglePaneButtonsTo: tmpValidator.
	^ tmpValidator  

]

{ #category : #accessing }
GLMWizard >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
GLMWizard >> currentIndex: anInteger [

	currentIndex := anInteger
]

{ #category : #'accessing ports' }
GLMWizard >> entity: anObject [

	super entity: anObject.
	self initializeWizard
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalCancelButtonAction [

	^ externalCancelButtonAction ifNil: [externalCancelButtonAction := [:input | ]]
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalCancelButtonAction: aBlock [

	externalCancelButtonAction := aBlock
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalNextButtonAction [

	^ externalNextButtonAction ifNil: [externalNextButtonAction := [:input | ]]
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalNextButtonAction: aBlock [

	externalNextButtonAction := aBlock 
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalPreviousButtonAction [

	^ externalPreviousButtonAction ifNil: [externalPreviousButtonAction := [:input | ]]
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalPreviousButtonAction: aBlock [

	externalPreviousButtonAction := aBlock
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalTerminateButtonAction [

	^ externalTerminateButtonAction ifNil: [externalTerminateButtonAction := [:input | ]]
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> externalTerminateButtonAction: aBlock [

	externalTerminateButtonAction := aBlock
]

{ #category : #'building internal' }
GLMWizard >> forwardSign [
	^ 'Next >>'
]

{ #category : #accessing }
GLMWizard >> genericStep [

	^ genericStep
]

{ #category : #accessing }
GLMWizard >> genericStep: aBlock [

	"add a unique step that will be used each time we want to open a new pane"

	genericStep := '' -> aBlock 
]

{ #category : #accessing }
GLMWizard >> genericStep: aBlock named: anotherBlock [

	"add a unique step that will be used each time we want to open a new pane. the name of the each pane will also be computed each time using anotherBlock"

	genericStep := anotherBlock -> aBlock 
]

{ #category : #'initialize-release' }
GLMWizard >> initialize [

	super initialize.
	scriptTransmission := GLMTransmission new.
]

{ #category : #'building pane' }
GLMWizard >> initializeWizard [

	self currentIndex: 1.
	self setAsCurrentPane: self computePane  
]

{ #category : #events }
GLMWizard >> innerPortEvent: aPortEvent [ 

	aPortEvent portName = #entity ifTrue: [
		
		]
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> nextButtonAction [

		self externalNextButtonAction value: self entity.
		self updateWhenNext 
]

{ #category : #'building pane' }
GLMWizard >> notifyAndSetAsCurrentPane: aGLMPane [

	|oldPane|
	oldPane := self panes anyOne.
	self setAsCurrentPane: aGLMPane.  
	self announce: (GLMPaneReplaced 
							oldPane: oldPane 
							newPane: self panes anyOne
							fromBrowser: self ) 
	
]

{ #category : #announcements }
GLMWizard >> on: anAnnouncementClass send: aSelector [

	self specificAnnouncementActions at: anAnnouncementClass  put: aSelector 
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> onCancelDo: aBlock [

	self externalCancelButtonAction: aBlock
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> onNextDo: aBlock [

	self externalNextButtonAction: aBlock
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> onPreviousDo: aBlock [

	self externalPreviousButtonAction: aBlock
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> onTerminateDo: aBlock [

	self externalTerminateButtonAction: aBlock
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> previousButtonAction [

		self externalPreviousButtonAction value: self entity.
		self updateWhenPrevious
		
]

{ #category : #rendering }
GLMWizard >> renderGlamorouslyOn: aRenderer [ 
 
	self on: GLMBrowserClosed send: #actOnWizardClosed: to: aRenderer.
	^ aRenderer renderWizard: self
]

{ #category : #'building pane' }
GLMWizard >> setAsCurrentPane: aGLMPane [

	self removeAllPanes.
	self panes add: aGLMPane.
	"GLMTransmission new
		ensureBundleStrategy;
		addActiveOrigin: (self pane port: #entity); 
		destination: (aGLMPane port: #entity); 
		transmit."
	self title: self stepToUseName 
	
]

{ #category : #'building internal' }
GLMWizard >> setFirstPaneButtonsTo: aValidator [

	aValidator validator: 'Cancel' act:  [:input |
		self cancelButtonAction
		] .
	aValidator validator: self forwardSign act: [:input |
		self nextButtonAction 
		] populatePorts: #(#selection).
]

{ #category : #'building internal' }
GLMWizard >> setLastPaneButtonsTo: aValidator [

	aValidator validator:  'Cancel' act:  [:input |
		self cancelButtonAction
		].
	aValidator validator: self backSign act: [:input |
		self previousButtonAction
		].
	aValidator validator: 'Terminate' act:  [:input |
		self terminateButtonAction
		].
]

{ #category : #'building internal' }
GLMWizard >> setMiddlePaneButtonsTo: aValidator [

	aValidator validator: 'Cancel' act: [:input |
		self cancelButtonAction 
		].
	aValidator validator: self backSign act: [:input |
		self previousButtonAction
		].
	aValidator validator: self forwardSign act: [:input |
		self nextButtonAction
		].
	
]

{ #category : #'building internal' }
GLMWizard >> setSinglePaneButtonsTo: aValidator [

	aValidator validator: 'Cancel' act: [:input |
		self cancelButtonAction
		].
	aValidator validator: 'Terminate' act: [:input |
		self terminateButtonAction
		].
	
]

{ #category : #announcements }
GLMWizard >> setSpecificAnnouncementActionsTo: aRenderer [

	self specificAnnouncementActions keysAndValuesDo: [:anAnnouncementClass :aSymbol |
		self on: anAnnouncementClass send: aSymbol to: aRenderer.
		]
]

{ #category : #accessing }
GLMWizard >> size [

	^ wizardSize
]

{ #category : #accessing }
GLMWizard >> size: aBlockOrAnInteger [

	"enable the user to specify the size of a wizard with aBlock. As the size of the wizard might change after opening it, we need to be able to ckeck this size each time we open a pane, to know if it's the last one"
	wizardSize := aBlockOrAnInteger
]

{ #category : #announcements }
GLMWizard >> specificAnnouncementActions [

	^ specificAnnouncementActions ifNil: [specificAnnouncementActions := Dictionary new]
]

{ #category : #accessing }
GLMWizard >> step: aBlock [

	self steps add: '' -> aBlock.
]

{ #category : #accessing }
GLMWizard >> step: aBlock named: aString [

	self steps add: aString -> aBlock.
]

{ #category : #private }
GLMWizard >> stepToUse [

	self genericStep ifNil: [
		^ (self steps at: self currentIndex) value
		].
	^ self genericStep value 
]

{ #category : #private }
GLMWizard >> stepToUseName [

	self genericStep ifNil: [
		^ (self steps at: self currentIndex) key
		].
	^ (self valueOf: self genericStep key) 
]

{ #category : #accessing }
GLMWizard >> steps [

	^ steps ifNil: [steps := OrderedCollection new]
]

{ #category : #'accessing - buttons actions ' }
GLMWizard >> terminateButtonAction [

	self externalTerminateButtonAction value: self entity.
	self announce: (GLMBrowserClosed new)
		
]

{ #category : #'building pane' }
GLMWizard >> updatePane [

	|tmpPane|
	self notifyAndSetAsCurrentPane: self computePane.
]

{ #category : #'building pane' }
GLMWizard >> updateWhenNext [

	|tmpPane|
	self currentIndex: self currentIndex + 1.
	self notifyAndSetAsCurrentPane: self computePane.
]

{ #category : #'building pane' }
GLMWizard >> updateWhenPrevious [

	|tmpPane|
	self currentIndex: self currentIndex - 1.
	self notifyAndSetAsCurrentPane: self computePane.
]

{ #category : #private }
GLMWizard >> valueOf: anObject [

	^ anObject moValue: (self pane port: #entity) value
]
