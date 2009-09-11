Extension { #name : #GLMExplicitBrowser }

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> context [

	context isNil ifTrue: [context := OrderedCollection new].
	^context
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> custom: aPresentation [ 
	"this message sets a custom presentation to the current Transmission. 
	it is to be used within the using: block. 
	this message is particularly useful when you want to set a browser as a presentation" 
	 
	scriptTransmission addPresentation: aPresentation. 
	^aPresentation
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> from: anOriginPortReference [ 
	"send this message after showOn: to specify an origin for the Transmission. 
	you can cascade several from: to specify additional origins" 
	 
	scriptTransmission 
		addActiveOrigin: (self resolveOriginPort: anOriginPortReference)
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> initializeContextWith: aPane [

	context := OrderedCollection with: aPane
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> passivelyFrom: anOriginPortReference [ 
	"passivelyForm: is similar to from: only the origin will be a passive one. 
	in other words, a change in the origin port will not initiate a Transmission" 
	 
	scriptTransmission 
		addPassiveOrigin: (self resolveOriginPort: anOriginPortReference)
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> sendTo: aDesinationPortReference from: anOriginPortReference [ 
	"this message links two port references with a transmission that holds no presentation" 
	 
	self transmissions 
		addLast: 
			((GLMSimpleTransmission new) 
				origin: (self resolveOriginPort: anOriginPortReference); 
				destination: (self resolveDestinationPort: aDesinationPortReference); 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> sendTo: aDesinationPortReference from: anOriginPortReference with: aBlock [ 
	"this message links two port references with a transmission that holds no presentation" 
	 
	self transmissions 
		addLast: 
			((GLMSimpleTransformingTransmission new) 
				origin: (self resolveOriginPort: anOriginPortReference); 
				destination: (self resolveDestinationPort: aDesinationPortReference); 
				transmission: aBlock; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> sendTo: aDesinationPortReference fromOutside: anOriginPortName [ 
	"this is a shortcut method for propagating inside an outer port name to an inner port reference" 
	 
	self 
		sendTo: aDesinationPortReference 
		from: #outer -> anOriginPortName
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> sendToOutside: aPortName from: anOriginPortReference [ 
	"this is a shortcut method for exposing an inner port reference as an outer port name" 
	 
	self 
		sendTo: #outer -> aPortName 
		from: anOriginPortReference
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> showOn: aDestinationPane [ 
	"send this message when at the beginning of specifying a Transmission" 
	 
	scriptTransmission := (GLMBundleTransmission new) 
		destination: (self resolveDestinationPort: aDestinationPane); 
		yourself
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> using: aBlock [ 
	"this message should be sent after showOn: and a sequence of from: messages. 
	the using: message takes a block as a parameter to specify the presentations that accompany the Transmission" 
	 
	aBlock value. 
	scriptTransmission origins isEmpty 
		ifTrue: [self addJumpstart: scriptTransmission] 
		ifFalse: [self addTransmission: scriptTransmission]. 
	scriptTransmission := nil
]
