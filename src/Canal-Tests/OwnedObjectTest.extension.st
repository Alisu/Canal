Extension { #name : #OwnedObjectTest }

{ #category : #'*Canal-Tests' }
OwnedObjectTest >> testC [
	| channel objectToTransfer objectReceived |
	
	channel := OwnershipTransferWriteBarrierChannel new.
	objectToTransfer := OwnedPerson new name: 'Alice'.
	[ [ objectReceived := channel receive.
	channel send: objectReceived ] fork.
	channel send: objectToTransfer ] bench
]

{ #category : #'*Canal-Tests' }
OwnedObjectTest >> testCanModifyObjectwithOwnershipTransferByChannel [
	
	| s person canal |
	canal := OwnershipTransferWriteBarrierChannel new.
	s := Semaphore new.
	person := OwnedPerson new name: 'toto'.
	canal send: person.
	[ canal receive name: 'pipo'.
	s signal ] fork.
	s wait.
	self assert: person name equals: 'pipo'
]

{ #category : #'*Canal-Tests' }
OwnedObjectTest >> testCannotModifyObjectFieldInAnotherProcess [
	| s failed person |
	failed := false.
	s:=Semaphore new.
	person := OwnedPerson new name: 'toto'.
	[ [person name: 'pipo'] on: ModificationForbidden do: [:ex | failed := true ].
	s signal. ] fork.
	s wait.
	
	self assert: failed 
	
]

{ #category : #'*Canal-Tests' }
OwnedObjectTest >> testCannotModifyObjectWithoutOwnership [
	
	| s person canal |
	canal := OwnershipTransferWriteBarrierChannel new.
	s := Semaphore new.
	person := OwnedPerson new name: 'toto'.
	canal send: person.
	[ canal receive name: 'pipo'.
	s signal ] fork.
	s wait.
	self should: [ person name: 'titi' ] raise: ModificationForbidden.
]
