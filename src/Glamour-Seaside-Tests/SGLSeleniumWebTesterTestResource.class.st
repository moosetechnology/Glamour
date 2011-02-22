Class {
	#name : #SGLSeleniumWebTesterTestResource,
	#superclass : #WtSeleniumWebTesterTestResource,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #running }
SGLSeleniumWebTesterTestResource >> buildWebTester [ 
	^ WtSeleniumWebTester new
		appRoot: self class defaultAppRoot;
		browserType: '*firefox'.
]
