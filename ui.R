


library(shiny)

shinyUI(fluidPage(withMathJax(),
	titlePanel(span("t-Test", style="color:white"),
               windowTitle="t-Test"),
		
	sidebarLayout(position="right",
	sidebarPanel(
		wellPanel(style = "background-color: #FFFFFF;", h5("Bedienfenster"),
		selectInput("method", label = "Hypothesentest", 
								choices = list("beidseitig", "linksseitig","rechtsseitig"), 
								selected = "beidseitig"),
		numericInput('mu', 'Nullhypothese \\( (H_{0}: \\beta = q )\\)',value=0.7, min = -10000, max = 10000, step=0.01),
		shinysky::actionButton('action2', 'Test ausführen', styleclass='primary', position="right"),
        sliderInput('Significance.Level', 'Signifikanzniveau \\( (\\%) \\)', 
																												value=5, min=0,max=50, step=1,),
		sliderInput('Number.of.Observation', 'Beobachtungsumfang \\( (T) \\)', 
								value=3, min=3,max=100, step=1,),

		sliderInput('Number.of.Samples', 'Stichproben \\( (S) \\)', 
								value=1, min=1,max=500, step=1,),
		br(),

		shinysky::actionButton('action', 'Stichprobenerzeugung', styleclass='success'),
		downloadButton('downloadPlot', 'Grafik herunterladen')),
		br(),
		br(),
																	
																	
		wellPanel(p(strong("Redaktion"), style='margin-bottom:1px;color:black;'),
							HTML("<p style='margin-bottom:1px;color:black;'>Programmierung: Andranik Stepanyan</p>"),
							p("Text: Ludwig von Auer", style="color:black"),
							HTML("<a , style='margin-bottom:1px;color:black;' href = 'https://www.uni-trier.de/index.php?id=50126' target='_blank'>Professur für Finanzwissenschaft</a>"),
							p("Fachbereich IV - Volkswirtschaftslehre", style = 'margin-bottom:1px;color:black;'),
							p("Universität Trier", style="color:black"),
							p(strong("Lehrbuch"), style = 'margin-bottom:1px; color:black;'),
							HTML("<p style = 'color:black;'>Auer, Ludwig <a href = 'https://www.uni-trier.de/index.php?id=15929' target='_blank'><img src='buch.jpg' style='float: right;'></a>von (2013),
                                 <a href = 'https://www.uni-trier.de/index.php?id=15929' target='_blank' style='color:black'>Ökonometrie - eine Einführung,<br>
                                 6. Auflage, Springer-Gabler<a/> </p>"),
							
							br(),
							br(),
							HTML('<div class="btn-group dropup">
                                <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#">
                                Weitere Animationen
                                <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/Stoergroessen/" target="_blank">&nbsp; Störgrößen</a></p>
                                <p style="margin-bottom:1px;color:black;"><a href="https://oekonometrie.shinyapps.io/WiederholteStichproben/" target="_blank">&nbsp; KQ-Schätzer</p>
                                <a href="https://oekonometrie.shinyapps.io/Intervallschaetzer/" target="_blank">&nbsp; Intervallschätzer</a>
                                <p style="margin-bottom:1px;" >&nbsp; t-Test</p>
                                <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/Ftest/" target="_blank">&nbsp; F-Test vs t-Test</a></p>
								
                                </ul>
                                </div>')),
		list(tags$head(tags$style("body {background-color: #6d6d6d; }")))
		),
		mainPanel(
																	
		wellPanel(wellPanel(style = "background-color: #FFFFFF;",
                            plotOutput("tplot",height = "550px"))),
		wellPanel(style = "background-color: #DEEBF7;",tabsetPanel(type = "pills",                                                        
    tabPanel(h5("Was wird veranschaulicht?"),p("Der \\( t \\)-Test ist ein
Standardverfahren zur Überprüfung von Hypothesen. Wenn der aus der
beobachteten Stichprobe ermittelte \\( t \\)-Wert außerhalb des berechneten 
Akzeptanzintervalls des \\( t \\)-Tests liegt, wird die Hypothese verworfen.
In der Animation können Sie den Einfluss des Signifikanzniveaus, des
Beobachtungsumfangs und der zu überprüfenden Hypothese auf die Breite des 
Akzeptanzintervalls studieren. Ferner werden die Testresultate für wiederholte
Stichproben veranschaulicht.", style="color:black") ),
	tabPanel(h5("Was zeigt die Anfangseinstellung?"), 
p(HTML("<p style='color:black;'>Die Animation greift das Trinkgeld-Beispiel
des Lehrbuches auf. Für jeden Gast \\( t \\) wird das beobachtete Trinkgeld
\\( y_{t} \\) durch den
Rechnungsbetrag \\( x_{t} \\) erklärt: $$y_{t}=α+βx_{t}+u_{t}$$ In der
Anfangseinstellung liegen die drei \\( (x_{t},y_{t}) \\)-Beobachtungen 
\\(	(10,2), (30,3) \\) und \\( (50,7) \\) vor. Es wird ein beidseitiger \\( t
\\)-Test der Nullhypothese \\( H_{0}: \\beta = 0,7 \\) auf einem
Signifikanzniveau von \\( 5\\% \\) durchgeführt.</p>"), 
HTML('<p style="color:black;">Die KQ-Schätzung liefert in der
Anfangseinstellung die Schätzwerte
\\(	 \\hat{\\beta} = 0,125 \\) und \\( \\widehat{sd}(\\hat{\\beta}) = 0,0433
\\). Für \\( H_{0} \\) ergibt sich aus der Stichprobe folglich der \\( t 
\\)-Wert</p>'), HTML("<p style='color:black;'>$$t = \\frac{\\hat{\\beta} - 
0,7}{\\widehat{sd}(\\hat{\\beta})} = \\frac{0,125-0,7}{0,0433} ≈ -13,2794$$
Dieser Wert ist auf der horizontalen Achse der Grafik durch den schwarzen 
senkrechten Strich markiert.</p>"),
HTML('<p style="color:black;">Wenn \\( H_{0} \\) wahr ist, dann ist die
Wahrscheinlichkeitsverteilung
der Zufallsvariable \\( t \\) eine \\( t \\)-Verteilung mit einem einzigen 
Freiheitsgrad, also eine \\( t_{(1)} \\)-Verteilung. Die Grafik zeigt diese
Wahrscheinlichkeitsverteilung. Es ist bekannt, dass eine \\( t_{(1)}
\\)-verteilte Zufallsvariable mit einer Wahrscheinlichkeit von \\( 2,5\\% \\)
größer oder gleich \\( t_{0,025} = 12,7062 \\) ausfällt. Das
Aktzeptanzintervall des \\( t \\)-Tests (grauer Bereich) lautet deshalb</p>'),
HTML("<p  style='color:black'>$$[-t_{0,025};t_{0,025}]=[-12,7062;12,7062]$$ 
Die rötlich markierten Bereiche
sind die Ablehnungsbereiche des Tests.</p>"),
HTML('<p style="color:black;">Der \\( t \\)-Wert der Stichprobe
(senkrechter schwarzer Strich)
liegt außerhalb des Akzeptanzintervalls. Er liegt im linken Ablehnungsbereich
des Tests. Der Wert \\( t=-13,2794 \\) stellt unter Maßgabe der Gültigkeit von
\\( H_{0} \\) folglich ein sehr unwahrscheinliches Ereignis dar. Da es
trotzdem eingetreten ist, wird \\( H_{0} \\) verworfen.</p>') )

),
																				
    tabPanel(h5("Benutzungshinweise"), 
p("Sie können auch einen eigenen \\( t \\)-Test durchführen. Im Bedienfenster
sehen Sie verschiedene Schieber <img src='slider.jpg'>, mit denen Sie die
Parameterwerte des \\( t \\)-Tests verändern können. Klicken Sie dafür mit der
linken Maustaste auf den entsprechenden Schieber und bewegen sie ihn nach
rechts oder links. Es wird automatisch eine neue Stichprobe erzeugt und der 
Hypothesentest erneut durchgeführt.",
HTML('<ul><li style="color:black;">Wenn Sie im Bedienfenster unter der
Überschrift „Hypothesentest" auf das Feld <img src="beidseitig.jpg"> klicken,
haben Sie die Wahl zwischen einem beidseitigen (Ablehnungsbereich auf beiden
Seiten), einem linksseitigen (Ablehnungsbereich auf der linken Seite) und
einem rechtsseitigen (Ablehnungsbereich auf der rechten Seite) Hypothesentest.
</li></ul>'),
HTML('<ul><li style="color:black;">Sie können die Nullhypothese selbst festlegen. 
Zu diesem Zweck
können Sie im Bedienfester unter der Überschrift „Nullhypothese \\(
(H_{0}:\\beta =q) \\)" den voreingestellten Wert \\( q=0,7 \\) durch den von
Ihnen gewünschten Wert \\( q \\) ersetzen. Erst wenn Sie den Knopf  <img
src="test.jpg"> drücken, wird eine neue Stichprobe erzeugt und der von Ihnen
eingestellte \\( t \\)-Test wird durchgeführt. </li></ul>'),
HTML('<ul><li style="color:black;">Mit
dem <strong>Signifikanzniveau-Schieber</strong> stellen Sie ein, wie groß die
Wahrscheinlichkeit sein soll, dass es in Ihrem Test trotz Gültigkeit der
Nullhypothese zu einer Ablehnung dieser Nullhypothese kommt. </li></ul>'), 
HTML('<ul><li style="color:black;">Der <strong>Beobachtungsumfang-Schieber</strong> 
gibt an, wie
viel Beobachtungen der Stichprobe zugrunde liegen. </li></ul>'), 
HTML('<ul><li style="color:black;">Mit dem <strong>Stichproben-Schieber</strong> 
können Sie für den
von Ihnen eingestellten Test viele Stichproben und damit \\( t \\)-Werte 
erzeugen. Für \\( S=500 \\) wird also der gleiche Test \\( 500 \\) mal 
wiederholt, wobei jedesmal eine andere Stichprobe (gleiche \\( x_{t} \\)-Werte
aber neue \\( y_{t} \\)-Werte) zugrunde liegt. Die \\( 500 \\) resultierenden
\\( t \\)-Wert sind auf der horizontalen Achse durch senkrechte Striche
markiert. Ferner wird auf Basis der eingezeichneten \\( t \\)-Werte eine 
Schätzung der Wahrscheinlichkeitsverteilung der Zufallsvariable \\( t \\)
vorgenommen und in bräunlicher Farbe wiedergegeben. </li></ul>'), 
HTML('<ul><li style="color:black;"> Um die aktuelle Grafik in einer jpg-Datei zu
speichern, klicken
Sie das Feld <img src="download.jpg"> an.</li></ul>'), 
HTML("<p style='color:black;'>Um Animationen
zu anderen ökonometrischen Themen zu sehen, klicken Sie bitte auf <img src =
'info.jpg'>.</p>")), style="color:black"),

        tabPanel(h5("Details"),
p(HTML('<p style="color:black;">Der Stichprobenerzeugung liegen die 
„wahren" Parameterwerte \\( \\alpha=0,2 \\) und \\( \\beta=0,13 \\) sowie eine
Störgrößenvarianz von  \\( \\sigma^{2}=2 \\) zugrunde. Die  \\( x_{t}
\\)-Werte werden aus einer Normalverteilung mit Erwartungswert \\( E(x_{t})=45
\\) und Varianz \\( σ_{x}=18 \\) erzeugt. Treten in der Stichprobe negative
\\( x_{t} \\)-Werte auf, dann wird die gesamte Stichprobe erneut
erzeugt.</p>'),HTML("<p
style='color:black;'> Die Dichte der \\( t \\)-Werte wurde mit Gaußkern ermittelt.
Für die Wahl der Bandbreite wurde die Faustregel von Silverman herangezogen
(Silverman, B. W., 1986, Density Estimation for
Statistics and Data Analysis, Chapman and Hall, London, S. 47 f). </p>"),HTML("<p
style='color:black;'>Die entsprechenden R-Skripte für die Reproduktion dieser
Seite sind unter folgendem Link aufrufbar: <a href='https://github.com/andronikoss/t-Test' target='_blank'>R
Codes.</a></p>")
																																	
))
)),
br(),
br(),
br())
																
	)
))      






































