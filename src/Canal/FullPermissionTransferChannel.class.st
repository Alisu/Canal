Class {
	#name : #FullPermissionTransferChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #receiving }
FullPermissionTransferChannel >> receive [
	| receivedObject |
	receivedObject := super receive.
	receivedObject owner: Processor activeProcess.
	^receivedObject 
]

{ #category : #sending }
FullPermissionTransferChannel >> send: anObject [ 
	
	| objectToSend |
	objectToSend := Object new.
	anObject owner: nil.
	anObject become: objectToSend.
	queue nextPut: objectToSend
]
