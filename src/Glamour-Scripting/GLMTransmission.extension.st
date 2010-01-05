Extension { #name : #GLMTransmission }

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPort [
	self addActiveOrigin: (self browser resolveOriginPort: aPort)
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> from: aPort transformed: aBlock [
	(self addActiveOrigin: (self browser resolveOriginPort: aPort)) transformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMTransmission >> to: aPort [
	self destination: (self browser resolveDestinationPort: aPort)
]
