# Tredjepartstjenester

Denne siden bruker tre stk tredjepartsløsninger som man kanskje får bruk for å endre noe på en eller annen gang i framtiden.
 

## Cognito Forms
Nettside: https://www.cognitoforms.com/
Brukernavn: fu-koordinator@ifi.uio.no

Cognito forms er det man har valgt å bruke for skjemaene sine. 
Grunnen til dette er at det er ett utrolig kraftfullt skjemasystem. Langt mye bedre enn Google sitt. 
Dette skjema integrere videre  supert med "Glue as a service" sider som Zapier og Integromat. 
Som vi videre bruker til å redirigere data til driven og sheetsene våre.


## Integromat / Zapier
Nettside: https://www.integromat.com/
Brukernavn: fu-koordinator@ifi.uio.no

Zapier bruker Nikolas Papaioannou sin private.

Når skjemaene våre får en ny entry sier Cognitor ifra til både Zapier og Integromat (samt mail!).

Første som skjer er at Zapier plukke opp hva den fikk gitt fra Cognitor og ekstraherer en oauth token som ikke er tilgjengelig for Integromat.
Denne tokenen sendes videre til Integromat og resten av prosesseringen skjer videre hos Integromat.

Integromat får også samme data som Zapier + Zapier sitt token. Derfra laster den ned vedleggene til driven vår samt fører nye status sheeten vår.


