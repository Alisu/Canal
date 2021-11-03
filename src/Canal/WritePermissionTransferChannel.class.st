Class {
	#name : #WritePermissionTransferChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #receiving }
WritePermissionTransferChannel >> receive [
	| receivedObject |
	receivedObject := super receive.
	receivedObject owner: Processor activeProcess.
	^receivedObject 
	
]

{ #category : #sending }
WritePermissionTransferChannel >> send: anObject [

	anObject owner: nil.
	queue nextPut: anObject
	
]
