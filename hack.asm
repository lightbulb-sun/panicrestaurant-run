.memorymap
defaultslot 0
slotsize $2000
slot 0 $8000
slot 1 $a000
slot 2 $c000
slot 3 $e000
.endme

.rombankmap
bankstotal 145
banksize $10
banks 1
banksize $2000
banks 16
banksize $400
banks 128
.endro

.background "panicrestaurant.nes"

.equ HELD_BUTTONS           $0b
.equ MASK_BUTTON_B          $40
.equ HORIZONTAL_SPEED_LO    $75
.equ HORIZONTAL_SPEED_HI    $76

.bank 15 slot 2
.orga $c560
        jsr     going_right
        nop

.orga $c56a
        jsr     going_left
        nop

.bank 16 slot 3
.orga $ffe0
going_right:
@check_for_held_b_button_press
        lda     HELD_BUTTONS
        and     #MASK_BUTTON_B
        beq     @the_end
@run_right
        inc     HORIZONTAL_SPEED_LO
@the_end
        ; replace original instructions
        lda     #0
        sta     HORIZONTAL_SPEED_HI
        rts

going_left:
        ; replace original instructions
        sta     HORIZONTAL_SPEED_LO
        sta     HORIZONTAL_SPEED_HI
@check_for_held_b_button_press
        lda     HELD_BUTTONS
        and     #MASK_BUTTON_B
        beq     @the_end
@run_left
        dec     HORIZONTAL_SPEED_LO
@the_end
        rts
