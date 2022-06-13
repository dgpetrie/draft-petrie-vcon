---
title: "The JSON format for vCon - Conversation Data Container"
abbrev: "JSON vCon"
category: std

docname: draft-petrie-vcon-latest
submissiontype: IETF  # also: "independent", "IAB", or "IRTF"
number:
date:
consensus: true
v: 3
area: ART
workgroup: WG Working Group
keyword:
 - next generation
 - unicorn
 - sparkling distributed ledger
venue:
  group: WG
  type: Working Group
  mail: WG@example.com
  arch: https://example.com/WG
  github: USER/REPO
  latest: https://example.com/LATEST

author:
 -
    fullname: Daniel G Petrie
    organization: SIPez LLC
    email: dan.ietf@sipez.com

normative:

  JSON: RFC8259

  JWS: RFC7515

  LM-OTS: RFC8554

  PASSporT: RFC8225

informative:

  vCard: RFC7095

  vCon-white-paper:
    target: https://example.com
    title: "vCon: an Open Standard for Conversation Data"
    author:
      -
        ins: T. Howe
        name: Thomas Howe
        org: STROLID Inc.
      -
        ins: D. Petrie
        name: Daniel Petrie
        org: SIPez LLC
      -
        ins: M. Lieberman
        name: Mitch Lieberman
        org: Conversational X
      -
        ins: A. Quayle
        name: Alan Quayle
        org: TADHack and TADSummit

  CDR:
    target: https://www.itu.int/rec/T-REC-Q.825
    title: "Recommendation Q.825: Specification of TMN applications at the Q3 interface: Call detail recording"
    author:
      org: ITU
      date: 1998

--- abstract

A vCon is the container for data and information relating to a conversation.  It is analogous to a {{vCard}} which contains address information for an individual.  A conversation may take the form of a traditional phone call, video conference, SMS or MMS message exchange, webchat or email thread.  The data in the container relating to the conversation may include Call Detail Records ({{CDR}}), call meta data, participant identity information (e.g. {{PASSporT}}), the actual conversational data exchanged (e.g. audio, video, text), realtime or post conversational analysis and attachements of documents exchanged during the conversation.  Having a standardize container for all of the data related to a conversation is useful for many applications (see {{vCon-white-paper}}).  This document specifies the {{JSON}} format for a vCon and a method for signing the document.


--- middle

# Introduction

TODO Introduction


# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

## JSON Notation

## Inline Files

### body

### encoding

## Externally Referenced Files

### url

### alg

## signature

# vCon JSON Object

2 or 3 forms: unsigned, signed, encrypted???

# Unsigned Form of vCon Object

## Top Level Properties

### vcon

### uuid

### date???

### subject

### redacted Object

vcon, uuid or externally reference file

### appended Object

vcon, uuid or externally reference file

### group Objects List

### parties Objects List

### dialog Objects List

### analysis Objects List

### attachments Objects List

## Party Object

### tel URL

### STIR

### email address

### name

### verification

### vCard???

## Dialog Object

### type
recording or text

### mimetype

### filename

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

## Analysis Object

### type

### mimetype

### filename

### vendor

### schema

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

## Attachment Object

### Type???
Do we want a type like: contract or presentation 
Or a subject or title.

### mimetype

### filename

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

### Group Object

vcon, uuid or externally reference file

# Security Considerations

## Signed Form of vCon Object

## Encrypted Form of vCon Object??

# IANA Considerations

New MIME subtype: vcon


--- back

# Example vCons

## Simple vCon Inline Recording

```json
{::include simple-vcon.vcon}
```

## Text Chat vCon

## Email Thread vCon

## Simple vCon Externally Referenced Recording

## Signed vCon

## Encrypted  vCon???

## Redacted Signed vCon

## Ammended Signed vCon

## vCon Group


# Acknowledgments
{:numbered="false"}

TODO acknowledge.
