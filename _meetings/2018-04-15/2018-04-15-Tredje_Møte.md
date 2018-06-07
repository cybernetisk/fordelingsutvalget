--- 
layout: mote
title: "[TEST][EXP] Første Møte 2016"
categories:
  - Motereferat
tags:
  - Motereferat
--- 

{% for collection in site.collections %}
    <section>
        <h1><a href="{{ collection.directory }}">{{ collection.title }}</a></h1>
        Label: {{ collection.label }}
    </section>
{% endfor %}


{% assign meetings = site.meetings %}
{% for meeting in meetings reversed limit:1000 %}
    {{ meeting}}
    {{ meeting.title }}
{% endfor %}

Dette er en test


# Heading
Headingtext


## Subheading

* Innkalling
* Søknader

 [1]: #
 [2]: #
 [3]: #
 [4]: #
 [5]: #
 [6]: #
 [7]: #
 [8]: #
 [9]: #
 [10]: #