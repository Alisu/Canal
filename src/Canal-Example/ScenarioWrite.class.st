Class {
	#name : #ScenarioWrite,
	#superclass : #Object,
	#category : #'Canal-Example'
}

{ #category : #'as yet unclassified' }
ScenarioWrite >> parserAndVisitorInSameProcess [

| channelForFiles files channelForResult refactorResult |
channelForFiles := OwnershipTransferWriteBarrierChannel new.
channelForResult := OwnershipTransferWriteBarrierChannel new.

5 timesRepeat: [
	[ |visitor| 
		visitor := PTCVisitor2CCallAdapter new.
		visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
		[true] whileTrue:[|file| file:= channelForFiles receive.
			file ifNil:[Processor activeProcess terminate].
			file fullName
				=
					'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
				ifFalse: [ 
					visitor aStream: String new writeStream.					
					visitor visit: (TheoCParser2 parse: file contents).
					channelForResult send: visitor aStream contents  ]
			]
		] fork].

files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].

files do: [:f | channelForFiles send: f ].

refactorResult := OrderedCollection new.
	[refactorResult size = (files size - 1)] whileFalse: [ |toAdd|
		toAdd:= channelForResult receive.
		toAdd 
			ifNotNil:[refactorResult addLast: toAdd.]
			ifNil:[self error: 'Théo du future, corrige moi.']
	 ].

	^refactorResult
]

{ #category : #'as yet unclassified' }
ScenarioWrite >> parserAndVisitorInTwoProcess [
	| channelForFiles files channelForResult channelForAST refactorResult |
	
	channelForFiles := OwnershipTransferWriteBarrierChannel new.
	channelForAST := OwnershipTransferWriteBarrierChannel new.
	channelForResult := OwnershipTransferWriteBarrierChannel new.
	
	5 timesRepeat: [ [ [ true ]
				whileTrue: [ | file |
					file := channelForFiles receive.
					file ifNil: [ Processor activeProcess terminate ].
					file fullName
						=
							'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
						ifFalse:
							[ channelForAST send: (TheoCParser2 parse: file contents) ] ] ]
				fork ].
	
	5 timesRepeat: [ [ | visitor |
			visitor := PTCVisitor2CCallAdapter new.
			visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
			[ true ]
				whileTrue: [ | ast |
					ast := channelForAST receive.
					ast ifNil: [ Processor activeProcess terminate ].
					visitor aStream: String new writeStream.
					visitor visit: ast.
					channelForResult send: visitor aStream contents ] ] fork ].
	
	files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].
	
	files do: [ :f | channelForFiles send: f ].
	
	refactorResult := OrderedCollection new.
	[refactorResult size equals: files size - 1] whileFalse: [ |toAdd|
		toAdd:= channelForResult receive.
		toAdd 
			ifNotNil:[refactorResult addLast: toAdd.]
			ifNil:[self error: 'Théo du future, corrige moi.']
	 ].

	^refactorResult
]
