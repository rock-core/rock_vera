#!/usr/bin/tclsh
# Comma should not be preceded by whitespace, but should be followed by one

foreach f [getSourceFileNames] {
    foreach t [getTokens $f 1 0 -1 -1 {comma}] {
        set line [lindex $t 1]
        set column [lindex $t 2]
        set preceding [getTokens $f $line 0 $line $column {}]
        if {$preceding == {}} {
            report $f $line "comma should not be preceded by whitespace"
        } else {
            # Catch initializer lists aligned on the colon
            set aligned_with_colon 0

            set i 1
            while {[expr $line - $i] > 0} {
                set lineI [expr $line - $i]
                set sameColumnOneLineBefore [getTokens $f $lineI $column $lineI [expr $column + 1] {}]
                set c [lindex [lindex $sameColumnOneLineBefore 0] 3]
                if {$c == "colon"} {
                    set aligned_with_colon 1;
                    break
                } elseif {$c != "comma"} {
                    break
                }
                incr i
            }

            set lastPreceding [lindex [lindex $preceding end] 3]
            if {$aligned_with_colon == 0 && $lastPreceding == "space"} {
                report $f $line "comma should not be preceded by whitespace"
            }
        }
        set following [getTokens $f $line [expr $column + 1] [expr $line + 1] -1 {}]
        if {$following != {}} {
            set firstFollowing [lindex [lindex $following 0] 3]
            if {$firstFollowing != "space" && $firstFollowing != "newline" &&
                !($lastPreceding == "operator" && $firstFollowing == "leftparen")} {
                report $f $line "comma should be followed by whitespace"
            }
        }
    }
}
