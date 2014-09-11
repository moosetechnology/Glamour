Class {
	#name : #GLMRubricPersonColorizer,
	#superclass : #PPCompositeParser,
	#instVars : [
		'person',
		'identifier',
		'attribute',
		'attributeValue',
		'registry',
		'blanks',
		'attributeList',
		'personKW'
	],
	#category : #'Glamour-Rubric-Presentations-Examples'
}

{ #category : #example }
GLMRubricPersonColorizer class >> parseAndShowInAWorkspace [
	" self parseAndShowInAWorkspace "

	| w s t |
	w := Workspace new.
	w toggleStylingActive.
	s := '	
person {
	name = ''yoyo the boss'';
	age = ''34'';
} 
person {}
'.
	t := GLMRubricPersonColorizer parse: s.
	w acceptContents: t.
	w open
]

{ #category : #productions }
GLMRubricPersonColorizer >> attribute [
	^ (blanks, identifier , blanks , $= asParser , blanks , attributeValue , blanks , $; asParser, blanks)
		==> [ :arr | arr first, arr second asText allBold , arr third , arr fourth asText , arr fifth , arr sixth , arr seventh , arr eighth, arr ninth ]
]

{ #category : #productions }
GLMRubricPersonColorizer >> attributeList [
	^ attribute star
		==> [ :arr | 
			| t |
			t := Text new.
			arr do: [ :e | t := t , e ].
			t ]
]

{ #category : #productions }
GLMRubricPersonColorizer >> attributeValue [
	^ ($' asParser , ('''''' asParser / $' asParser negate) star token , $' asParser ==> #second) flatten ==>[ :s | s asText makeAllColor: Color green muchDarker ]
]

{ #category : #productions }
GLMRubricPersonColorizer >> blanks [
	^ ((Character space asParser / Character cr asParser / Character tab asParser / Character lf asParser) star) flatten ==> [ :s | s asText ]
]

{ #category : #productions }
GLMRubricPersonColorizer >> identifier [
	^ (#letter asParser , #word asParser star) flatten
]

{ #category : #productions }
GLMRubricPersonColorizer >> person [
	^ (blanks, personKW , blanks , ${ asParser , blanks , attributeList , blanks , $} asParser , blanks)
		==> [ :arr | 
			| t |
			t := Text new.
			arr do: [ :e | t := t , e ].
			t]
]

{ #category : #productions }
GLMRubricPersonColorizer >> personKW [
	^ 'person' asParser ==> [ :t | t asText makeAllColor: Color blue ]
]

{ #category : #productions }
GLMRubricPersonColorizer >> registry [
	^ person star
		==> [ :arr | 
			| t |
			t := Text new.
			arr do: [ :e | t := t , e ].
			t ]
]

{ #category : #productions }
GLMRubricPersonColorizer >> start [
	^  registry end
]
