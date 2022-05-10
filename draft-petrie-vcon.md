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
  
  PASSPORT:  RFC 8225
  
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

A vCon is the container for data and information relating to a conversation.  It is analogous to a {{vCard}} which contains address information for an individual.  A conversation may take the form of a traditional phone call, video conference, SMS or MMS message exchange, webchat or email thread.  The data in the container relating to the conversation may include Call Detail Records ({{CDR}}), call meta data, participant identity information (e.g. {{PASSPORT}}), the actual conversational data exchanged (e.g. audio, video, text), realtime or post conversational analysis and attachements of documents exchanged during the conversation.  Having a standardize container for all of the data related to a conversation is useful for many applications (see {{vCon-white-paper}}).  This document specifies the {{JSON}} format for a vCon and a method for signing the document.


--- middle

# Introduction

TODO Introduction


# Conventions and Definitions

{::boilerplate bcp14-tagged}


# Security Considerations

TODO Security


# IANA Considerations

New MIME subtype: TBD


--- back

# Acknowledgments
{:numbered="false"}

TODO acknowledge.
