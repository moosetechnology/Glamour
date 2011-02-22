Extension { #name : #WtSeleniumElement }

{ #category : #'*Glamour-Seaside-Tests' }
WtSeleniumElement >> fireEvent: anEvent [
	seleniumWebTester processCommand: 'fireEvent' withParams: (Array with: self locator location with: anEvent).
	^ seleniumWebTester
]
