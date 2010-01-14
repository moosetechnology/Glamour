Extension { #name : #GLMTransmission }

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> andShow: aBlock [
	self ensureBundleStrategy.
	self origins isEmpty ifTrue: [self from: #outer->#entity].
	aBlock value: self transmissionStrategy presentations
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> ensureBundleStrategy [
	self transmissionStrategy class = GLMBundleTransmissionStrategy ifFalse: [
		self transmissionStrategy: (GLMBundleTransmissionStrategy of: self) ]
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPort [
	^ self addActiveOrigin: (self browser resolveOriginPort: aPort)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPort transformed: aBlock [
	^ (self addActiveOrigin: (self browser resolveOriginPort: aPort)) transformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> fromOutside: aPortSymbol [
	^ self from: #outer->aPortSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> to: aPort [
	^ self destination: (self browser resolveDestinationPort: aPort)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> toOutside: aPortSymbol [
	^ self to: #outer->aPortSymbol
]
