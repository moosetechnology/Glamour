Extension { #name : #WtSeleniumElement }

{ #category : #'*Glamour-Seaside-Core' }
WtSeleniumElement >> fireEvent: anEvent [
	seleniumWebTester processCommand: 'fireEvent' withParams: (Array with: self locator location with: anEvent).
	^ seleniumWebTester
]
