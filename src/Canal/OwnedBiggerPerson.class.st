Class {
	#name : #OwnedBiggerPerson,
	#superclass : #OwnedPerson,
	#instVars : [
		'possessions',
		'birthday',
		'form'
	],
	#category : #Canal
}

{ #category : #initialization }
OwnedBiggerPerson >> initialize [

   super initialize.
	possessions := Array new: 100.
	birthday := Date today.
	form := Rectangle origin: 5@5 corner: 1@1.
	
	
	
	
]
