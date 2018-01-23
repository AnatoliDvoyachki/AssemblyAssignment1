;
; Hand-in1.asm
;
; Created: 15/09/2017 10:37:10
; Author : Ciprian § Anatoli
;

/*
; Part 1
; assign values and initialize output port
.equ counter = 0
.equ MAX_LIMIT = 128
ldi r21, MAX_LIMIT
ldi r19, counter
ldi r20, 0b11111111
out DDRB, r20

; counts from 0 to 127 and displays the value in binary
COUNT_AND_DISPLAY:
	mov r20, r19
	com r20
	out PORTB, r20
	call DELAY_1S
	inc r19
	cp r19, r21
	brlo COUNT_AND_DISPLAY


; end of code
END:
	rjmp END

; makes a lot of cycles to delay time for total duration of approx 1 second
DELAY_1S:
	ldi r25, 40;
	DELAY_OUTER:
		ldi r24, 200;
		DELAY_MIDDLE:
			ldi r23, 250;
			DELAY_INNER:
				nop
				nop
				dec r23
				brne DELAY_INNER
			dec r24
			brne DELAY_MIDDLE
		dec r25
		brne DELAY_OUTER
	ret
*/

/*
;Part 2
; assign values
.def inner = r23
.def middle = r24
.def outer = r25

ldi inner, 250		;
ldi middle, 200		; these values can be changed so we get bigger or smaller delays, now is 1 second
ldi outer, 40		;

; makes a multiple cycles to delay time 
DELAY_1S:
	mov r26, outer;
	DELAY_OUTER:
		mov r27, middle;
		DELAY_MIDDLE:
			mov r28, inner;
			DELAY_INNER:
				nop
				nop
				dec r28
				brne DELAY_INNER
			dec r27
			brne DELAY_MIDDLE
		dec r26
		brne DELAY_OUTER
	ret
*/

/*
; Part 3
; assign values & port
.equ counter = 0
.equ MAX_LIMIT = 128
.equ MIN_LIMIT = 0

.def inner = r23
.def middle = r24
.def outter = r25

ldi inner, 250		;
ldi middle, 200		; these values can be changed so we get bigger or smaller delays, now is 1 second
ldi outter, 40		;

ldi r21, MAX_LIMIT
ldi r22, MIN_LIMIT
ldi r19, counter
ldi r20, 0b11111111
out DDRB, r20

; displays the value on the LEDs, delays and increments counter
COUNT_UP:
	mov r20, r19
	com r20
	out PORTB, r20
	call DELAY
	inc r19
	cp r19, r21
	brlo COUNT_UP

ldi inner, 250		
ldi middle, 200		
ldi outter, 8	

; counts down to 0, displays the value on the leds and delays
COUNT_DOWN:
	dec r19
	mov r20, r19
	com r20
	out PORTB, r20
	call DELAY
	cp r22, r19
	brlo COUNT_DOWN

; end of program
END:
	rjmp END

; makes multiple cycles to delay
DELAY:
	mov r26, outter;
	DELAY_OUTER:
		mov r27, middle;
		DELAY_MIDDLE:
			mov r28, inner;
			DELAY_INNER:
				nop
				nop
				dec r28
				brne DELAY_INNER
			dec r27
			brne DELAY_MIDDLE
		dec r26
		brne DELAY_OUTER
	ret
*/


; Part 4
; assign values & output port
.equ counter = 0
.equ MAX_LIMIT = 128
.equ MIN_LIMIT = 0

.def inner = r23
.def middle = r24
.def outer = r25

ldi inner, 208		;
ldi middle, 200		; these values can be changed so we get bigger or smaller delays, now is 1 second


ldi r21, MAX_LIMIT
ldi r22, MIN_LIMIT
ldi r19, counter
ldi r20, 0b11111111
out DDRB, r20


INFINITE_LOOP:
	ldi outer, 40	
	; counts from 0 to 127
	COUNTUP_SLOW:
		mov r20, r19
		com r20
		out PORTB, r20
		call DELAY
		inc r19
		cp r19, r21
		brlo COUNTUP_SLOW
		
	ldi outer, 8	

	; decrements counter from 127 to 0, displays counter on the LEDs and delays for 0.2s
	COUNTDOWN_FAST:
		dec r19
		mov r20, r19
		com r20
		out PORTB, r20
		call DELAY
		cp r22, r19
		brlo COUNTDOWN_FAST

	ldi outer, 40	
	
	; decrements the counter from 0 to -127 and displays the values to LEDs, delays for 1s and decrements value
	; the moment the counter decrements from 0 it goes to 255 which is the same in binary as we would write -1 with the first bit as a sign bit
	COUNTDOWN_SLOW:
		out PORTB, r20
		call DELAY
		dec r19
		mov r20, r19
		com r20
		cp r21, r19
		brlo COUNTDOWN_SLOW

	ldi outer,8
	
	; counts up to 0, displays the value on the LEDs for 0.2 s
	COUNTUP_FAST:
		inc r19
		mov r20, r19
		com r20
		out PORTB, r20
		call DELAY
		cp r22, r19
		brlo COUNTUP_FAST
	rjmp INFINITE_LOOP


; multiple cycles to delay
DELAY:
	mov r26, outer;
	DELAY_OUTER:
		mov r27, middle;
		DELAY_MIDDLE:
			mov r28, inner;
			DELAY_INNER:
				nop
				nop
				nop
				dec r28
				brne DELAY_INNER
			dec r27
			brne DELAY_MIDDLE
		dec r26
		brne DELAY_OUTER
	ret

