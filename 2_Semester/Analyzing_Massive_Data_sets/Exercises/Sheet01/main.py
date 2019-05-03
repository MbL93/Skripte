"""
Aufgabe1:
n²/2 angenähert für großes N
Paare Tage: (1000 2): 10³*10³/2 = 5*10^5
Paare Personen:(10^9 2): n²/2: 5*10^17
1/100 = 0.01  Wahrscheinlichkeit, dass eine Person an einem Tag in einem Hotel übernachtet
0.01*0.01 = 0.0001 = 10^-4 : Für zwei nicht miteinander verbundene Person
10^-4/10^5 = 10^-9 : Wahrscheinlichkeit, dass 2 Personen die sich nicht kennen am selben Tag im selben Hotel übernachten
Für 2 Tage: 10^-9*10^-9 = 10^-18
5*10^5 * 5*10^17 * 10^-18 = 25*10^4 = 250.000

b)
Anzahl der Personen:    2*10^9      = (2*10^9 * 2*10^9 )/2 = 2*10^18
Triple der Tage:        3 aus 2000  = (2*10^3)!/3!*((2*10^3)-3)! = n^3/6 angenähert: (2*10³ * 2*10³ * 2*10³) /6 = 8/6 * 10^9 
Für 2 Personen:         10^-4 
Im selben Hotel:              
2 Personen 3 Tage:      (10^-27)/8
2b Personen 3 Tage:     2*10^18 * 8/6*10^9 * 10^-27/8 = 1/3 : Keine Person gefunden

"""