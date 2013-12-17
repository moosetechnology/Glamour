Extension { #name : #ROView }

{ #category : #'*glamour-roassal-presentations' }
ROView >> applyLayout [
	"Do nothing except be polymorphic with ROMondrianViewBuilder."
]

{ #category : #'*glamour-roassal-presentations' }
ROView >> newMorph [
	^ ROPlatform current hostVisualElement on: self
]

{ #category : #'*glamour-roassal-presentations' }
ROView >> onMorph: aROMorph [ 
	aROMorph setView: self.
]
