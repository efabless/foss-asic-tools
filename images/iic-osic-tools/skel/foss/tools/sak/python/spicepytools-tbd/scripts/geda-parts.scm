;                                                         -*-Scheme-*-
; add a library with the command backend
; Syntax:
; (component-library-command "[listcommand]" "[getcommand]" "[name]")
;

(define gedaparts "/home/werner/oss/geda/spicelib/scripts/gedaparts")

(component-library-command 
 (string-append gedaparts " -l nxp_bipolar.index")
 (string-append gedaparts " -p nxp_bipolar.index" )
 "NXP bipolar transistors")
(component-library-command 
 (string-append gedaparts " -l nxp_diodes.index" )
 (string-append gedaparts " -p nxp_diodes.index" )
 "NXP diodes")
(component-library-command 
 (string-append gedaparts " -l ti_opamps.index" )
 (string-append gedaparts " -p ti_opamps.index" )
 "TI opamps")
(component-library-command 
 (string-append gedaparts " -l ltc_opamps.index" )
 (string-append gedaparts " -p ltc_opamps.index" )
 "LTC opamps")
(component-library-command 
 (string-append gedaparts " -l national_opamps.index" )
 (string-append gedaparts " -p national_opamps.index" )
 "National opamps")
(component-library-command 
 (string-append gedaparts " -l adi_opamps.index" )
 (string-append gedaparts " -p adi_opamps.index" )
 "ADI opamps")
