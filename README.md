Vyhledavac obrazku od Gebauer Rene
==================================

Naprogramovano bohuzel rychle pres Maca v cloudu. Doma nemam Mac ani iphone. Vytvoreno a testovana pouze na iphone6 simulatoru v Xcode 6. Pouzite Story board, automaticky reference counting, auto layout a size classes.

Pouzito UIViewCollection, UIScrollView, UISearchBar, NSURLConnection asynchronni request, nahravani obrazku z url pres dispatch_async.

Parametry from a step a dalsi nepouzity na 100%, vypada to ze ani zatim nemaji vliv na zobrazeni. Konkretne zmena parametru step nema vliv na vysledek, nesmyslna hodnota parametru step je validni. Vyzadat si podrobnou specifikaci server API. 

TODO a Nice to have (dalsi Sprint):
===================================
1. Nevalidni JSON ze server strany (+ HTML v JSON??). Nelze parsovat pres NSJsonSerialization. Pouzito parsovani z NSString. Predelat nevalidni json na validni na strane klienta?
2. Z optimalizovat nahravani do collection, postupne nacitat a zobrazovat jednotlive obrazky + nekonecny list.
3. Vylepsit animace zobrazeni detailu fade in a out + navBar (jako Facebook nebo Twitter nebo lepsi)
4. Zobrazeni a spusteni profile na realnem device (hlavne status bar a animace, leaks a rychlost)
5. Podpora landscape left, right
6. Vyparsovat detaily obrazku z HTML a zobrazit (jake detaily?) podle specifikace Server API. 
7. Ukladat obrazky do cache na device (hashtable z url + meta data jako datum zmeny a velikost obrazku), lepsi kdyby hash na strane serveru
8. Zmenit collection view na table view? 
9. Nekonecny scrolling jak nahoru i dolu
10. Reakce na status code 400 a jine error messages, vypis statusMessage nebo ignorovat?
11. Pridat test na connectivitu. 



