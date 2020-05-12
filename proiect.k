module PROIECT-SYNTAX

	syntax Text ::= String | Int | Id 
	
	syntax TextBlocks ::= Text 
					   | TextBlocks TextBlocks [right]
	
	syntax Header1 ::= "header1:" 
	syntax Header1end ::= ":header1"
	
	syntax Header2 ::= "header2:"
	syntax Header2end ::= ":header2"
	
	syntax Header3 ::= "header3:" 
	syntax Header3end ::= ":header3"
	
	syntax Header4 ::= "header4:" 
	syntax Header4end ::= ":header4"
	
	syntax Header5 ::= "header5:" 
	syntax Header5end ::= ":header5"
	 
	syntax Header6 ::= "header6:" 
	syntax Header6end ::= ":header6"
	
	syntax BoldTextBegin ::= "bold"  
	syntax BoldTextEnd ::= "/bold"
	
	syntax ItalicTextBegin ::= "italic" 
	syntax ItalicTextEnd ::= "/italic"
	
	syntax LineBreak ::= "*br*"
	
	syntax BlanckLine ::= "*br*" "*empty*" "*br*"
	
	syntax Blockquotes1 ::= "=>"
	syntax Blockquotes2 ::= "=:>"
	
	syntax CodeBlocks ::= "$"
	
	syntax CodeBegin ::= "<" 
	syntax CodeEnd ::= ">"
	
	syntax Escape ::= "esc" 
	
	syntax HorizontalRules ::= "<->" 
	
	syntax VerticalRules ::= "||"
	
	syntax PathBegin ::= "{"
	syntax PathEnd ::= "}"
	
	syntax Title1Begin ::= "title1:"
	syntax Title1End ::= ":title1"
	
	syntax Title2Begin ::= "title2:"
	syntax Title2End ::= ":title2"
	
	syntax Images ::= "Image:"   
	
	syntax Links ::= "Link:"     
	
	syntax ItemOBegin ::= "ItemO:"
	syntax ItemOEnd ::= ":ItemO"
	
	syntax ItemUBegin ::= "ItemU:"
	syntax ItemUEnd ::= ":ItemU"
	
	syntax Stmt ::= Header1 | Header1end
				| Header2 | Header2end 
				| Header3 | Header3end
				| Header4 | Header4end 
				| Header5 | Header5end 
				| Header6 | Header6end
				| TextBlocks 
				| BoldTextBegin | BoldTextEnd 
				| ItalicTextBegin | ItalicTextEnd
				| LineBreak | BlanckLine | Escape
				| Blockquotes1 | Blockquotes2 
				| CodeBlocks | CodeBegin | CodeEnd 
				| HorizontalRules | VerticalRules
				| PathBegin | PathEnd 
				| Title1Begin | Title1End 
				| Title2Begin | Title2End
				| Images | Links 
				| ItemOBegin | ItemOEnd | ItemUBegin | ItemUEnd
				| Afisare
				
			
	syntax Printable ::= Int 
					  | String 
					  | Id 
					  | TextBlocks
					  
	syntax Afisare ::= "print" "(" Printable ")"    
	
	syntax Pgm ::= Stmt 
				> Pgm Pgm [right]
endmodule

module PROIECT
	imports PROIECT-SYNTAX
	
	syntax KResult ::= Printable
	
    configuration <k> $PGM:Pgm </k>
                  <out stream="stdout"> .List </out>
	
	rule S1:Pgm S2:Pgm => S1~>S2
	
	rule <k> V:TextBlocks => print(V) ... </k> 
	
	rule <k> V:Header1 => print("# ") ... </k>
	rule <k> V:Header1end => print(" ") ... </k>
	
	rule <k> V:Header2 => print("## ") ... </k>
	rule <k> V:Header2end => print(" ") ... </k>
	
	rule <k> V:Header3 => print("### ") ... </k> 
	rule <k> V:Header3end => print(" ") ... </k>
	
	rule <k> V:Header4 => print("#### ") ... </k> 
	rule <k> V:Header4end => print(" ") ... </k>
	
	rule <k> V:Header5 => print("##### ") ... </k>
	rule <k> V:Header5end=> print(" ") ... </k>
	
	rule <k> V:Header6 => print("###### ") ... </k>
	rule <k> V:Header6end => print(" ") ... </k>
	
	rule <k> V:LineBreak => print("\n") ... </k>
	rule <k> V:BlanckLine => print("\n\n") ... </k>
	
	rule <k> V:BoldTextBegin => print("**") ... </k>
	rule <k> V:BoldTextEnd => print("**") ... </k>
	
	rule <k> V:ItalicTextBegin => print("*") ... </k>
	rule <k> V:ItalicTextEnd => print("*") ... </k>
	
	rule <k> V:Blockquotes1 => print("> ") ... </k>
	rule <k> V:Blockquotes2 => print(">> ") ... </k>
	
	rule <k> V:CodeBlocks => print("    ") ... </k>
	
	rule <k> V:CodeBegin => print("`") ... </k>
	rule <k> V:CodeEnd => print("`") ... </k>
	
	rule <k> V:Escape => print("\\") ... </k>
	
	rule <k> V:HorizontalRules => print("---") ... </k>
	rule <k> V:VerticalRules => print("| ") ... </k>
	
	rule <k> V:Title1Begin => print("[") ... </k>
	rule <k> V:Title1End => print("]") ... </k>
	rule <k> V:PathBegin => print("(") ... </k>
	rule <k> V:Title2Begin => print(" \"") ... </k>
	rule <k> V:Title2End => print("\"") ... </k>
	rule <k> V:PathEnd => print(")") ... </k>
	
	rule <k> V:Images => print("!") ... </k>
	rule <k> V:Links => print("") ... </k>
	
	rule <k> V:ItemOBegin => print("1. ") ... </k>
	rule <k> V:ItemOEnd => print("\n") ... </k>
	rule <k> V:ItemUBegin => print("* ") ... </k>
	rule <k> V:ItemUEnd => print("\n") ... </k>
	
    rule <k> (print(V:Printable) => .) ...</k>
       <out>... (.List => ListItem(V)) </out>
	
endmodule