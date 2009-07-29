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
		config package: 'Glamour-All' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Glamour-Morphic' from: 'http://www.squeaksource.com/Glamour'.
		config package: 'Announcements' from: 'http://www.squeaksource.com/Glamour'.
		self mondrianFor: config.
	]
]

{ #category : #flair }
GlamourLoader class >> ensureFlairAndGofer [

	Smalltalk at: #FLProject ifAbsent: [
		ScriptLoader  loadLatestPackage: 'Gofer' from: 'http://source.lukas-renggli.ch/flair'.
		ScriptLoader  loadLatestPackage: 'Flair' from: 'http://source.lukas-renggli.ch/flair'. ].
]

{ #category : #flair }
GlamourLoader class >> load [
	self all load
]

{ #category : #flair }
GlamourLoader class >> mondrianFor: config [
	ScriptLoader loadLatestPackage: 'MondrianLoader' from: 'http://www.squeaksource.com/Mondrian'.
	^ (Smalltalk at: #MondrianLoader) allFor: config
]
