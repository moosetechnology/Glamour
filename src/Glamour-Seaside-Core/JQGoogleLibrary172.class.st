Class {
	#name : #JQGoogleLibrary172,
	#superclass : #WAFileLibrary,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #updating }
JQGoogleLibrary172 >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot javascript
		url: 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'
]
