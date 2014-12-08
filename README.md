Vyhledavac obrazku od Gebauer Rene
==================================

Naprogramovano bohuzel rychle pres Maca v cloudu. Doma nemam Mac ani iphone. Vytvoreno a testovana pouze na iphone6 simulatoru. 

Pouzito UIViewCollection, UIScrollView, UISearchBar, NSURLConnection asynchronni request, nahravani obrazku z url pres dispatch_async, 

1. Parametry from a step a dalsi nepouzity, vypada to ze ani zatim nemaji vliv na zobrazeni. Vyzadat si podrobnou specifikaci server API. 

TODO a vylepseni dalsi Sprint:
==============================
1. Nevalidni JSON ze server strany (+ HTML v JSON??). Nelze parsovat pres NSJsonSerialization. Pouzito parsovani z NSString.
2. Z optimalizovat nahravani do collection, postupne nacitat a zobrazovat jednotlive obrazky + nekonecny list.
3. Vylepsit animace zobrazeni detailu fade in a out + navBar (jako Facebook nebo Twitter nebo lepsi)
4. Zobrazeni a spusteni profile na realnem device (hlavne status bar a animace, leaks a rychlost)
5. Podpora landscape left, right
6. Vyparsovat detaily obrazku z HTML a zobrazit (jake detaily?) podle specifikace Server API. 
7. Mozna lepsi bude obrazky ukladat do cache na device (hashtable z url + datum zmeny nebo velikost obrazku)
8. Zmenit collection view na table view? 


