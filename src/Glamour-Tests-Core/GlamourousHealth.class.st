Class {
	#name : #GlamourousHealth,
	#superclass : #Object,
	#instVars : [
		'progressBarSize',
		'progress',
		'progressBarCurrentValue'
	],
	#category : #'Glamour-Tests-Core'
}

{ #category : #utilities }
GlamourousHealth class >> produceReport [
	^ self new produceReport
]

{ #category : #'progress bar' }
GlamourousHealth >> displayProgressBar: aBlock size: size titled: title [

	progressBarCurrentValue := 1.
	title
		displayProgressAt: Display center
		from: 0 to: size
		during: [:bar | aBlock value: bar ]

]

{ #category : #'progress bar' }
GlamourousHealth >> incrProgressBar: bar [
	progressBarCurrentValue :=  progressBarCurrentValue + 1.
	bar value: progressBarCurrentValue.

]

{ #category : #logging }
GlamourousHealth >> log: object named: title [
	| selectorName source newSource |
	selectorName := (#log, title) asSymbol.
	(self class includesSelector: selectorName)
		ifFalse: [ self class compile: selectorName, String cr, String cr, '	^ #()', String cr.
					  self class organization classify: selectorName under: 'logging'].

	source := (self class >> selectorName) getSourceFromFile.
	newSource := source , '	,#(#(', object printString, ' ''', title, '''))'.
	self class compile: newSource.
]

{ #category : #logging }
GlamourousHealth >> logMethodCoverage [

	^ #()
	,#(#(0 'MethodCoverage'))	,#(#(86.0 'MethodCoverage'))	,#(#(86.0 'MethodCoverage'))	,#(#(84.31 'MethodCoverage'))	,#(#(84.31 'MethodCoverage'))	,#(#(84.31 'MethodCoverage'))	,#(#(83.49 'MethodCoverage'))	,#(#(83.49 'MethodCoverage'))	,#(#(83.49 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(80.37 'MethodCoverage'))	,#(#(77.47 'MethodCoverage'))	,#(#(76.78 'MethodCoverage'))	,#(#(76.78 'MethodCoverage'))	,#(#(76.78 'MethodCoverage'))	,#(#(76.99 'MethodCoverage'))	,#(#(76.99 'MethodCoverage'))	,#(#(76.31 'MethodCoverage'))	,#(#(76.31 'MethodCoverage'))	,#(#(76.31 'MethodCoverage'))	,#(#(76.31 'MethodCoverage'))	,#(#(76.31 'MethodCoverage'))	,#(#(76.31 'MethodCoverage'))	,#(#(0.0 'MethodCoverage'))	,#(#(0.0 'MethodCoverage'))	,#(#(33.07 'MethodCoverage'))	,#(#(33.02 'MethodCoverage'))	,#(#(33.02 'MethodCoverage'))	,#(#(32.98 'MethodCoverage'))	,#(#(32.98 'MethodCoverage'))	,#(#(33.46 'MethodCoverage'))	,#(#(33.46 'MethodCoverage'))
]

{ #category : #util }
GlamourousHealth >> openMondrianGraphOn: associations titled: titleAsString [

	^ self openMondrianGraphOn: associations titled: titleAsString scaleX: 0.10
]

{ #category : #util }
GlamourousHealth >> openMondrianGraphOn: associations titled: titleAsString scaleX: scaleXFactor [

	| view |
	view := MOViewRenderer new.


	view node: #foo forIt: [
		view layout: (MOScatterplotLayout new x: #key; y: #value; scaleFactorX: scaleXFactor; scaleFactorY: 0.10 "; upSideDown").
		view interaction popupText: [:element | element key printString, ' nodes => ', element value printString, ' ms' ].
		view nodes: associations.
	
	].
	view open
]

{ #category : #util }
GlamourousHealth >> openWorkspaceWith: stream [
	Workspace new contents: (stream contents); openLabel: 'Glamour health report'.
]

{ #category : #public }
GlamourousHealth >> produceReport [
	"
	self new produceReport
	"
	| stream |
	stream := WriteStream on: String new.
	self writeGeneralInfoOn: stream.
	self writeOpeningMeasurementsOn: stream.
	self writeSelectionMeasurementsOn: stream.
	self writeSelectionInFinderMeasurementsOn: stream.
	self writeCoverageInfoOn: stream.
	
	self openWorkspaceWith: stream.

]

{ #category : #public }
GlamourousHealth >> viewTestCoverage [
	"
	GlamourousHealth new viewTestCoverage
	"
	| typeClass coverage |
	typeClass := Smalltalk 
		at: #CoveragePackageSpy
		ifAbsent: 
			[ self inform: 'The coverage is realized by the tool Spy. Please download it from www.squeaksource.com/Spy.html . Skip the coverage by pressing OK'.
			^ self ].
	coverage := typeClass forPackagesMatching: 'Glamour*'.
	coverage viewBasic
]

{ #category : #'report producers' }
GlamourousHealth >> writeCoverageInfoOn: stream [ 
	| typeClass ratioCoveredMethods lastCoverage diff diffAsString |
	typeClass := Smalltalk 
		at: #CoveragePackageSpy
		ifAbsent: 
			[ self inform: 'The coverage is realized by the tool Spy. Please download it from www.squeaksource.com/Spy.html . Skip the coverage by pressing OK'.
			^ self ].
	self 
		displayProgressBar: 
			[ :bar | 
			ratioCoveredMethods := (typeClass 
				forPackagesMatching: 'Glamour*'
				atEachTestEvaluate: [ self incrProgressBar: bar ]) ratioCoveredMethods ]
		size: (typeClass numberOfTestUnitClassesInPackagesMatching: 'Glamour*')
		titled: 'Running test for coverage'.
	stream
		nextPutAll: ratioCoveredMethods printString , '  % of methods are covered';
		cr.
	lastCoverage := self logMethodCoverage last first.
	diff := ratioCoveredMethods - lastCoverage.
	diff := ((diff * 100) asInteger / 100) asFloat.
	diffAsString := diff > 0 
		ifTrue: [ '+' , diff printString ]
		ifFalse: [ diff printString ].
	stream nextPutAll: 'Progress from last time: ' , diffAsString , ' %'.
	stream cr.
	self 
		log: ratioCoveredMethods
		named: 'MethodCoverage'
]

{ #category : #util }
GlamourousHealth >> writeDelimitationOn: stream [
	stream nextPutAll: '------------------'; cr
]

{ #category : #'report producers' }
GlamourousHealth >> writeGeneralInfoOn: stream [
	stream nextPutAll: 'Report produced on ', DateAndTime now printString; cr.
	MCWorkingCopy allManagers detect: [:m | m package name beginsWith: 'Glamour-Tests' ].
]

{ #category : #'report producers' }
GlamourousHealth >> writeOpeningMeasurementsOn: stream [
	| res |
	self writeDelimitationOn: stream.
	stream nextPutAll: 'Opening Browser Benchmark:'; cr.

	self displayProgressBar: [:bar | 
		res := GlamourousBenchmark new measureOpeningTime.
		stream nextPutAll: res first printString, ' openings => ', res second printString, ' ms'; cr.
		self incrProgressBar: bar.
		]
		size: 1
		titled: 'Opening'.
	
	self writeDelimitationOn: stream.
	stream cr.
]

{ #category : #'report producers' }
GlamourousHealth >> writeSelectionInFinderMeasurementsOn: stream [
	| res browserSizes bench associations title |
	browserSizes := #(1 5 10 15 20 25 30 35 40 45 50).
	self writeDelimitationOn: stream.

	title := 'Selecting in finder item Benchmark'.
	stream nextPutAll: title; cr.

	associations := OrderedCollection new.
	bench := GlamourousBenchmark new.
	
	self 
		displayProgressBar:
			[:bar | 
				browserSizes do: [: size |
					res := bench 	measureSelectionTimeInFinderForSize: size.
					stream nextPutAll: res first printString, ' size and selections => ', 
											res second printString, ' ms'; cr.
					associations add: (res first -> res second).
					self incrProgressBar: bar.
			]]
		size: browserSizes size 
		titled: title.
	

	self openMondrianGraphOn: associations titled: title scaleX: 1.0.
	
	
	self writeDelimitationOn: stream.
	stream cr.
]

{ #category : #'report producers' }
GlamourousHealth >> writeSelectionMeasurementsOn: stream [
	| res browserSizes bench associations title |
	browserSizes := #(100 200 300 400 500 600 700 800 900 1000 1500 2000).
	self writeDelimitationOn: stream.

	title := 'Selecting Item in Browser Benchmark'.
	stream nextPutAll: title; cr.

	associations := OrderedCollection new.
	bench := GlamourousBenchmark new.
	self 
		displayProgressBar:
			[:bar | 
				browserSizes do: [: size |
					res := bench measureSelectionTimeForSize: size.
					stream nextPutAll: res first printString, ' size and selections => ', 
										res second printString, ' ms'; cr.
					associations add: (res first -> res second).
					self incrProgressBar: bar.
			]]
		size: browserSizes size
		titled: title.

	self openMondrianGraphOn: associations titled: title.	
	self writeDelimitationOn: stream.
	stream cr.
]
