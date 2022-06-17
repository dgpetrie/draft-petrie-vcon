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

  JWK: RFC7516

  JWS: RFC7515

  LM-OTS: RFC8554

  PASSporT: RFC8225

  UUID: RFC4122

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

A vCon is the container for data and information relating to a conversation.  It is analogous to a {{vCard}} which contains address information for an individual.  A conversation may take the form of a traditional phone call, video conference, SMS or MMS message exchange, webchat or email thread.  The data in the container relating to the conversation may include Call Detail Records ({{CDR}}), call meta data, participant identity information (e.g. {{PASSporT}}), the actual conversational data exchanged (e.g. audio, video, text), realtime or post conversational analysis and attachements of files exchanged during the conversation.  Having a standardize container for all of the data related to a conversation is useful for many applications (see {{vCon-white-paper}}).  This document specifies the {{JSON}} format for a vCon and a method for signing vCons.


--- middle

# Introduction

Standardizing a container for conversation data (vCon) has numerous advantages.  The use of vCons can ease service integration by using a common container and format for enterprize communications.  A vCon becomes the standardized input to communication analysis tools and machine learning and categorization.  vCons can help normalize data lakes.  For a sales lead organization, a vCon can be the container of assets sold to sales teams.  For conversations of record, the vCon can be a legal instrument.


## What's in a vCon?

### Meta Data

Including the parties involved and their identities

### Conversation Dialog

### Conversation Analysis

### Conversation Documents


Documents and data inline vs externally referenced.


# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

* conversation

* file

* list

* object

* parameter

* payload

* PII

* vCon

## JSON Notation

The convension for JSON notation used in this document is copied from [JMAP].

Date

String

UnsignedInt

UnsignedFloat

"A[]" object List

All parameters are assumed to be manditory unless other wise noted.

Objects or arrays with no values MAY be excluded from the vCon.

## Inline Files

Objects that contain a file or data inline (i.e. within the vCon) MUST have the parameters: body and encoding.
JSON does not support binary data values.
For this reason inline files are base64url (see Section 2 [JWS]) encoded so that they can be included as a string value.

### body

The body parameter contains the payload of the file to be included inline.  Depending upon the data in the file, it may require encoding to be used as a valid JSON string value.

* body: "String"

### encoding

The encoding parameter describes the type of encoding that was performed on the string value of the body parameter.

* encoding: "String"

    This MUST be one of the following strings:

    + "base64url": The payload of the file has been base64url encoded and provided as the string value of the body parameter.

    + "json": The value of the body string is a JSON object.

    + "none": The payload of the file is JSON string safe and can be included without modification as the string value to the pody parameter.

## Externally Referenced Files

Files and data stored externally from the vCon MUST be signed to ensure that they have not been modified.
Use of the [LM-OTS] method of signing externally referenced files is described in section XXXX of this document.
Objects that refer to a file which is externally stored from the vCon MUST have the parameters: url, alg and signature.

### url

The [HTTPS] URL where the externally referenced file is stored, is provided in the url parameter.
HTTPS MUST be used for retrieval to protect the privacy of the contents of the file.

* url: "String"

### alg

The alg parameter dsecribed the method used for signing the file payload at the given url.
Only one method of signing of externally referenced files is defined in this document.
So only one value is defined for the alg parameter.

*  alg: "String"

    This MUST be the following string:

    + "lm-ots":  The algorithm used for signing the externally referenced file is [LM-OTS] as described in section XXXX of this document.

### signature

The signature on the externally referenced file is included in the signature parameter.
The signature is constructed as described in section XXXX of this document.

* signature: "String"

# vCon JSON Object

Three forms: unsigned, signed, encrypted

# Unsigned Form of vCon Object

## Top Level Properties

### vcon

The syntactic version of the JSON format used in the vCon.

* vcon: "String"

    For syntax defined in this document, the string MUST have the value: "0.0.1"

### uuid

The [UUID] for the vCon is used to refer to it when privacy or security may not allow for inclusion or URL reference to a vCon.
The UUID should be globaly unique.
The domain creating the vCon should include its fully qualified domain name (FQDN) as part of the UUID and prefix it with a string guarenteed to be unique within it's domain.

* uuid: "String"

    The value of the string MAY be generated using the following:
        SHA-1 digest of concatenation of (RFC3338 Date" + ":" + value of parties property) + "@" + FQDN
        Typically the FQDN is the same as that of the signer for the vCon.

    Alteratively if the domain can generate a garenteed unique serial number for all of the vCons created within it's domain, then the UUID may be generated as the concationation of ((serial number) + "@" + FQHN)

### date???

### subject

The subject or the topic of the conversation is provided in the subject parameter.
This parameter is optional as not all conconversations have a defined subject.
Email threads and prescheduled calls and video conversences typically have a subject which can be captured here.

* subject: String (optional)

### redacted Object

A redacted vCon MAY provide a reference to the unredacted version of itself.
For privacy reasons, it may be necessary to redact a vCon to construct another vCon without the PII.
This allows the non-PII portion of the vCon to still be analysed or used in a broader scope.
The redacted object SHOULD contain the uuid and MAY include the body and encoding or the url, alg and signature (see sections XXXX and XXXX).
If the unredacted vCon is included in the body, the unredacted vCon MUST be in the encrypted form.
If a reference to the unredacted vCon is provided in the url, the access to that URL MUST be restricted to only those who should be allowed to see the PII for the redacted vCon.

* uuid: String (optional)

or as defined in [Inline Files](#inline-files) either:
* body: String
* encoding: String

or as defined in [Externally Referenced Files](#externally-referenced-files):
* url: String
* alg: String
* signature

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

### start

### duration

### parties

### mimetype

### filename

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

## Analysis Object

### type

### dialog

### mimetype

### filename

### vendor

### schema

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

## Attachment Object

### Type???
Do we want a type like: contract or presentation?
Or a subject or title.

### party

### mimetype

### filename

SHOULD include either the Inline File or the Externally Reference File Properties (see section XXXX).

### Group Object

vcon, uuid or externally reference file

# Security Considerations

PII can be redacted.
If PII in vCon data, it SHOULD be encrypted
To be a conversation of record, vCon MUST be signed.

## Signing Externally Referenced Files

## Signed Form of vCon Object

MUST include x5c or x5u in unprotected header.

## Encrypted Form of vCon Object

# IANA Considerations

New MIME subtype: vcon


--- back

# Example vCons

## Simple vCon Inline Recording

~~~json
{::include simple-vcon.pp}
~~~

## Text Chat vCon

## Email Thread vCon

## Simple vCon Externally Referenced Recording

## Signed vCon

## Encrypted  vCon

## Redacted Signed vCon

## Ammended Signed vCon

## vCon Group


# Acknowledgments
{:numbered="false"}

TODO acknowledge.
