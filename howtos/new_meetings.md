# Legge til nye møter

Å legge til nye møter er ment å være så rett fram som mulig. Vi har valgt at Jekyll skal få lov til å utlede en del informasjon rett fra mappe- og filnavn.



## Legge til en ny møteinkalling

Kopier [templaten](../../_posts/2018-06-11-Template.md) fra _posts
Bytt navn til ```<dato>-<postnavn>.md```
Ikke fyll ut ```*attending```. De dukker ikke opp i innkallingen hvis de er tomme.


For å publisere:
Fjern linjen ```published: false```, push, pull-request til master, merge
## Legge til vedlegg

For å legge til vedlegg trenger man bare en post med en dato. 
Så lager man en mappe under ```meetings/<år>/<møtedato>/``` her kan man legge alle mulige filer. 
Møte layouten legger dem da automatisk til i bunnen av ett referat/agenda.


## Oppdatere innkalling to referat

Vi tar utgangspunktet i at man har en passende innkalling for møtet.

### Fyll ut ```*attending```

```attending``` For de med stemmerett (*observatører er ```other_attending```*)

    
# Info om templaten
Sample:
```
layout: meeting
title: Møte template
subheadline: "Møte i Fordelingsutvalget"

time: 16:15:00
published: false
referent: "Andreas Nyborg Hansen"

attending:
    - 

not_attending:
    -

other_attending:
    -

---

* TOC
{:toc}

## Sak 1 Godkjenning av innkalling {#innkalling}
## Sak 2 Godkjenning av agenda {#agenda}
## Sak 3 Godkjenning av referat {#referat}
## Sak 4 Behandling av søknader {#soknader}
### 4.1 -  {#soknad-1}
### 4.2 -  {#soknad-2}
### 4.3 -  {#soknad-3}
### 4.4 -  {#soknad-4}
### 4.5 -  {#soknad-5}
### 4.6 -  {#soknad-6}
```

####```layout```
####```title```
####```subheadline```
####```time```
####```published```


#### ```attending```
```
attending:
    - <forening>,<Representant sitt navn>
    - <forening>,<Representant sitt navn>
```

* ```<forening>```: assoc_code fra [associations.yaml](../_data/associations.yaml)  
    

#### ```not_attending```

```not_attending``` For de med stemmerett som mangler

```
not_attending:
        - <forening>
        - <forening>
``` 
* ```<forening>```: assoc_code fra [associations.yaml](../_data/associations.yaml)  


#### ```other_attenting```
```other_attending``` For andre som eventuelt er med på møte

```
other_attending:
    - <forening eller fritekst>,<Person sitt navn>
    - <forening eller fritekst>,<Person sitt navn>
```

```<forening eller fritekst>``` resolver automatisk til en forening hvis assoc_code er oppgitt. Ellers blir det fritekst

**Eksempel:**
```
other_attending:
    - koordinator, Mathias Johan Johansen
    - foreningsfesten, Suhas Govind Joshi
    - Andre, Andreas Lind Johansen

```

#### Symbolet ```---```

Betyr at metadaaen som frontmatter/jekyll bruker er ferdig og Markdownen begynner herfra

#### Kommandoen ```* TOC/{:toc}```
Dette er hvordan dialekten Cramdown av Markdown blir instruert i å lage en Table of content


#### Saker

Øverste nivå (```#```) er reservert tittelen på møte  
Nivå 2 (```##```) og nedover brukes i referaret og agendaen  
Underpunker i en sak bruker lister av typen ```-```  
Konklusjon markeres med ```** Konsklusjon kommer her**```  
Se i tidligere saker for eksempler.  

*Ekstra:* Saker kan slutte med ```{#soknader}```. Dette brukes for å navngi [URL ankeret](https://html.com/anchors-links)

**Eksempel:**

```
## Sak 4 Behandling av søknader {#soknader}
### 4.1 - CYB-Prosjektstøtte rigg {#soknad-1}
- Diskusjon:
  - CYB har ikke søkt andre støtteordninger til eiendeler. Noe som bryter med retningslinjer.
  -  Dette går foreningene til gode som helhet, burde bli vurdert ut i fra dette.
  - CYB kan ikke søke KS om midler, grunnet 6. år gammel lang avtale med studentparlamentet rundt innkjøp at sceneutstyr. Kun RF regi kan søke KS om slik støtte.
  - Kan en søke instituttet om dette?
    - Antageligvis ikke, da instituttet ikke vil støtte så store innkjøp som ikke går instituttet direkte til gode. Det er studentene som ønsker scene.
  - Kan dette vente til neste møte? Utstyret trengs ikke før fadderuka.
    - Ikke sikkert. Det er behandlingstid i alle stiftelser, man vil kanskje ikke rekke det.
- Merknader:
  - Utstyret må stilles disponibelt for andre foreninger.
  - Skal prøve å ettersøke ved andre stiftelser

**Godkjenning enstemmig med merknader - 110 153,65 kr** 
```