Extension { #name : #WtSeleniumWebTester }

{ #category : #'*Glamour-Seaside-Core' }
WtSeleniumWebTester >> getEval: aScript [
	self processCommand: 'getEval' withParams: (Array with: aScript).
]
