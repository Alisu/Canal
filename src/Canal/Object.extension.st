Extension { #name : #Object }

{ #category : #'*Canal' }
Object >> ownership [
	| hiddenDictionary |
	hiddenDictionary := Object >> #ownership
		propertyAt: #ownership.
	hiddenDictionary
		ifNotNil: [ ^ hiddenDictionary at: self ]
		ifNil: [ ^ nil ]
]

{ #category : #'*Canal' }
Object >> ownership: anObject [
	| hiddenDictionary |
	hiddenDictionary := Object >> #ownership
		propertyAt: #ownership
		ifAbsentPut: [ IdentityDictionary new ].
	hiddenDictionary at: self put: anObject
]
