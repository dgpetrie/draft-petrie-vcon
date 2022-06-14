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
workgroup: Dispatch Working Group
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

  HTTPS: RFC2818

  JSON: RFC8259

  JWS: RFC7515

  LM-OTS: RFC8554

  PASSporT: RFC8225

informative:

  JMAP: RFC8620

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

Standardizing a container for conversation data (vCon) has numerous advantages.  The use of vCons can ease service integration by using a common container and format for enterprize communications.  A vCon becomes the standardized input to communication analysis tools and machine learning and categorization.  vCons can help normalize data lakes.  For a sales lead organization, a vCon can be the container of assets sold to sales teams.  For conversations of record, the vCon can be a legal instrument.


Documents and data inline vs externally referenced.


# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

## JSON Notation

The convension for JSON notation used in this document is copied from [JMAP].

datetime

string


## Inline Files

Objects that contain a document or data inline (i.e. within the vCon) MUST have the parameters: body and encoding.
JSON does not support binary data values.
For this reason inline documents are base64url (see Section 2 [JWS]) encoded so that they can be included as a string value.

### body

The body parameter contains the payload of the file to be included inline.  Depending upon the data in the file, it may require encoding to be used as a valid JSON string value.

* body: "String"

### encoding

The encoding parameter describes the type of encoding that was performed on the string value of the body parameter.

* encoding: "String"

    This MUST be one of the following string:

    + "base64url": The payload of the document has been base64url encoded and provided as the string value of the body parameter.

    + "none": The payload of the document is JSON string safe and can be included without modification as the string value to the pody parameter.

## Externally Referenced Files

Files and data stored externally from the vCon MUST be signed to ensure that they have not been modified.
The [LM-OTS] method of signing externally referenced files is described in section XXXX of this document.
Objects that refer to a document which is externally stored from the vCon MUST have the parameters: url, alg and signature.

### url

The [HTTPS] URL where the externally referenced document is stored, is provided in the url parameter.
HTTPS MUST be used for retrieval to protect the privacy of the contents of the document.

* url: "String"

### alg

The alg parameter dsecribed the method used for signing the document payload at the given url.
Only one method of signing of externally referenced documents is defined in this document.
So only one value is defined for the alg parameter.

*  alg: "String"

    This MUST be the following string:

    + "lm-ots":  The algorithm used for signing the externally referenced document is [LM-OTS] as described in section XXXX of this document.

### signature

The signature on the externally referenced file is included in the signature parameter.
The signature is constructed as described in section XXXX of this document.

* signature: "String"

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
Do we want a type like: contract or presentation?
Or a subject or title.

### mimetype

### filename

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

### Group Object

vcon, uuid or externally reference file

# Security Considerations

PII can be redacted.
If PII in vCon data, it should be encrypted??
To be a conversation of record, vCon MUST be signed.

## Signing Externally Referenced Files

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
