Class {
	#name : #ChannelExample,
	#superclass : #Object,
	#category : #'Canal-Example'
}

{ #category : #'as yet unclassified' }
ChannelExample >> exampleIdentityProblem [

	| channel objectToTransfer objectReceived |
	channel := OwnershipCopyChannel new.
	objectToTransfer := OwnedPerson new name: 'Alice'.
	[ objectReceived := channel receive.
	channel send: objectReceived ] fork.
	channel send: objectToTransfer.
	objectToTransfer = objectReceived	"false"
]

{ #category : #'as yet unclassified' }
ChannelExample >> exampleReferencedObject [

| channel objectToTransfer referencedObject objectReceived |
channel := OwnershipTransferWriteBarrierChannel new.

objectToTransfer := OwnedPerson new name: 'Alice'.
referencedObject := PersonJob new name: 'policeman'.
objectToTransfer job: referencedObject.

[objectReceived := channel receive.
	objectReceived job name: 'firefighter'.
	] fork.

channel send: objectToTransfer.
objectToTransfer job name: 'public officer'. "should not be allowed but it is"
]
