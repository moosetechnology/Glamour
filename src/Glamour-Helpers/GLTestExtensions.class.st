Class {
	#name : #GLTestExtensions,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLTestExtensions >> testGlamourValue [
	"Block closure"
	
	self assert: ([#foo] glamourValue: #(1 2)) = #foo.
	self
		assert: ([:first | Array with: first] glamourValue: #(1 2)) = #(#(1 2)).
	self
		assert:
			([:first :second | Array with: first with: second] glamourValue: #(1 2)) =
					#(#(1 2) nil).
	self
		assert:
			([:first :second | Array with: first with: second]
				glamourValue: (GLMultiValue with: 1 with: 2)) = #(1 2).	"Symbol"
	self assert: (#yourself glamourValueWithArgs: #(1 2)) = 1.
	self assert: (#yourself glamourValueWithArgs: #()) = nil	"self assert: (#yourself glamourValue: (MultiValue with: 1 with: 2)) = 1."
]

{ #category : #tests }
GLTestExtensions >> testGlamourValueWithArgs [
	"Block closure"
	
	self assert: ([#foo] glamourValueWithArgs: #(1 2)) = #foo.
	self
		assert:
			([:first | Array with: first] glamourValueWithArgs: #(1 2)) = #(1).
	self
		assert:
			([:first :second | Array with: first with: second] glamourValueWithArgs:
					#(1 2)) = #(1 2).
	self
		assert:
			([:first :second :third | Array with: first with: second with: third]
				glamourValueWithArgs: #(1 2)) = #(1 2 nil).	"Symbol"
	self assert: (#yourself glamourValueWithArgs: #(1 2)) = 1.
	self assert: (#yourself glamourValueWithArgs: #()) = nil
]
