\version "2.14.2"

#(set-default-paper-size "letter" 'landscape)
#(set-global-staff-size 20)

\header {
	title = \markup { \smallCaps { "protonotation melodies" } }
	subtitle = ""
	poet = ""
	composer = ""
	tagline = ""
	copyright = ""
	}

\paper {
	indent = 0.0\in
	top-margin = 0.5\in
	bottom-margin = 0.25\in
	page-top-space = 0\in
	before-title-space = 0\in
	between-title-space = 1.5\in
	after-title-space = 1.05\in
	line-width = 7.0\in
	left-margin = 0.75\in
	right-margin = 0.75\in
	ragged-right = ##t
	ragged-bottom = ##t
	ragged-last-bottom = ##t
	system-system-spacing #'minimum-distance = #20
	markup-system-spacing #'minimum-distance = #18
	last-bottom-spacing #'minimum-distance = #15
%	page-count = #3
	print-page-number = ##f

	myStaffSize = #18
	#(define fonts
   (make-pango-font-tree  "Fanwood"
                          "Nimbus Sans"
                          "Luxi Mono"
;;                        "Helvetica"
;;                        "Courier"
     (/ myStaffSize 18)))
	}

global = { 
	\override Score.PaperColumn #'keep-inside-line = ##t 	
	\override Staff.TimeSignature #'style = #'() 
	\override Staff.KeyCancellation #'break-visibility = #all-invisible
	\override Staff.TimeSignature #'break-visibility = #end-of-line-invisible
	\set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
	\set Staff.explicitClefVisibility = #end-of-line-invisible	

	% enter key signature, time signature, pickup length here
%	\partial 8
	}

lower = <<
	\new Voice = "bass" <<
		\relative c'' {
			\override Score.RehearsalMark #'self-alignment-X = #LEFT
			\override Score.RehearsalMark #'Y-offset = #4
			\override Score.RehearsalMark #'font-size = #2
			\startStaff
			\clef treble
			
			\clef treble
			\time 4/4
			\key d \major
			a2 d, a'4 g fis2 d'4 cis8 b a2 g4 fis8 e d2
			\bar "|." \break 
			
			\key g \major
			\time 6/8
			\clef bass
			g,,4. fis g8 r a b r c d4. r g,2.
			\bar "|." \break 
			
			\key bes \major
			\time 6/4
			\clef alto
			bes'2. a bes4 r c d r es f2. r bes,1.
			\bar "|." \break
			
			\clef treble \time 4/4 \key es \major
			es4 r f g bes2 aes8 g f es bes2 es4 g bes8 r g r es2
			\bar "|." \break
			
			\key cis \major
			\time 4/8
			\clef tenor
			cis8 r dis eis gis4 fis16 eis dis cis gis4 cis8 eis gis16 r eis r cis4
			\bar "|." \break
			
			\key f \major \time 4/1 \clef bass
			f,1 r g a c\breve bes2 a g f c\breve f1 a c2 r a r f\breve
			\bar "|." \break
			}
				>>
	>>

\score {
	\new PianoStaff \with { 
		\override StaffGrouper #'staff-staff-spacing #'minimum-distance = #20
		}
		<<
		\new Staff = "Staff_pfLower" << \global \lower >>
		>>
	\layout { 
		\context { \Score \remove "Bar_number_engraver" }
%		\context { \Staff \remove "Time_signature_engraver" }
		}
%  	\midi { }
	}
