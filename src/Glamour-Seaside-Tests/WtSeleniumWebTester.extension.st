Extension { #name : #WtSeleniumWebTester }

{ #category : #'*Glamour-Seaside-Tests' }
WtSeleniumWebTester >> getEval: aScript [
	self processCommand: 'getEval' withParams: (Array with: aScript).
]
