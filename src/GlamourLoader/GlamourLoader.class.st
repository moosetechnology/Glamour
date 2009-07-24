Class {
	#name : #GlamourLoader,
	#superclass : #Object,
	#category : #GlamourLoader
}

{ #category : #'as yet unclassified' }
GlamourLoader class >> load [
	"self load"
	
	self loadGlamourForMorphic.
	self loadMondrian.
]

{ #category : #'as yet unclassified' }
GlamourLoader class >> loadGlamourForMorphic [
	"self loadGlamourForMorphic"
	
	ScriptLoader new installer ss 
		project: 'Glamour'; 
		install: 'Glamour-All';
		install: 'Glamour-Morphic';
		install: 'Announcements'.
]

{ #category : #'as yet unclassified' }
GlamourLoader class >> loadMondrian [
	"self loadMondrian"
	
	ScriptLoader new installer ss
		project: 'Mondrian';
		install: 'MondrianLoader'.
	
	(Smalltalk at: #MondrianLoader) load.
]
