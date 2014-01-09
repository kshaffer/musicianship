\version "2.14.2"

#(set-default-paper-size "letter" 'landscape)
#(set-global-staff-size 20)

\header {
title = \markup { \smallCaps { "k. 283, i., mm. 1-10" } }
subtitle = \markup { \smallCaps { "with thoroughbass reduction" } }
	poet = ""
	composer = \markup { \smallCaps { "w.a. mozart" } }
	tagline = ""
	copyright = ""
	}

	\paper {
		myStaffSize = #20
		#(define fonts
	   (make-pango-font-tree  "Fanwood"
	                          "Nimbus Sans"
	                          "Luxi Mono"
	;;                        "Helvetica"
	;;                        "Courier"
	     (/ myStaffSize 20)))
	
	 	indent = 0.0\in
		top-margin = 0.5\in
		bottom-margin = 0.25\in
		line-width = 9.0\in
		ragged-right = ##f
		ragged-bottom = ##t
		ragged-last-bottom = ##t
		system-system-spacing #'minimum-distance = #25
		markup-system-spacing #'minimum-distance = #20
		score-system-spacing #'minimum-distance = #25
		last-bottom-spacing #'minimum-distance = #15
		%	page-count = #3
		print-page-number = ##f
	
	}

global = { 
	\override Score.PaperColumn #'keep-inside-line = ##t 	
	\override Staff.TimeSignature #'style = #'() 
	\override Staff.KeyCancellation #'break-visibility = #all-invisible
	\override Staff.TimeSignature #'break-visibility = #end-of-line-invisible
	\set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
	\set Staff.explicitClefVisibility = #end-of-line-invisible	
	\override Score.RehearsalMark #'self-alignment-X = #LEFT
	\override Score.RehearsalMark #'Y-offset = #6
	\override Score.RehearsalMark #'font-size = #2

	% enter key signature, time signature, pickup length here
	\key g \major
	\time 3/4
	\partial 4
	}

upper = \relative c'' {
    \clef treble
	d8.(\p b16
	d4) r g,(
	fis) r a'8.( fis16
	a4) r c,(
	b) r g'8.( fis16)
	fis8(\fp e) e4 g8.( e16)
	e8(\fp d) d4 g8.(\f d16)
	d4-. d-. d-.
	d16( e fis g a b c d c b a g 
	fis e d c b e b g a c a fis
	g4) r \bar ""
	}

lower = \relative c' {
    \clef bass
	r4
	g8( b d b d b
	a c d c d c
	fis, a d a d a
	g b d b g4)
	\clef treble
	<c g'>2 r4
	<b g'>2 r4
	\clef bass
	<a c>4( <g b> <fis a>)
<g b> r <e g> r << { g4( c) b } \\ { d,2 g4 } >> g,4
	 \bar ""
	}


thoroughbass = <<
	\new Staff = bass <<
	
		\global
		\figuremode {
			\bassFigureStaffAlignmentUp
			\override BassFigure #'extra-offset = #'(0 . 1)
		
			% enter figures here within <> brackets
				% use + for sharp, - for flat, ! for natural
				% _ will make accidental by itself (apply to 3)
				% use s if bass note has no figure
				s4
				s2. <4 3> <6 5> s
				s <6> <4 3>4 s <6> s2 <6> <8 6 4>4 <7 5 3> s2
			}

	\new Voice = "bass" <<
		\relative c' {
            \clef bass
            s4
			g2. a fis g c b a4 g fis g2 e4~ e d2 g,2
		}
		>>
	>>
	>>

functionalBass = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
		"T(1" "D(2" "7)n" "1" "S4i" "3" "D2p" "1" "D7n" "1)" "S6" "D5" "T1"
		}
	}

functionalBassLower = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
	
		% enter functional bass here, follwing the rules of lilypond lyrics

		}
	}

roman = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
		I V "—" I IV I V I V I IV V I
	}
	}

\score {
<<
	
	\new PianoStaff \with { 
		\override StaffGrouper #'staff-staff-spacing #'minimum-distance = #10
		}
		<<
		\set PianoStaff.instrumentName = " "
		\set PianoStaff.shortInstrumentName = " "
		\set PianoStaff.midiInstrument = "piano" 
		\new Staff = "Staff_pfUpper" << \global \upper >>
		\new Staff = "Staff_pfUpper" << \global \lower >>
		>>
	<< \global \thoroughbass >>
%	\new Lyrics \lyricsto "bass" { \functionalBass }
%	\new Lyrics \lyricsto "bass" { \functionalBassLower }
%	\new Lyrics \lyricsto "bass" { \roman }
>>

	\layout { 
		\context { \Score \remove "Bar_number_engraver" }
%		\context { \Staff \remove "Time_signature_engraver" }
    }
	}
