Class {
	#name : #GlamourLoader,
	#superclass : #Object,
	#category : #GlamourLoader
}

{ #category : #flair }
GlamourLoader class >> all [
	| config |
	self ensureFlairAndGofer.
	config := (Smalltalk at: #FLConfiguration) new.
	self allFor: config.
	^ config
]

{ #category : #flair }
GlamourLoader class >> allFor: config [
	config project: 'Glamour All' dependsOn: [
		config package: 'Glamour-Helpers' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Squeak' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Core' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Presentations' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Browsers' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Scripting' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Tests' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Morphic' from: 'http://www.squeaksource.com/Glamour' dependsOn: [
			config package: 'System-Settings' from: 'http://www.squeaksource.com/Pharo'].
		config package: 'Glamour-Examples' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Announcements' from: 'http://www.squeaksource.com/Glamour'.
		config allIn: 'MondrianLoader' from: 'http://www.squeaksource.com/Mondrian'
	]
]

{ #category : #flair }
GlamourLoader class >> ensureFlairAndGofer [

	Smalltalk at: #FLProject ifAbsent: [
		ScriptLoader  loadLatestPackage: 'Gofer' from: 'http://source.lukas-renggli.ch/flair'.
		ScriptLoader  loadLatestPackage: 'Flair' from: 'http://source.lukas-renggli.ch/flair'. ].
]

{ #category : #flair }
GlamourLoader class >> glamourSeaside [
	| config |
	self ensureFlairAndGofer.
	config := (Smalltalk at: #FLConfiguration) new.
	config package: 'Glamour-Seaside' from: 'http://www.squeaksource.com/Glamour'.
	^ config
]

{ #category : #flair }
GlamourLoader class >> load [
	self all load
]
