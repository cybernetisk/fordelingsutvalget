# Foreninger
## Legge til en ny forening

###Legg til en ny føring i ```_data/associations.yml```


```
assoc_tag:
    name:   "Assoc_name"
    real:   "The full name of the associations"
    url:    "associations.hacky.software"
    tagline:"The bestest association og the associations"
    former:
      - assoc_last_tag
```

#### ```assoc_tag```
Taggen man skal bruke for å referere til foreningen
#### ```name```
Navnet foreningen normalt sett bruker
#### ```real```
Det fulle navnet til foreningen
#### ```url```
Foreningen sin nettside eller Studord siden til SiO om dem
#### ```tagline```
Tagline hvis de har det
#### ```former```
En liste med tidligere ```assoc_tag``` tags. Brukes når en foreningen bytter navn. 
Feks ```prognett``` -> ```progsys```.  
Dette lar oss da mer presist reflektere hvilken foreningn det er snakk om i referater.


### Legg til en side under ```_associations```

Denne siden må som en minimum inneholde

```
    ---
    layout: assoc_page
    ---
```

Videre kan den inneholde hva som er ønsket som en header til listen over søknader foreningen har sendt inn.

## Oppdarere metadataen til en forening

Oppdater innholdet i ```_data/associations.yml```