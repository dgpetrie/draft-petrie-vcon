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

  MAILTO: RFC2368

  MIME: RFC2045

  PASSporT: RFC8225

  TEL: RFC3966

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

Meta data , Dialog , Analysis and Conversation Documents

What is the scope of a conversation?

Documents and data inline vs externally referenced.

Different versions of vCon instance for redaction (e.g. for PII or other reasons), added analysis or other content

### Meta Data

Including the parties involved and their identities

### Conversation Dialog

Conversation in it's original media form: text, audio or video.

### Conversation Analysis

Analysis and transformations of the conversation (e.g.  transcriptions, text to speech, summaries, sentiment, translations)

### Conversation Documents

Documment discussed or exchanged during the conversation



# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

* analysis - analysis, transformations, summary, sentiment, or translation tyically of the dialog data

* conversation - an exchange of communication using text, audio or video medium between at least one human and one or more bots or humans

* dialog - the captured conversation in its original form (e.g. text, audio or video)

* file - a data block either included or referenced in a vCon

* object - JSON object containing key and value pairs

* parameter - JSON key and value pair

* party - an observer or participant to the conversation, either passive or active

* payload - the contents or bytes that make up a file

* PII - Personal Identifiable Information

* vCon - container for conversational information

* vCon instance - a vCon populated with data for a specific conversation

* vCon instance version - a single version of an instance of a convsersation, which may be modified to redact or append additional information  forming a subseqent vCon instance version

* vCon syntax version - the version for the data syntax used for form a vCon

## JSON Notation

The convention for JSON notation used in this document is copied from sections 1.1-1.5 of [JMAP].

Date - A string that MUST have the form of an [RFC3339] date string as defined for the Date type in section 1.4 of [JMAP].

"String" - a JSON string type

"UnsignedInt" - a positive JSON integer as defined in section 1.3 of [JMAP].

"UnsignedFloat"

"Mime" - A "String" value that MUST be of the following form as defined in section 5.1 of [MIME]:
    type "/" subtype

"A[]" and array of values of type A.

All parameters are assumed to be manditory unless other wise noted.

Objects or arrays with no or null values MAY be excluded from the vCon.

## Inline Files

Objects that contain a file or data inline (i.e. within the vCon) MUST have the parameters: body and encoding.
JSON does not support binary data values.
For this reason inline files MUST be base64url (see Section 2 [JWS]) encoded to be included as a valid JSON string value if they are not already valud JSON strings.

### body

The body parameter contains the payload of the file to be included inline.  Depending upon the data in the file, it may require encoding to be used as a valid JSON string value.

* body: "String"

### encoding

The encoding parameter describes the type of encoding that was performed on the string value of the body parameter.

* encoding: "String"

    This MUST be one of the following strings:

    + "base64url": The payload of the file has been base64url encoded and provided as the string value of the body parameter.

    + "json": The value of the body string is a JSON object.

    + "none": The payload of the file is a valid JSON string and can be included without modification as the string value to the body parameter.

## Externally Referenced Files

Files and data stored externally from the vCon MUST be signed to ensure that they have not been modified.
Objects that refer to a file which is externally stored from the vCon MUST have the parameters: url, alg key, and signature.  These parameters are defined in the following subsections.
Section 4 of [LM-OTS] defines the general procedure to sign the bytes which compose the content or payload of the externally referenced file.
Handling of externally referenced files is described in general in [#signing-externally-referenced-files].
The following subsections define the specific algoritym used and how that signature information is included in a vCon so that the content can be verified.

### url

The url value contains the [HTTPS] URL where the externally referenced file is stored.
HTTPS MUST be used for retrieval to protect the privacy of the contents of the file.

* url: "String"


### alg

The alg parameter describes the method used for signing the file payload at the given url.
Only one method of signing of externally referenced files is defined in this document.
So only one value is defined for the alg parameter.

*  alg: "String"

    This SHOULD be the following string:

    + "LMOTS_SHA256_N32_W8":  The algorithm used for signing the externally referenced file is defined in section 4.1 of [LM-OTS].

### key

* key: "String"

    The string value of the key parameter is the Base64Ulr Encoded value of the Public Key as defined in section 4.3 [LM-OTS]

### signature

The [LM-OTS] signature on the externally referenced file is included in the signature string value.

* signature: "String"

    The string value of signature is the Base64Url Encoded value of the Signature as defined in section 4.5 of [LM-OTS].

# vCon JSON Object

The JSON form of a vCon is contained in a JSON object in one of three forms:

* unsigned
* signed
* encrypted

The unsigned form of the vCon has a single top level object.
This top level vCon object is also contained as described in the [signed](#signed-form-of-vcon-object) and [encrypted](#encrypted-form-of-vcon-object) forms of the vCon.

# Unsigned Form of vCon Object

The unsigned form of the top level vCon object is necessary as in many cases, a vCon will be partially constructed and in process as conversation data is collected.
This may change while the conversation is in progress or on-going.
The vCon may start with only meta data and party information, then progress to contain dialog information.
It may then get analysis added or it could be passed to another security domain for analysis.

A vCon may be constructed across several security domains.
When a vCon is to be exported from one security domain to another, it SHOULD be signed or encyrpted by the domain that constructed it.
The subsequent domain may have need to redact or append data to the vCon.
Alternatively the originating domain may want to redact the vCon before providing it to an other domain.
The second or subsequent domain, MAY modify the prior vCon instance version and when complete or exporting to another security domain, it SHOULD sign or encrypt the new vCon instance version.
The new vCon instance version SHOULD refer to the prior vCon instance version via the redacted or appended parameters.

## vCon JSON Object Keys and Values

The keys and values for the top level vCon JSON object are defined in the following subsections.

### vcon

The the value of vcon contains the syntactic version of the JSON format used in the vCon.

* vcon: "String"

    For syntax defined in this document, the string MUST have the value: "0.0.1"

### uuid

The [UUID] for the vCon is used to refer to it when privacy or security may not allow for inclusion or URL reference to a vCon.
The UUID should be globaly unique.
The domain creating the vCon should include its fully qualified domain name (FQDN) as part of the UUID and prefix it with a string guarenteed to be unique within it's domain.

* uuid: "String"

    The value of the string MAY be generated using the following:
        SHA-1 digest of concatenation of (RFC3338 Date" + ":" + string value of parties array property) + "@" + FQDN
        Typically the FQDN is the same as that of the signer for the vCon.

    Alteratively if the domain can generate a garenteed unique serial number for all of the vCons created within it's domain, then the UUID may be generated as the concationation of ((serial number) + "@" + FQHN)

### date???

TODO: Does the vCon need a date of completion/`construction or signing?

### subject

The subject or the topic of the conversation is provided in the subject parameter.
This parameter is optional as not all conversations have a defined subject.
Email threads and prescheduled calls and video conversences typically have a subject which can be captured here.

* subject: "String" (optional)

    The string value of the subject is a free formed JSON string with no constrained syntax.

### redacted Object

A redacted vCon SHOULD provide a reference to the unredacted vCon instance version of itself.
For privacy reasons, it may be necessary to redact a vCon to construct another vCon without the PII.
This allows the non-PII portion of the vCon to still be analysed or used in a broader scope.
The redacted object SHOULD contain the uuid parameter or alteratively MAY include the body and encoding parameters or alteratively the url, alg key, and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).
If the unredacted vCon is included in the body, the unredacted vCon MUST be in the encrypted form.
If a reference to the unredacted vCon is provided in the url, the access to that URL MUST be restricted to only those who should be allowed to see the PII for the redacted vCon.

TODO: Need to define method(s) for redaction??

* uuid: "String" (optional if inline or external reference provided)

    The value contains the [uuid string value](#uuid) of the unredacted/original vCon instance version.

or as defined in [Inline Files](#inline-files) body and encoding MAY be included:

* body: "String"
* encoding: "String"

or as defined in [Externally Referenced Files](#externally-referenced-files) url, alg, key and signature MAY be included:

* url: "String"
* alg: "String"
* key: "String"
* signature: "String"

### appended Object

A signed or encrypted vCon cannot be modified without invalidating it.
In these cases, to allow for adding of additional information a new vCon instance version MUST be created.
The prior vCon instance version is referenced by the appended object.
Then the appended information is added to the new vCon instance version (i.e. top level vCon object).

The prior vCon instance version SHOULD be referenced via the uuid of the prior vCon instance version, or alteratively MAY include the body and encoding parameters or alteratively the url, alg, key and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

* uuid: "String" (optional if inline or external reference provided)

    The value contains the [uuid string value](#uuid) of the unredacted/original vCon instance version.

or as defined in [Inline Files](#inline-files) body and encoding MAY be included:

* body: "String"
* encoding: "String"

or as defined in [Externally Referenced Files](#externally-referenced-files) url, alg, key and signature MAY be included:

* url: "String"
* alg: "String"
* key: "String"
* signature: "String"

### group Objects Array

The scope of a conversation is defined by the observer.  It may be any of the following in this non-exaustive list:

* a quick text exchange

* a simple 2-way call

* an evolving group chat

* a class lecture and question and answer session

* a web chat, evolving to a 2 way call, progressing to a transfered 3-way call transitioning to a video conference

* a series of weekly status calls

In support of these constructs, it may be desirable to aggregate a group of vCons.  The conversations may be over heterogenius or homogenius medium.  A vCon MAY aggregated a group of vCon instances in the group array, using a Group Object for each vCon instance.

* group: Group[] (optional)

    The group array contains a [Group Object](#group-object) for each vCon.

TODO: Alternatively, the Dialog Object could refer to a vCon??

### parties Objects Array

The name, identity or contact information of all of the parties involved with the conversation are included in the parties object array.
Whether the parties were observers, passive or active participants in the conversation, they each are included as a Party Object in the parties array.

* parties: "Party[]"

    The value of the parties parameter is an array of [Party Objects](#party-object).

### dialog Objects Array


* dialog: "Dialog[]" (optional)

    The value of the dialog parameter is an array of [Dialog Objects](#dialog-object).

### analysis Objects Array

* analysis: "Analysis[]" (optional)

    The value of the analysis parameter is an array of [Analysis Objects](#analysis-object).

### attachments Objects Array

* attachments: "Attachment[]" (optional)

    The value of the attachments parameter is an array of [Attachment Objects](#attachment-object).

## Party Object

### tel URL

* tel: "String" (optional)

    The value of the tel parameter SHOULD be a valid [TEL] URL.  The URL scheme prefix (i.e. "tel:") is optional.


### STIR

* stir: "String" (optional)

[PASSporT]

### mailto

* mailto: "String" (optional)

    The value of the mailto parameter is a string of the format of a valid [MAILTO] URL.  The URL scheme prefix (i.e. "mailto:") is optional.

### name

* name: "String" (optional)

### validation

Validation methodologies are enterprise and domain specific.  The validation parameter captures the method used to validate the name parameter.
For security reasons, it SHOULD NOT contain the data used to validate the name.
However it MAY name the data used to validate the name (e.g. ssn, user ID and password).

* validation: "String" (MUST be provided if name is provided)

    The value of the validation string MAY be "none" or enterprise or domain defined token or string.

### jCard???

### location???

### timezone???

## Dialog Object

Is there other signalling data that we want to capture other than start and duration and the media (e.g. from jabber, sms, mms, email, SIP, etc.)?

### type

* type: "String"

    The sting MUST have the value of either "recording" or "text"


### start

* start: "Date"


### duration

* duration: "UnsignedInt" \| "UnsignedFloat"

    The value MUST be the dialog (usually the recording) duration in seconds.

### parties

* parties: "UnsignedInt" \| "UnsignedInt"[] \| ("UnsignedInt" \| "UnsignedInt"[])[]

    Single channel recordings should have a parties value of the form: "UnisignedInt" or "UnsignedInt[]" where the integer value or array of integer values are the indices to the Party Object(s) in the parties array that contributed to the mix for the single channel recording.  The index for the Party Object SHOULD be included even if the indicated party was silent the entire conversation.

    Multi-channel recordings MUST have a parties value that is an array of the same size as the number of channels in the recording.  The values in that array are either an integer or an array of integers which are the indicies to the parties that contributed to the mix for the associated channel of the recording.  The index for Party Objects SHOULD be included even if the party was silent the entire conversation.

### mimetype

* mimetype: "Mime" (optional for externally referenced files)

SHOULD support mimetype for text, wav, mp3, mp4, ogg
What about multi-part MIME for email?

### filename

* filename: "String" (optional)

### Dialog Content

The Dialog Object SHOULD contain the body and encoding parameters or the url, alg, key and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

## Analysis Object

Analysis is a broad and in some cases developing field.  This document does not attempt to suggest a SHOULD support list of types.  That is for research and specification in a follow on document.

### type

* type: "String"

    The string value SHOULD be one of the following:

        + "summary"

        + "transcript"

        + "translation"

        + "sentiment"

        + "tts"

### dialog

* dialog: "UnsignedInt"

    The value of the dialog parameter is the index to the dialog in the dialog array to which this analysis object corresponds.

### mimetype

* mimetype: "Mime" (optional for externally referenced files)

### filename

* filename: "String" (optional)

### vendor

* vendor: "String"

### schema

* schema: "String" (optional)

### Analysis Content

The Analysis Object SHOULD contain the body and encoding parameters or the url, alg, key and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

## Attachment Object

No constraint on file types.  As most modes of communication, that allow the exchange of files, do not constrain the file type, any file type may be included here.  It is suggested that a virus scan be run on any files, before including them in a vCon.

### Type or purpose???
Do we want a type like: contract or presentation?
Or a subject or title.

### party

* party: "UnsignedInt"

    The value of the party parameter is the index into the parties array to the party that contributed the attachment.

### mimetype

* mimetype: "Mime" (optional for externally referenced files)

### filename

* filename: "String" (optional)

### Attachment Content

The Attachment Object SHOULD contain the body and encoding parameters or the url, alg, key and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

## Group Object

The Group Object SHOULD contain the uuid or body and encoding parameters or the url, alg, key and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

* uuid: uuid (optional)

or

* body: vcon (optional)
* encoding: "String"
    The encoding string MUST have the value: "json"

or


# Security Considerations

PII can be redacted.
If PII in vCon data, it SHOULD be encrypted
To be a conversation of record, vCon MUST be signed.
Any time a vCon is shared outside its original security domain, it should be signed or encrypted.
Files externally referenced by a vCon SHOULD always be signed with the verification information included in the vCon that references the external file as defined in [#externally-referenced-files] and [#signing-exteranlly-referenced-files].
Externally referenced files SHOULD only be transported over [HTTPS] and SHOULD be access controlled to those who are permitted to read the contents of that entire vCon.
vCons transported over non-secure channels such as email MUST be in the encrypted form.

Need to explain typical storage contexts which may be more secure and storage contexts which are less secure.

## Signing Externally Referenced Files

In some deployments, it is not practical to include all of the file contents of a vCon inline.
In support of that, file may be externally referenced.
When external files are referenced, the signature on the vCon does not secure the file contents from modification.
For this reason any externally referenced files MUST also have a signature.
vCons use the [LM-OTS] method for signing the externally referenced file content and include its url, alg, key and signature in the vCon which are included in the integrety signature for the whole vCon.


After retriving externally referenced files, before using its content, the payload of the HTTPS request should be verified using the key and signature for the url using the procedure defined in section 4.6 of [LM-OTS].

## Signed Form of vCon Object

A signed vCon uses [JWS] and takes the form General JWS JSON Serialization Syntax form as defined in section 7.2.1 of [JWS].

MUST include x5c or x5u in unprotected header.

* payload: "String"

    The value of the payload is the Base64Url Encoded string containing the unsigned vCon.  The general construction of the payload string value is described in section 7.2.1 of [JWK]

* signatures "Signature[]"

    The value of signatures is an array of [Signature Objects](#signature-object)

### Signature Object

The Signature Object MUST contain a header, protected and signature parameter as defined in section 7.2.1 of [JWS].

* header: "Header"

    The value of header is defined in [Header Object](#header-object)

* protected: "String"
* signature" "String"


### Header Object

The Header Object and its contents are defined in section 4 of [JWS].  The Header Object for a signed vCon MUST include the alg and either the x5c or x5u arrays.  The x5c or x5u requirement makes the management and use of vCons easier, allowing the certifcate chain to be found as the vCon is moved.

* alg: "String"

    The string value of alg is defined in section 4.1.1 of [JWS].  For a signed vCon this value SHOULD be "RS256" to maximize interoperablity.

* x5c: "String[]" (MUST provide x5c or x5u)

    The array of string values for x5c are defined in section 4.1.6 of [JWS].

* x5u: "String" (MUST provide x5c or x5u)

    The string value of x5u MUST contain an [HTTPS] URL as defined in section 4.1.5 of [JWS].

How to deal with expired signatures.

## Encrypted Form of vCon Object

A encrypted vCon uses [JWE] and takes the form General JWE JSON Serialization Syntax form as defined in section 7.2.1 of [JWE].

* unprotected: "Unprotected"

* recipients: "Recipient[]"

* iv: "String"

    The string value of iv is the Initization Vector as constructed as defined in section 7.2.1 of [JWE].

* ciphertext: "String"

    The string value of ciphertext is constructed as defined in section 7.2.1 of [JWE] using the unsigned form of the vCon as the plaintext input for encryption.

* tag: "String"

    The string value of tag is the the Authentication Tag as defined in section 7.2.1 of [JWE].

### Unprotected Object

MUST include x5c or x5u here or in recipient header???

* x5c
* x5u

### Recipient Object

* header: "Header"

* encrypted_key: "String"

    The string value of encrypted_key is defined in section 7.2.1 of [JWE].


# IANA Considerations

IANA registration of new media subtype: vcon for media type application:

    application/vcon


--- back

# Example vCons

## Simple vCon Inline Recording

~~~
{::include examples/simple-vcon.pp}
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
