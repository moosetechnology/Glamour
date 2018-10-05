Class {
	#name : #JQUiGoogleLibrary1818,
	#superclass : #WAFileLibrary,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #updating }
JQUiGoogleLibrary1818 >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot javascript
		url: 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js'
]
