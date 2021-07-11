Class {
	#name : #OwnershipStonSMCopyChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #accessing }
OwnershipStonSMCopyChannel >> materializer [
  ^STON
]

{ #category : #sending }
OwnershipStonSMCopyChannel >> receive [

	| serializedObject |
	serializedObject := super receive.
	^self materializer fromString: serializedObject.

]

{ #category : #sending }
OwnershipStonSMCopyChannel >> send: anObject [

	| serializedObject |
	serializedObject := self serializer toString: anObject.
	super send: serializedObject.
]

{ #category : #accessing }
OwnershipStonSMCopyChannel >> serializer [
	^STON
]
