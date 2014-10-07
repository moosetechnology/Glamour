Extension { #name : #RTView }

{ #category : #'*Glamour-Roassal2-Presentations' }
RTView >> openWithToolbar [
	^ GLMCompositePresentation new 
		title: 'Roassal painting';
		with: [:composite | composite roassal2 ];
		openOn: self
]

{ #category : #'*Glamour-Roassal2-Presentations' }
RTView >> openWithToolbarEntitled: aTitle [
	^ self openWithToolbar title: aTitle
]
