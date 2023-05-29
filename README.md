
<br/>
<p align="center">
  <h3 align="center">Analiza transportului in comun din Cluj-Napoca</h3>

  <p align="center">
    cu ajutorul datelor open de la Tranzy AI - folosind Postrgresql si POSTGIS -
    <br/>
    <br/>
  </p>
</p>



## Despre Proiect

Un document Jupyter Notebook care permite executia pas-cu-pas a unei serii de instructiuni pentru analiza transportului in comun in Cluj-Napoca. 


## Continutul Proiectului

* Jupyter Notebook
* 2 fisiere SQL cu date care sa faciliteze executia analizei  


### Descriere

Datele despre pozitia in timp real a vehiculelor de transport urban, trecute in regim de Date Libere de catre Tranzy AI, permite (intre altele) dezvoltarea unor metode de analiza a modului de deplasare a mijlocacelor de transport in comun (si de ce nu? - prin extrapolare - o analiza a traficului) din municipiu. 

Prezentul proiect se limiteaza la a arata o metoda de lucru bazata pe functiile POSTGIS. Integrarea interogarilor spatiale intr-un document Jupyter Notebook s-a facut cu scopul de a familiariza utilizatorul cu modul de utilizare a functiilor POSTGIS. Rezultatul interogarilor e usor de vizualizat - fie in forma tabelara, fie - in special - sub forma de harta (cu ajutorul librariei cartoframes).

Dupa cum e specificat si in partea introductiva a documentului, utilizatorul trebuie sa aiba instalat Postgresql, pgAdmin, PostGIS; bineinteles Jupyter Notebook cu ipython-sql, psycopg2, pandas, cartoframes.

Pentru datele de analizat - e nevoie de cheie API de la tranzy.dev

In functie de volumul datelor utilizate, parcurgerea tuturor pasilor de analiza din document poate dura ore! Daca in document vi se indica utilizarea sql in pgAdmin, cata vreme interfata respectiva va e familiara, nu ezitati sa o folositi pentru a reduce timpul de lucru. De asemeni - interogarile spatiale sunt perfectibile (in mod cert ele pot fi optimizate).   

Initiativa Tranzy AI de a face publice datele, m-a motivat sa fac - de asemeni, publica - metoda de analiza. 

Daca prezentul proiect e limitat la zona metropolitana Cluj-Napoca, nu uitati ca Tranzy AI opereaza si ofera date despre transportul in comun din Iasi, Botosani, Chisinau - prin urmare - spor la adaptat metoda de analiza. 
