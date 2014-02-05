\version "2.14.2"

#(set-default-paper-size "letter")
#(set-global-staff-size 20)

\header {
	title = ""
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
	ragged-bottom = ##f
	ragged-last-bottom = ##t
	system-system-spacing #'minimum-distance = #25
	markup-system-spacing #'minimum-distance = #18
	last-bottom-spacing #'minimum-distance = #15
%	page-count = #3
	print-page-number = ##f
	}

global = { 
	\override Score.PaperColumn #'keep-inside-line = ##t 	
	\override Score.BarNumber #'padding = #2
	\override VoltaBracket #'extra-offset = #'(0 . -3)
	\override ChordName #'font-family = #'roman
	\override Score.LyricText #'font-series = #'bold
	\override Score.LyricText #'font-family = #'sans
	\override ChordName #'font-size = #0.5
	\override Staff.TimeSignature #'style = #'() 
	\set majorSevenSymbol = \markup { "maj7" }
	\override Staff.StaffGrouper #'staff-staff-spacing #'minimum-distance = #40

	% enter key signature, time signature, pickup length here
	\key c \major
	\time 7/1
%	\partial 8
	}

upper = \relative c' {
	\clef treble
	<e g c>1 <f a d> <g b e> <a c f> <b d g> <c e a> <d f b>
	<e, g b>1 <f a c> <g b d> <a c e> <b d f> <c e g> <d f a>
}

lower = <<
	\new Voice = "bass" <<
		\relative c {
			\clef bass
			
			% enter bass line here
			c1 d e f g a b \bar "||" \break
			c,1 d e f g a b \bar "||" \break
			
			}
		
		\new FiguredBass \figuremode {
			\override BassFigure #'extra-offset = #'(0 . 12)
			
			% enter figures here within <> brackets
				% use + for sharp, - for flat, ! for natural
				% _ will make accidental by itself (apply to 3)
				% use s if bass note has no figure
				
			s1*7
			<7>1 <7>1 <7>1 <7>1 <7>1 <7>1 <7>1 
			
			}
		>>
	>>

roman = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
		
		I II III IV V VI VII	
		I II III IV V VI VII	
	}
	}

functionalBass = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
	
		% enter functional bass here, follwing the rules of lilypond lyrics
	
		"T1" "S2" "T3" "S4" "D5" "Tx6" "D7"
		"T1" "S2" "*" "S4" "D5" "Tx6" "D7"	
	}
	}

\score {
	\new PianoStaff \with { 
		\override StaffGrouper #'staff-staff-spacing #'minimum-distance = #15
		}
		<<
		\set PianoStaff.instrumentName = " "
		\set PianoStaff.shortInstrumentName = " "
		\set PianoStaff.midiInstrument = "piano" 
		\new Staff = "Staff_pfUpper" << \global \upper >>
		\new Staff = "Staff_pfLower" << \global \lower >>
		\new Lyrics \lyricsto "bass" { \roman }
		\new Lyrics \lyricsto "bass" { \functionalBass }
		>>
	\layout { 
		\context { \Score \remove "Bar_number_engraver" }
		\context { \Staff \remove "Time_signature_engraver" }
		}
	}
