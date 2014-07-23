
# Definition der Funktion fuer t-Test
t.plot <- function(M=M,mu=mu, method = c("beidseitig","rechtsseitig","linksseitig"),
                   sig.level = 0.95, inside.color, out.color,
                   select=select,...){
    
#     set.seed(16+sim)
#     if(N == 3){
#         x <- c(10, 30, 50)
#         y <- c(2, 3, 7)
#         tip.mod <- lm(y ~ x)
#     } 
#     else {
#         repeat {
#         x <- rnorm(N, 45, 18)
#         if ((length(which(x<0)))==0){break}
#         }
#         y <- 0.2 + 0.13*x + rnorm(N, 0, sqrt(2))
#         tip.mod <- lm(y ~ x)
#     }
	
		# Signifikanzniveau bei 100 Prozent
		# Wenn der Schieber auf 0 % Signifikanz eingestellt wird, wird
		# annäherungsweise eine Zahl, die zu 100 tendiert ausgewählt.
	if(sig.level == 1){
		sig.level <- 0.999999999998
	}
	
    # Parameteranpassung
    par(mfrow=c(1,1))
    par(mar=c(4,7,4,2))
    
    # Layout wird entsprechend definiert bzw. geteilt
    mat <- matrix(c(1,2,1,2), 2, 2)
    layout(mat, widths=1, heights=c(3, 0.5))
 
    # Berechnung der t-werte
		# M Matrix besteht aus 3 Spalten.
		# M[,1] steht für die geschätzte Schätzwerte des Steigungsparameters
		# M[,2] steht für die geschätzte Standardabweichung des Steigungsparameters
		# M[,3] bezeichnet die Anzehl der Freiheitsgrade
    t <- (M[,1] - mu)/sd(M[,1])

    # Definierung von Freiheitsgraden
    df <- M[select,3]
    
    # Definierung der Sequenz an t-Werten
    t.werte <- seq(-15, 15, 0.01)
    
    ##### GRUNDPLOT wird erstellt ##### 
    plot(t.werte,dt(t.werte, df), type="l", 
         main = "",ylim=c(0,0.45),
         xlab=expression(t), ylab=expression(f(t)),
    		 cex.axis=1.5,cex.lab = 1.5,
         cex.main=1.6,font=1, ... )
    
# ------------------------------------------------------------------------------   
   											 ### Beideseitiger Test ###
# ------------------------------------------------------------------------------ 
    # Die Bedingungen werden definiert
		if(method == "beidseitig"){
			# Untere und obere Kritische t-Werte werden berechnet
        lower <- (1 - sig.level)/2
        upper <- 1 - lower
        t.low <- qt(lower,df)
        t.upp <- qt(upper, df)
        
        # Akzeptanzintervall
        akz.int <- c(t.low, t.upp)
        
        # Die kritischen Werte werden auf der X-Achse entsprechend beschriftet
        axis(1, at=akz.int, labels=c(expression(paste("-", t[alpha/2])),
                    expression(t[alpha/2])),cex.axis=1.5,tcl = -0.25 )
        
        # Hintergrund-Polygone werden Definiert
        polygon(matrix(c(c(-17,akz.int[1],akz.int[1], -17),c(0,0,0.5,0.5)), ncol=2),
        				col=rgb(1,0,0,0.1), lty=0)
        polygon(matrix(c(c(akz.int[1],akz.int[2],akz.int[2],akz.int[1]),
        								 c(0,0,0.5,0.5)),ncol=2), col=rgb(0,0,0,0.05), lty=0)
        polygon(matrix(c(c(akz.int[2],17, 17,akz.int[2]),
        								 c(0,0,0.5,0.5)), ncol=2), col=rgb(1,0,0,0.1), lty=0)
        abline(v = akz.int, lty = "dashed")
        
        
      
        # Innerhalb von Signifikanzniveau liegende t.werte
        # Polygone für die t-Verteilung mit entsprechenden Farben werden definiert.
        inside <- t.low <= t.werte & t.werte <= t.upp
        polygon(matrix(c(c(t.werte[1],t.werte,t.werte[length(t.werte)]),
        								 c(0,dt(t.werte, df),0)), ncol=2), col=out.color)
        s <- dt(t.werte[inside], df)
        s.l <- length(s)
        polygon(matrix(c(c(t.low,t.low,t.werte[inside],t.upp,t.upp),
        								 c(0,s[1],s,s[s.l],0) ), ncol=2), col=inside.color)
       
        
        # Aus der Stichprobe berechneter t-Werte werden dargestellt
        lines(t[1:select],rep(0.02,select) , lwd=0.8, type="h") 
        lines(t[1:select],rep(-0.01,select) , lwd=0.8, type="h")
        
        # Dichtefunktion für die aus der Stichproben berechneten t-Werte wird
        # definieren.
        if(select != 1){
        	den <- density(t[1:select])
        	lines(den, col="darkred")
        	polygon(den,col="darkred", density=20)
        }
        
        
#         axis(1, at = t[select], labels = expression(t),tcl = -0.25,cex.axis = 1.5 )

				# Signifikanzniveau wird auf dem Grafik geplottet.
				# Beidseitig-Signif-Prozent ----
        text(0, 0.03, paste(round(sig.level*100,2), "%"),cex=1.3 )
        text(t.low-2.5, 0.03, paste(round(((1-sig.level)/2)*100, 2), "%"),cex=1.3)
        text(t.upp+2.5, 0.03, paste(round(((1-sig.level)/2)*100,2), "%"),cex=1.3)
        
				# Parameteranpassungen
        par(mar=c(1,2,1,1))
        plot(1:10,1:10, axes=F, type="n", xlab="", ylab="")
        
        # Voraussetzung
#         if (t[select] < t.low | t[select] > t.upp){
#             text(7,8, expression(paste(italic("Resultat: "),paste(H[0], " kann verworfen werden"))), cex = 1.4)
#             
#         } else {
#             text(7,8, expression(paste(italic("Resultat: "),paste(H[0], " kann ", bold(nicht), " verworfen werden"))), cex = 1.4)
#         }
    }
# ------------------------------------------------------------------------------    
    										### Rechtsseitiger Test ###
# ------------------------------------------------------------------------------    

    if(method == "rechtsseitig"){
        upper <- sig.level 
        t.upp <- qt(upper, df)
        # Akzeptanzintervall Hintergrund
        polygon(matrix(c(c(-17,t.upp,t.upp,-17),c(0,0,0.5,0.5)),ncol=2), col=rgb(0,0,0,0.05), lty=0)
        polygon(matrix(c(c(t.upp,17, 17,t.upp),c(0,0,0.5,0.5)), ncol=2), col=rgb(1,0,0,0.1), lty=0)
        
        # Akzeptanzintervall 
        abline(v = t.upp, lty = "dashed")
        axis(1, at=t.upp, labels=expression(t[alpha]), cex.axis=1.5,tcl = -0.25)
        inside <- t.werte <= t.upp
        polygon(matrix(c(c(t.werte[1],t.werte,t.werte[length(t.werte)]),
                         c(0,dt(t.werte, df),0)), ncol=2), col=out.color)
        s <- dt(t.werte[inside], df)
        s.l <- length(s)
        polygon(matrix(c(c(t.werte[1],t.werte[inside],t.upp,t.upp), c(0,s,s[ s.l],0) ),
                       ncol=2), col=inside.color)
        
      
        
        # Aus der Stichprobe berechneter t-Wert
        lines(t[1:select],rep(0.02,select) , lwd=0.8, type="h") 
        lines(t[1:select],rep(-0.01,select) , lwd=0.8, type="h")
        
        # Dichtefunktion der t-Werte
        if(select != 1){
        	den <- density(t[1:select])
        	lines(den, col="darkred")
        	polygon(den,col="darkred", density=20)
        }
        
#         axis(1, at = t[select], labels = expression(t), tcl = -0.25,
#              cex.axis=1.5)
				# Signifikanzniveau wird auf dem Grafik geplottet.
				# Rechts-Signif-Prozent ----
        text(0,0.03, paste(round(sig.level*100,2), "%"),cex=1.3 )
        text(t.upp + 3, 0.03,paste(round(1-sig.level, 2)*100, "%"),cex=1.3)
        
        # Parameteranpassung
        par(mar=c(1,2,1,1))
        plot(1:10,1:10, axes=F, type="n", xlab="", ylab="")
        
        # Voraussetzung
#         if (t[select] > t.upp){
#             text(7,8, expression(paste(italic("Resultat: "),paste(H[0], " kann verworfen werden"))), cex = 1.4)
#             
#         } else {
#             text(7,8, expression(paste(italic("Resultat: "),paste(H[0], " kann ",  bold(nicht), " verworfen werden"))), cex = 1.4)
#         }
        
    }
    
    
# ------------------------------------------------------------------------------    
    											### Linksseitiger Test ###
# ------------------------------------------------------------------------------    

    if(method == "linksseitig"){
        lower <- 1 - sig.level
        t.low <- qt(lower,df)
        # Akzeptanzintervall Hintergrund
        polygon(matrix(c(c(-17,t.low,t.low, -17),c(0,0,0.5,0.5)), ncol=2), col=rgb(1,0,0,0.1), lty=0)
        polygon(matrix(c(c(t.low,17,17,t.low),c(0,0,0.5,0.5)),ncol=2), col=rgb(0,0,0,0.05), lty=0)
        
        # Akzeptanzintervall
        abline(v = t.low, lty = "dashed")
        
        axis(1, at=t.low, labels=expression(paste("-",t[alpha])), cex.axis=1.5,
             tcl = -0.25)
        inside <- t.werte >= t.low
        
        # Markierung 
        polygon(matrix(c(c(t.werte[1],t.werte,t.werte[length(t.werte)]), c(0,dt(t.werte, df),0)), ncol=2), col=out.color)
        s <- dt(t.werte[inside], df)
        polygon(matrix(c(c(t.low,t.low,t.werte[inside],t.werte[length(t.werte)]), c(0,s[1],s, 0) ), ncol=2), col = inside.color)
        
        # Aus der Stichprobe berechneter t-Wert
        lines(t[1:select],rep(0.02,select) , lwd=0.8, type="h") 
        lines(t[1:select],rep(-0.01,select) , lwd=0.8, type="h")
        
        # Dichtefunktion der t-Werte
        if(select != 1){
        	den <- density(t[1:select])
        	lines(den, col="darkred")
        	polygon(den,col="darkred", density=20)
        }
        
        
#         axis(1, at = t[select], labels = expression(t), tcl = -0.25,
#              cex.axis=1.5 )
				# Signifikanzniveau wird auf dem Grafik geplottet.
				# Links-Signif-Prozent ----
        text(0, 0.03, paste(round(sig.level*100,2), "%"),cex=1.3)
        text(t.low - 3, 0.03, paste(round(1-sig.level, 2)*100 , "%"),cex=1.3)
        
        # Parameteranpassung
        par(mar=c(1,2,1,1))
        plot(1:10,1:10, axes=F, type="n", xlab="", ylab="")
        
        # Voraussetzung
#         if (t[select] < t.low){
#             text(7,8, expression(paste(italic("Resultat: "),paste(H[0], " kann verworfen werden"))),cex = 1.4)
#             
#         } else {
#             text(7,8, expression(paste(italic("Resultat: "),paste(H[0], " kann ", bold(nicht), " verworfen werden"))), cex = 1.4)
#         }
        
    }
# ------------------------------------------------------------------------------
													### End-Phase der Funktion
# ------------------------------------------------------------------------------    

		# Bevor die Legende abzubilden, werden die Margines und Out-of-Margins
		# Bereiche eingestellt.
    par(mar=c(1,2,1,1), oma=c(0,0,0,0))

		# Legende wird geplotet ----  
    legend(1,11.3, legend=c("Akzeptanzbereich", "Ablehnungsbereich"),
           fill=c(inside.color, out.color),bty="n", cex = 1.4)
    legend(1,5, legend="Aus der Stichprobe berechneter t-Wert",
           pch="|", col="black", bty="n", cex = 1.5)
    
		# Parametereinstellungen auf die Ursprüngliche zurücksetzen
    par(mfrow=c(1,1))
    par(mar=c(4,4,2,2))
}



