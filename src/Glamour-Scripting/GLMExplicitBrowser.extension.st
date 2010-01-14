Extension { #name : #GLMExplicitBrowser }

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> custom: aPresentation [ 
	"this message sets a custom presentation to the current Transmission. 
	it is to be used within the using: block. 
	this message is particularly useful when you want to set a browser as a presentation" 
	 
	self lastTransmission addPresentation: aPresentation. 
	^ aPresentation
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> from: anOriginPortReference [ 
	"send this message after showOn: to specify an origin for the Transmission. 
	you can cascade several from: to specify additional origins" 
	 
	self lastTransmission 
		addActiveOrigin: (self resolveOriginPort: anOriginPortReference)
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> fromOutside: aPortName [
	 ^ self from: #outer->aPortName
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> passivelyFrom: anOriginPortReference [ 
	"passivelyForm: is similar to from: only the origin will be a passive one. 
	in other words, a change in the origin port will not initiate a Transmission" 
	 
	self lastTransmission
		addPassiveOrigin: (self resolveOriginPort: anOriginPortReference)
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> sendTo: aDesinationPortReference from: anOriginPortReference [ 
	"this message links two port references with a transmission that holds no presentation" 
	 
	self transmissions 
		addLast: 
			((GLMTransmission new) 
				addActiveOrigin: (self resolveOriginPort: anOriginPortReference); 
				destination: (self resolveDestinationPort: aDesinationPortReference); 
				yourself)
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> sendTo: aDesinationPortReference from: anOriginPortReference with: aBlock [ 
	"this message links two port references with a transmission that holds no presentation" 
	 
	self transmissions 
		addLast: 
			((GLMTransmission new) 
				addActiveOrigin: (self resolveOriginPort: anOriginPortReference); 
				destination: (self resolveDestinationPort: aDesinationPortReference); 
				transformation: aBlock; 
				yourself)
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> sendTo: aDesinationPortReference fromOutside: anOriginPortName [ 
	"this is a shortcut method for propagating inside an outer port name to an inner port reference" 
	 
	self 
		sendTo: aDesinationPortReference 
		from: #outer -> anOriginPortName
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> sendToOutside: aPortName from: anOriginPortReference [ 
	"this is a shortcut method for exposing an inner port reference as an outer port name" 
	 
	self 
		sendTo: #outer -> aPortName 
		from: anOriginPortReference
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> showOn: aDestinationPane [ 
	"send this message when at the beginning of specifying a Transmission" 
	 
	self addTransmission: (
		GLMTransmission new
			ensureBundleStrategy;
			destination: (self resolveDestinationPort: aDestinationPane); 
			yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMExplicitBrowser >> transmit [
	^ self addTransmission: (GLMTransmission new browser: self; yourself)
]

{ #category : #'*Glamour-Scripting-deprecated' }
GLMExplicitBrowser >> using: aBlock [ 
	"this message should be sent after showOn: and a sequence of from: messages. 
	the using: message takes a block as a parameter to specify the presentations that accompany the Transmission" 
	 
	aBlock value. 
	self lastTransmission origins isEmpty ifTrue: [self from: #outer->#entity]
]
