private
readTimezoneOffsetFrom: stream
	"Read and return an optional timezone offset in the form of 
	[+|-]hh[separator][mm] from stream as an Integer seconds.
	If there is no offset, just return 0"

	| sign hour minute |
	(stream atEnd or: [ stream peekFor: $Z ]) ifTrue: [ ^ 0 ].
	^ ('+-' includes: stream peek)
		ifTrue: [
			sign := stream next = $- ifTrue: [ -1 ] ifFalse: [ 1 ].
			hour := self readInteger: 2 from: stream.
			minute := (self readOptionalSeparatorExpecting: '0123456789' from: stream)
				ifTrue: [  self readInteger: 2 from: stream ]
				ifFalse: [ 0 ].
			sign * ((hour * 3600) + (minute * 60)) ]
		ifFalse: [ 0 ]
