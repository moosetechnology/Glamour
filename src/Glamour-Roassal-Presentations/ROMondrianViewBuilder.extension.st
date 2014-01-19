Extension { #name : #ROMondrianViewBuilder }

{ #category : #'*glamour-roassal-presentations' }
ROMondrianViewBuilder >> asBrowserWithStatusbar [
	| browser |
	browser := GLMWrapper withStatusbar.
	browser title: 'Roassal painting'.
	browser show: [ :a | a roassal view: self ].
	^ browser
]

{ #category : #'*glamour-roassal-presentations' }
ROMondrianViewBuilder >> newMorph [
	^ ROPlatform current hostVisualElement on: self raw. 
]

{ #category : #'*glamour-roassal-presentations' }
ROMondrianViewBuilder >> onMorph: aROMorph [ 
	aROMorph setView: self raw
]

{ #category : #'*glamour-roassal-presentations' }
ROMondrianViewBuilder >> openWithStatusbar [
	^ self asBrowserWithStatusbar openOn: self
]
