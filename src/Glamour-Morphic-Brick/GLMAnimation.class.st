Class {
	#name : #GLMAnimation,
	#superclass : #Object,
	#instVars : [
		'asyncTask',
		'duration',
		'animationLogic',
		'startTime',
		'fromLogic',
		'fromValue',
		'toLogic',
		'toValue',
		'currentValue',
		'animatedObject',
		'stepLogic',
		'doStep',
		'shouldStop',
		'callback'
	],
	#category : #'Glamour-Morphic-Brick-Async'
}

{ #category : #scripting }
GLMAnimation >> animate: anObject [

	self asyncTask terminate.
	animatedObject := anObject.
	
	self asyncTask
		doInBackground: [ [ self shouldStop ] whileFalse: [
				self needsStep ifTrue: [ self animationStep ] ] ];
		onCompleted: [ callback brickValue: self animatedObject ];
		priority: Processor lowestPriority;
		execute
]

{ #category : #accessing }
GLMAnimation >> animatedObject [

	^ animatedObject
]

{ #category : #scripting }
GLMAnimation >> animation: anObject [

	animationLogic := anObject
]

{ #category : #animating }
GLMAnimation >> animationStep [
	|delta stepValue currentTime stop|
	self needsStep: false.
	currentTime := Time millisecondClockValue.
	stop := currentTime > self finishTime.
	delta := self duration = 0
		ifTrue: [ 1 ]
		ifFalse: [ ((currentTime - startTime) min: self duration) / self duration ].
	
	stepValue := stepLogic
		brickValue: self animatedObject
		withEnoughArguments: { self fromValue . self toValue . delta }.
		
	UIManager default defer: [
		animationLogic brickValue: self animatedObject withEnoughArguments: { stepValue }.
		stop
			ifFalse: [ self needsStep: true ]
			ifTrue: [ self shouldStop: true ] ]
	
	
]

{ #category : #accessing }
GLMAnimation >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := GLMAsyncTask new ]
]

{ #category : #accessing }
GLMAnimation >> asyncTask: anObject [
	asyncTask := anObject
]

{ #category : #accessing }
GLMAnimation >> duration [

	^ duration ifNil: [ duration := 0 ]
]

{ #category : #scripting }
GLMAnimation >> duration: anInteger [

	duration := anInteger
]

{ #category : #accessing }
GLMAnimation >> finishTime [

	^ self startTime + self duration
]

{ #category : #scripting }
GLMAnimation >> from: anObject [

	fromLogic := anObject
]

{ #category : #accessing }
GLMAnimation >> fromValue [

	^ fromValue ifNil: [ fromValue := fromLogic brickValue: self animatedObject ]
]

{ #category : #accessing }
GLMAnimation >> needsStep [

	^ doStep ifNil: [ doStep := true ]
]

{ #category : #accessing }
GLMAnimation >> needsStep: aBoolean [

	doStep := aBoolean
]

{ #category : #scripting }
GLMAnimation >> onCompleted: aBlock [

	callback := aBlock
]

{ #category : #accessing }
GLMAnimation >> shouldStop [

	 ^ shouldStop ifNil: [ shouldStop := false ]
]

{ #category : #accessing }
GLMAnimation >> shouldStop: aBoolean [

	shouldStop := aBoolean
]

{ #category : #accessing }
GLMAnimation >> startTime [

	^ startTime ifNil: [ startTime := Time millisecondClockValue ]
]

{ #category : #scripting }
GLMAnimation >> step: anObject [

	stepLogic := anObject
]

{ #category : #actions }
GLMAnimation >> terminate [

	self asyncTask terminate
]

{ #category : #scripting }
GLMAnimation >> to: anObject [

	toLogic := anObject
]

{ #category : #accessing }
GLMAnimation >> toValue [

	^ toValue ifNil: [ toValue := toLogic brickValue: self animatedObject ]
]
