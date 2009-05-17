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
	
	Installer ss 
		project: 'Glamour'; 
		install: 'Glamour-All';
		install: 'Glamour-Morphic';
		install: 'Announcements'.
]

{ #category : #'as yet unclassified' }
GlamourLoader class >> loadMondrian [
	"self loadMondrian"
	
	Installer ss
		project: 'Mondrian';
		install: 'MondrianLoader'.
	
	(Smalltalk at: #MondrianLoader) load.
]
