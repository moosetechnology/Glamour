Class {
	#name : #GlamourLoader,
	#superclass : #Object,
	#category : #GlamourLoader
}

{ #category : #'as yet unclassified' }
GlamourLoader class >> load [
	"self load"
	
	Installer ss 
		project: 'Glamour'; 
		install: 'Glamour-All';
		install: 'Glamour-Morphic';
		install: 'Announcements'.
	self loadMondrian.
]

{ #category : #'as yet unclassified' }
GlamourLoader class >> loadMondrian [
	"self loadMondrian"
	
	| instClass |
	instClass := self environment at: #Installer ifAbsent: [self new installingInstaller].

	(Smalltalk at: #Rio ifAbsent: [
		instClass ss project: 'Rio'; install: 'Rio-Kernel'; install: 'Rio-Grande'. ]).

	instClass ss
		project: 'Mondrian';
		install: 'Mondrian'.
]
