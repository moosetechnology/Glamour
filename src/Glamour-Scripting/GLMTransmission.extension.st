Extension { #name : #GLMTransmission }

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> andShow: aBlock [
	self ensureBundleStrategy.
	self origins isEmpty ifTrue: [self from: #outer->#entity].
	aBlock value: self transmissionStrategy presentations
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> andShowIfNone: aBlock [
	self ensureNoOverrideBundleStrategy.
	self origins isEmpty ifTrue: [self from: #outer->#entity].
	aBlock value: self transmissionStrategy presentations
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> andShowWithoutOverride: aBlock [
	self deprecated: 'Please use andShowIfNone: instead'.
	^ self andShowIfNone: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPort [
	"Ideally this method would be implemented as
	^ self from: aPaneSymbol port: #selection.
	
	The problem is that beforehand we only had from: which could receive either a symbol for the pane, or an association for the port. This was bad, and now Glamour offers from:port:, but there are still legacy cases of from: being called with an association."

	^ self addActiveOrigin: (self browser resolveOriginPort: aPort)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPaneSymbol port: aPortSymbol [
	^ self from: (GLMPortIdentifier pane: aPaneSymbol port: aPortSymbol)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPaneSymbol port: aPortSymbol transformed: aBlock [
	^ (self from: (GLMPortIdentifier pane: aPaneSymbol port: aPortSymbol)) transformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPort transformed: aBlock [
	^ (self addActiveOrigin: (self browser resolveOriginPort: aPort)) transformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> fromOutside: aPortSymbol [
	^ self fromOutsidePort: aPortSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> fromOutsidePort: aPortSymbol [
	^ self from: #outer->aPortSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> passivelyFrom: aPort [
	^ self addPassiveOrigin: (self browser resolveOriginPort: aPort)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> to: aPort [
	"Ideally this method would be implemented as
	^ self to: aPaneSymbol port: #entiity.
	
	The problem is that beforehand we only had from: which could receive either a symbol for the pane, or an association for the port. This was bad, and now Glamour offers to:port:, but there are still legacy cases of to: being called with an association."

	^ self destination: (self browser resolveDestinationPort: aPort)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> to: aPaneSymbol port: aPortSymbol [
	^ self to: (GLMPortIdentifier pane: aPaneSymbol port: aPortSymbol)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> toOutside: aPortSymbol [
	^ self toOutsidePort: aPortSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> toOutsidePort: aPortSymbol [
	^ self to: #outer->aPortSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> transformed: aBlock [
	self transformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> when: aBlock [
	self condition: aBlock
]
