Class {
	#name : #GLMLoggerTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #'as yet unclassified' }
GLMLoggerTest >> testCustomInstance [
	| memoryLogger |
	self assert: GLMLogger instance == GLMLogger nullInstance.
	memoryLogger := GLMMemoryLogger new.
	GLMLogger instance: memoryLogger.
	self assert: GLMLogger instance == memoryLogger.
	GLMLogger reset.
	self assert: GLMLogger instance == GLMLogger nullInstance
]

{ #category : #'as yet unclassified' }
GLMLoggerTest >> testDefault [
	GLMLoggedObject withAllSubclassesDo: [ :each |
		self assert: each new logger == GLMLogger nullInstance ]
]
