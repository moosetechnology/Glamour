Class {
	#name : #GlamourLoader,
	#superclass : #Object,
	#category : #GlamourLoader
}

{ #category : #flair }
GlamourLoader class >> all [
	| project |
	self ensureFlairAndGofer.

	project := FLProject named: 'Glamour All'.
	project dependsOn: (FLPackage named: 'Glamour-All' in: 'http://www.squeaksource.com/Glamour').
	project dependsOn: (FLPackage named: 'Glamour-Morphic' in: 'http://www.squeaksource.com/Glamour').
	project dependsOn: (FLPackage named: 'Annuncements' in: 'http://www.squeaksource.com/Glamour').
	project dependsOn: self mondrian.
	^ project
]

{ #category : #flair }
GlamourLoader class >> ensureFlairAndGofer [

	Smalltalk at: #FLProject ifAbsent: [
		ScriptLoader  loadLatestPackage: 'Gofer' from: 'http://source.lukas-renggli.ch/flair'.
		ScriptLoader  loadLatestPackage: 'Flair' from: 'http://source.lukas-renggli.ch/flair'. ].
]

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

{ #category : #flair }
GlamourLoader class >> mondrian [
	
	ScriptLoader loadLatestPackage: 'MondrianLoader' from: 'http://www.squeaksource.com/Mondrian'.
	^ (Smalltalk at: #MondrianLoader) all
]
