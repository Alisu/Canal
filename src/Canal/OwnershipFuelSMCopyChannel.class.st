Class {
	#name : #OwnershipFuelSMCopyChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #accessing }
OwnershipFuelSMCopyChannel >> materializer [
  ^FLMaterializer
]

{ #category : #sending }
OwnershipFuelSMCopyChannel >> receive [

	| serializedObject |
	serializedObject := super receive.
	^self materializer materializeFromByteArray: serializedObject.

]

{ #category : #sending }
OwnershipFuelSMCopyChannel >> send: anObject [

	| serializedObject |
	serializedObject := self serializer serializeToByteArray: anObject.
	super send: serializedObject.
]

{ #category : #accessing }
OwnershipFuelSMCopyChannel >> serializer [
	^FLSerializer
]
