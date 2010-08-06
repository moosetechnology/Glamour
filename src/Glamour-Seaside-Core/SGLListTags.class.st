Class {
	#name : #SGLListTags,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLListTags class >> initialize [
	self registerAsApplication: 'glamour/tags/listTags'
]

{ #category : #accessing }
SGLListTags >> browser [
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			showOnly: 10;
			tags: [:each | 
				{each even ifTrue: ['even'] ifFalse: ['odd'].
				(each\\3 == 0 ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
				(each\\4 == 0 ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
				(each\\5 == 0 ) ifTrue: ['div 5'] ifFalse: ['not div 5']}
				]].
	browser showOn: #two; from: #one; using: [
		browser text
			display: [:x | 'You have selected ', x printString ]].
	^ browser
]

{ #category : #accessing }
SGLListTags >> model [
	^ 1 to: 103
]
