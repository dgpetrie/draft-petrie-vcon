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
# area: ART
# workgroup: Dispatch Working Group
keyword:
 - next generation
 - unicorn
 - sparkling distributed ledger
venue:
#  group: WG
#  type: Working Group
#  mail: WG@example.com
#  arch: https://example.com/WG
  github: "dgpetrie/draft-petrie-vcon"
  latest: "https://dgpetrie.github.io/draft-petrie-vcon/draft-petrie-vcon.html"

author:
 -
    fullname: Daniel G Petrie
    organization: SIPez LLC
    email: dan.ietf@sipez.com

 -
    fullname: Thomas McCarthy-Howe
    organization: Strolid
    email: thomas.howe@strolid.com

normative:

  GEOPRIV: RFC4119

  HTTPS: RFC2818

  JSON: RFC8259

  JWK: RFC7516

  JWS: RFC7515

  MAILTO: RFC2368

  MIME: RFC2045

  PASSporT: RFC8225

  PIDF-LO: RFC5491

  SHA-512: RFC234

  TEL: RFC3966

  UUID: RFC4122

informative:

  JMAP: RFC8620

  vCard: RFC7095

  vCon-white-paper:
    target: https://github.com/vcon-dev/vcon/blob/main/docs/vCons_%20an%20Open%20Standard%20for%20Conversation%20Data.pdf
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

  LM-OTS: RFC8554

--- abstract

A vCon is the container for data and information relating to a real-time, human conversation.
It is analogous to a {{vCard}} which enables the definition, interchange and storage of an individual's various points of contact.
The data contained in a vCon may be derived from any multimedia session, traditional phone call, video conference, SMS or MMS message exchange, webchat or email thread.
The data in the container relating to the conversation may include Call Detail Records ({{CDR}}), call meta data, participant identity information (e.g. {{PASSporT}}), the actual conversational data exchanged (e.g. audio, video, text), realtime or post conversational analysis and attachements of files exchanged during the conversation.
A standardized conversation container enables many applications, estabilishes a common method of storage and interchange, and supports identity, privacy and security efforts (see {{vCon-white-paper}})


--- middle

# Introduction

The generation of conversational data, contained in transcripts and multi-media files, is common in business, especially in customer facing organizations. However, the storage, analysis and sharing of the data they contain is not currently a standard.  Standardizing a container for conversation data (vCon) has numerous advantages, and enables the management of the conversation's content.  For instance, a standard allows for tools to determine the contents of the conversation, such that privacy guarantees and duties can be accurately performed. As a storage mechanism, vCons can help normalize data lakes and allow for interchange between organizations and networks. The use of vCons can ease service integration by using a common container and format for enterprize communications.  A vCon becomes the standardized input to communication analysis tools and machine learning and categorization.  For a sales lead organization, a vCon can be the container of assets sold to sales teams.  For conversations of record, the vCon can be a legal instrument.


## What's in a vCon?

A vCon contains four major categories of data: metadata , dialog , analysis and attachments.
The metadata portion allows for an expanded set of data from a typical call detail record ([CDR]), with identifications of the participants or parties to the conversation, the issuer of the vCon and tamerproof features such as signatures.
The dialog portion contains a set of multimedia and mime elements, each representing the actual, physical conversation in it's original media form: text, audio or video.
The analysis portion contains data derived from the metadata and dialog portions, intended to carry items like transcripts, translations, summaries, text to speech, sentiment analysis and other semantic tagging.
Finally, the attachment portion contains any other documents, such as slide deck or sales lead information, which provides context and support for the conversation itself.

A vCon acts as the definition of the conversation, and are created by systems during and after the conversation itself.  Some communication modes, like SMS texting, lack natural session boundaries and require explicit definition.  vCons may have two or more parties involved, but at least one should be a human.  For instance, an interaction between a bot and a human is an appropriate scope for vCons, but a converstion between two bots would not.

Due to the size and complexity of the dialog portion of a vCon, both inline and externally referenced dialog, analysis, attachments and other vCon reference assets are supported.
For instance, vCons may reference a videoconference media as an external URL with an accompanying signature of the contents to detect tampering.
Alteratively, vCons may contain the media of the entire dialog internally, keeping the conversation in one place, and optionally encrypted.

vCons are designed to be a digital asset, versioned and signed.
For instance, different versions of vCon may arise from due to redaction (e.g. for PII or other reasons), added analysis or the addition of other content.
In the metadata, vCons contain the unique ID of the parent vCon, such that they may be traveressed while maintaining their data integrity and provenance.

## Use Cases and Requirements

In large enterprises, different products may be served by different call centers (inhouse or out sourced).
The call centers may have different communications infrastructure and even different platform vendors (e.g. IP PBX, email servers).
Consequently, the CDR and meta data as well as the conversation recordings may be stored in different formats and locations.
This creates artifical silos of storage and analysis.
Using vCon as a stardard exchange, storage, analysis input and output format, would ease integration efforts and cross enterprise analysis of products and call center metrics.
This would also ease customer analysis across product lines which may currently be difficutly due to interoperable silos.
Having conversation data in the vCon format would lower the cost and speed deployment of both inhouse and outsourced analysis tools for import into ML and AI based tools, transcription, translation and sentiment analysis.
Having conversation data in a standard vCon container would ease the export of conversation data from hosted services.
This would enable more analysis capabilities.

In some locations, regulations make it manditory for enterprises to delete private information upon request of the individual.
Large enterprises with siloed communications systems have difficulty locating or identifying all of the private data for an individual due to the disparate communications systems.
Using the vCon as the standard container for all communications system, storing the conversation data centrally and removing it from the siloed communcations systems, allows for easier management, correlation, tracking and deletion of individual's private data.
Without centralizing the storage of the conversations in a standardized container, deleting an individuals private data is untenable and the enterprise cannot assert that they have fulfilled their requirment to locate and delete all of the private data.

Large call centers may have tens of thousands of call agents making hundreds of thousands of calls a day.
Supervising the agents and calls in a large call center is a huge efort.
Using vCons to capture all of the conversations for all of the agents, enables more automation of evaluation, training and coaching of call center agents.
DEVOPS tools such as check for conversation with too low a volume or agents with faulty headsets becomes easier an less costly using vCons.
Call centers often have to provide service level proof and reports to their customers.
These service level evaluations, monitoring and reporting can be more easily provided and at a lower cost via third party solutions with vCons as a standard conversation container.

Conversations can have legal and regulatory significance.
Regulations may require conversation of record to be stored for compliance.
A conversation can become a verbal contract, making the conversation data a legal instrument.
Having a standard container for the conversation data and asserting the integrity of the data make it easier to distribute the conversation data to the parties involved.

Requirements:

* Standardize container for conversational data exchange

* Consolidation of data and information for a conversation

* Multiple modes of communication, changing over time

* Snapshots of conversation during or once completed along with analysis

* Ease of integration of services and analysis

* Better organize conversational data so that it can be handled in a consistant, privacy safer means

* Immutable

* Hiding of PII or entire conversation

* Amendable with additional information and data elements

Define a standard for exchange of conversational data in a sea of modes, platforms and service offerings for conversations.

Example conversational modes and protocols:

* SMS

* MMS

* JABBER

* SIMPLE

* Proprietary web chat

* SMTP

* PSTN

* SIP

* WEBRTC

* Proprietary video conferencing

The following  are considered not in scope or non-requirements:

* Real-time streaming or updating of conversational data

* Transport mechanisms

* Storage or databases specifications

* Methods of redaction of text, audio or video media

* Validation of redactions or appended data beyond the signature of the domain making the changes to the conversational data (e.g. Merkle tree like redactions)

* Standardization of anaysis data formats or file media types

# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

* analysis - analysis, transformations, summary, sentiment, or translation tyically of the dialog data

* conversation - an exchange of communication using text, audio or video medium between at least one human and one or more bots or humans

* de-identification - removal of all information that could identify a party in a conversation.  This includes PII as well as audio and video recordings.  Voice recordings might be re-vocalized with a different speaker.

* dialog - the captured conversation in its original form (e.g. text, audio or video)

* encrypted form - vCon in the signed??? and encrypted form

* file - a data block either included or referenced in a vCon

* object - JSON object containing key and value pairs

* parameter - JSON key and value pair

* party - an observer or participant to the conversation, either passive or active

* payload - the contents or bytes that make up a file

* PII - Personal Identifiable Information

* PII masked - may include voice recordings, but PII is removed from transcripts and recordings (audio and video).

* vCon - container for conversational information

* vCon instance - a vCon populated with data for a specific conversation

* vCon instance version - a single version of an instance of a convsersation, which may be modified to redact or append additional information  forming a subseqent vCon instance version

* vCon syntax version - the version for the data syntax used for form a vCon

* signed form - vCon in the signed (JWS) form

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

Files and data stored externally from the vCon MUST be "signed" to ensure that they have not been modified.
Objects that refer to a file which is externally stored from the vCon MUST have the parameters: url, alg and signature.  These parameters are defined in the following subsections.
The use of [SHA-512] hash for ensuring that the externnaly referenced data or file has not been modified, is defined in this document.
Other methods of ensuring integrity may be added in the future.
The following subsections define how the specific algoritym used and how that signature information is included in a vCon so that the content can be verified.

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

    + "SHA-512":  The algorithm used for signing the externally referenced file is defined in section 6.3 and 6.4 of [SHA-512].

### signature

The [SHA-512] hash on the externally referenced file is included in the signature string value.

* signature: "String"

    The string value of the signature parameter is the Base64Ulr Encoded value of the SHA-512 hash (as defined in section 6.3 and 6.4 [SHA-512]) of the body of the content at the given url.

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
The new vCon instance version SHOULD refer to the prior vCon instance version via the [redacted](#redacted) or [appended](#appended).

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

### redacted

A redacted vCon SHOULD provide a reference to the unredacted or prior, less redacted, vCon instance version of itself.
The purpose of the Redacted Object is to provide the reference to the unredacted or less redacted version of the vCon from which this vCon was derived.
For privacy reasons, it may be necessary to redact a vCon to construct another vCon without the PII.
This allows the non-PII portion of the vCon to still be analysed or used in a broader scope.
The Redacted Object SHOULD contain the uuid parameter or alteratively MAY include the vCon inline via the body and encoding parameters or alteratively the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).
If the unredacted vCon is included in the body, the unredacted vCon MUST be in the encrypted form.
If a reference to the unredacted vCon is provided in the url parameter, the access to that URL MUST be restricted to only those who should be allowed to see the identity or PII for the redacted vCon.

The method(s) for redaction of text, audio and video can be done with existing post processing of media.
The method of redaction is out of scope of this document.
The assurance of the accurace of the redaction is made by the entity that creates the redaction which SHOULD signe the redacted version of the vCon.

TODO: Do we need different levels of redaction?  If so, we need lables for the levels of redaction.

* redacted: "Redacted Object" (optional, mutually excliusive with appended and group parameters)

A Redacted Object contains the following parameters:

* uuid: "String" (optional if inline or external reference provided)

    The value contains the [uuid string value](#uuid) of the unredacted/original vCon instance version.

Alternatively, as defined in [Inline Files](#inline-files) body and encoding MAY be included:

* body: "String"
* encoding: "String"

Alterativelly, as defined in [Externally Referenced Files](#externally-referenced-files) url, alg and signature MAY be included:

* url: "String"
* alg: "String"
* signature: "String"

The following diagram illustrates a example JSON object tree for a redacted vCon.
The top level object is a JWS signed vCon which contains a vCon in the unsigned form in the payload parameter.
The second level object is the redacted vcon which refers to the encrypted unredacted vCon in it's redacted parameter.
Note that the redacted vCon may reference the JWE encrypted vCon either by UUID, URL or direct inclusion.
The JWE encrypted unredacted vCon contains the signed version of the unredacted vCon in the cyphertext parameter.
The signed unredacted vCon contains the unredacted vCon in the unsigned form in it's payload parameter.

~~~
{::include redacted-vcon-tree.ans}
~~~
{: #diagram1 title="redacted vCon object tree"}

### appended

A signed or encrypted vCon cannot be modified without invalidating it.
In these cases, to allow for adding of additional information a new vCon instance version MUST be created.
The prior vCon instance version is referenced by the Appended Object.
Then the appended information is added to the new vCon instance version (i.e. top level vCon object).

The prior vCon instance version SHOULD be referenced via the uuid of the prior vCon instance version, or alteratively MAY include the body and encoding parameters or alteratively the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

* appended: "Appended Object" (optional, mutually exclusive with redacted and group parameters)

The Appended Object contains the following parameters:

* uuid: "String" (optional if inline or external reference provided)

    The value contains the [uuid string value](#uuid) of the unredacted/original vCon instance version.

Alteratively, as defined in [Inline Files](#inline-files) body and encoding MAY be included:

* body: "String"
* encoding: "String"

Alteratively, as defined in [Externally Referenced Files](#externally-referenced-files) url, alg and signature MAY be included:

* url: "String"
* alg: "String"
* signature: "String"

### group Objects Array

The scope of a conversation is defined by the observer.  It may be any of the following in this non-exaustive list:

* a quick text exchange

* a simple 2-way call

* an evolving group chat

* a class lecture and question and answer session

* a web chat, evolving to a 2 way call, progressing to a transfered 3-way call transitioning to a video conference

* a series of weekly status calls

In support of these constructs, it may be desirable to aggregate a group of vCons as opposed to including all of the dialog in a single vCon.
The conversations may be over heterogenius or homogenius medium.
A vCon MAY aggregated a group of vCon instances in the group array, using a Group Object for each vCon instance.

* group: Group[] (optional, mutially exclusive with redacted and appended parameters)

    The group array contains a [Group Object](#group-object) for each vCon.

### parties Objects Array

The name, identity or contact information of all of the parties involved with the conversation are included in the parties object array.
Whether the parties were observers, passive or active participants in the conversation, they each are included as a Party Object in the parties array.

TODO: Should this be a object not an array to make it easier to append parties (i.e. indices of append vCons change when appended)?

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

Proof of authorization of the communation channel through STIR, login or possesion of a device, is often not sufficient proof of the identity of the persion at the other end of the communications channel.
It is common in call centers to validate the identity of the person on the communication channel through verification fo some sort of personal identication information.
The methods used, often varies with the situation and is business practices specific.
The purpose of the validation parameter, is to allow the validator to save a label or token which identifies the method of identity validation used to identify the person at the other end of the communication channel.
For security reasons, it SHOULD NOT contain the data used to validate the name.
However it MAY name the data used to validate the name (e.g. "SSN", "DOB", "user ID and password").

* validation: "String" (SHOULD be provided if name parameter is provided)

    The value of the validation string MAY be "none" or enterprise or domain defined token or string.

### jCard???

### gmlpos

The gmlpos parameter contains the latitude and longitude of the location of the party at the time of the conversation start.
This parameter contains a value of the same format as the gml:pos element defined in section 3.2 of the [PIDF-LO] PIDF.

* gmlpos: "String" (optional)

### civicaddress Object

The civicaddress object is optional and contains civic address information about the location for the party.
It MAY contain any or all of the following parameters: country, a1, a2, a3, a4, a5, a6, prd, pod, sts, hno, hns, lmk, loc, flr, nam, pc as defined in section 2.2.1 of [GEOPRIV].
The values of all of these parameters are of type String.
Note that the parameter names MUST be in lower case when contained in the civicaddress object even though they are in upper case in [GEOPRIV].

Do we need RFC6848 civic address extensions?

Is there a need for any temporal location?

Do we just specify fo rht e start of the conversation?

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

The Dialog Object SHOULD contain the body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

## Analysis Object

Analysis is a broad and in some cases developing field.
This document does not attempt to suggest a SHOULD support list of types.
Nor are formats for analysis data defined in this document.
That is for research and specification in a follow on document.
For this reason the Analysis Object provide multiple ways to define the media type of the analysis file.
If a well known media or mime type is defined, it SHOULD be used.
For analysis data or files types for which a media type is not defined, the vendor and schema parameters SHOULD be used.

### type

The type parameter is used to label the symatic type of analysis data.

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

* mimetype: "Mime" (optional for externally referenced files in which case, this is provided in the HTTPS Content-Type header)

    The mimetype string contains the media type or MIME type of the analysis file.

### filename

* filename: "String" (optional)

    The file name string contains an optional name for the analysis data file referenced in this Analysis Object.

### vendor

* vendor: "String"

    The vendor string value contains the vendor or product name of the software which generated this analysis.

### schema

* schema: "String" (optional)

    The schema string contains a token or label for the data format or schema for the analysis data.
    As the vendor name may not be specific enough to identify the format of the analysis, the schema value is provide to differentiate from potentially multiple data formats for analysis provided by the same vendor or software.

### Analysis Content

The Analysis Object SHOULD contain the body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

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

    The mimetype string contains the media type or MIME type of the attached file.

### filename

* filename: "String" (optional)

### Attachment Content

The Attachment Object SHOULD contain the body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

## Group Object

The Group Object SHOULD contain the uuid or body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).
The vCon MAY be referenced via UUID:

* uuid: uuid (optional)

Alternatively the vCon MAY be included in line as the value of the body parameter.
The encoding parameter MUST be included with the body parameter, if provided, to decribe the encoding of the vCon body.

* body: vcon (optional)

* encoding: "String"
    The encoding string MUST have the value: "json".

Alteratively, the vCon can be externally refernced.
The url, alg and signature parameters and values are defined in [Externally Referenced Files](#externally-referenced-files).

* url: "String"

* alg: "String"

* signature: "String"

# Security Considerations

The security concerts for vCons can put into two categories: making the conversation immutable through integrity verification and protecting the confidentiality of privacy of the parties to the conversation and their PII.
These requirements along with need to evolve a vCon (e.g. adding analysis, translations and transcriptions) conflict in some ways.
To enable this, multiple verisons of a vCon may be created.
Versions of a vCon may add information (e.g. analysis added to a prior vCon referenced by the [appended](#appended)) and versions that remove information (e.g. redactions of privacy information removed from the vCon referenced in the [redacted](#redacted)).
Redactions may be at different levels for example:

* PII masked to remove PII data in the text, audio, video or transcripts

* De-identified to remove segments or whole recordings that might be used for voice printing or facial recognition

Different parts and versions of a vCon may be created in different security domains over a period of time.
In addition, some conversation data may be referenced externally through an HTTPS URL as opposed to conpletely contained within the vCon.
Typically a conversation of one mode, will be hosted or observed in a single domain.
This will likely fall into one of the following hosting situations:

* Enterprise Hosted Communications

* Software as a Service (SaaS) Hosted Communications

* Service Provider Hosted Communications

The distinction among these has gotten clouded over recent years.
The import consideration is that each is a different security domain.
Information about a conversation captured in an enterprise communications system (e.g. meta data and Dialog Object(s) recorded in an IP PBX) is a differenct security domain from a SaaS transcription service (i.e. an Analysis Object).
When a vCon leaves a security domain, it SHOULD be signed to prevent it from being altered.
If the new security domain needs to alter it, a new vCon is created with the removed or added data and the prior version is referenced (i.e. via the [redacted](#redacted) or [appended](#appended)).
If informaiton is redacted for privacy reasons, the vCon referenced in the [redacted](#redacted), if inline, SHOULD be encrypted to protect the privacy information in the unredacted version of the vCon.

The secure storage and access of externally referenced conversation data is considered out of scope from this document.
Secure mechanisms for HTTPS access and storage of files are well defined.
Identity and cridentials for accessing externally stored data will be exchanged out of band from the vCon.
The one requirement for externally referenced data from the perspective of this document, is proof of integrety of that data.

Using the above described approach for redaction and appending of data, we can reduce the security operations on a vCon to signing and encryption.
Two approached to signing are needed as we have data, in JSON format, that is contained within the vCon and may have data (typically media and file formats, often binary) not contained, inline in the vCon, that is externally referenced.

Externally referenced data will be "signed" using [SHA-512] hash which along with the URL of the externally referenced data is included in the vCon.
[SHA-512] was chosen due to the relatively low cost to generate and verify the signature for what could be very large externally referenced media files.
As the hash for each externally referenced file is contained in the vCon which will also be signed, the chain of authentication is provided via the signature on the vCon itself.

This document specifies the JSON format for vCons.  So it seemed the logical solution for signing vCons, is JOSE [JWS] JSON Serialization and likewise for encrypting vCons is JOSE [JWE] JSON Serialization.  The solutions are well documents, implementations are readily available and tested.

* TODO: Rest of this section needs to be merged or re-written to go with the above

To be a conversation of record, vCon MUST be signed.

Methods of redaction exist for text, audio and video using post processing of the media.
The method of redaction used is out of the scope of this document.
A redacted vCon MAY reference it's non-redacted version.
The non-redacted version of the vCon referenced from the redacted vCon MUST be encrypted such that only those with permision to view the non-redacted content can decrypt it.

Any time a vCon is shared outside its original security domain, it SHOULD be signed and optionally encrypted.
Files externally referenced by a vCon SHOULD always be signed with the verification information included in the vCon that references the external file as defined in [#externally-referenced-files] and [#signing-exteranlly-referenced-files].
Externally referenced files SHOULD only be transported over [HTTPS] and SHOULD be access controlled to those who are permitted to read the contents of that entire vCon.
vCons transported over non-secure channels such as email MUST be in the encrypted form.

Need to explain typical storage contexts which may be more secure and storage contexts which are less secure.

## Signing Externally Referenced Files

In some deployments, it is not practical to include all of the file contents of a vCon inline.
In support of that, file may be externally referenced.
When external files are referenced, the signature on the vCon does not secure the file contents from modification.
For this reason any externally referenced files SHOULD also have a signature.
vCons use the [SHA-512] hash method for integrety checking of externally referenced file content and include its url, alg and signature in the vCon which are included in the integrety signature for the whole vCon.

After retriving externally referenced files, before using its content, the payload of the HTTPS request should be verified using the signature parameter value for the hash for the url body using the procedure defined in section 6.3 and 6.4 of [SHA-512].

## Signed Form of vCon Object

A signed vCon uses [JWS] and takes the General JWS JSON Serialization Syntax form as defined in section 7.2.1 of [JWS].

MUST include x5c or x5u in unprotected header.

* payload: "String"

    The value of the payload is the Base64Url Encoded string containing the unsigned JSON vCon.
    The general construction of the payload string value is described in section 7.2.1 of [JWK]

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

TODO: How to deal with expired signatures.

## Encrypted Form of vCon Object

TODO: Check this terminology:

A vCon MUST be signed first using JWS as defined in [Signed Form of vCon Object](#signed-form-of-vcon-object), then encrypted using JWE as opposed to just encrypted with integrety protection.
The rationalle is that meta data and dialog will typically be collected in one security domain, then may be stored or exported to another.
The signing is likely for the lifetime of the vCon, where the encryption may be shorter term or domain specific.vCons may be stored in unencrypted form, but the signed form MUST be maintained to ensure its integrity.

A encrypted vCon uses [JWE] and takes the form General JWE JSON Serialization Syntax form as defined in section 7.2.1 of [JWE].

vCon SHOULD be signed first, then signed form of vCon is plaintext to encryption????

* unprotected: "Unprotected"

* recipients: "Recipient[]"

* iv: "String"

    The string value of iv is the Initization Vector as constructed as defined in section 7.2.1 of [JWE].

* ciphertext: "String"

    The string value of ciphertext is constructed as defined in section 7.2.1 of [JWE] using the unsigned form of the vCon as the plaintext input for encryption.

* tag: "String"

    The string value of tag is the the Authentication Tag as defined in section 7.2.1 of [JWE].

### Unprotected Object

* cty: "String"

    The string value of cty SHOULD be "application/vcon"

* enc: "String"

### Recipient Object

* header: "Header"

* encrypted_key: "String"

    The string value of encrypted_key is defined in section 7.2.1 of [JWE].

### Header Object

* alg: "String"

    The string value of alg SHOULD be "RSA-OAEP".

# IANA Considerations

IANA registration of new media subtype: vcon for media type application:

    application/vcon


--- back

# Example vCons

## Two Party Call vCon With Inline Recording

~~~
{::include examples/ab_call_int_rec.pp}
~~~

## Text Chat vCon

## Email Thread vCon

## Two Party Call vCon With Externally Referenced Recording

~~~
{::include examples/ab_call_ext_rec.pp}
~~~

## Signed vCon
~~~
{::include examples/ab_call_ext_rec_signed.pp}
~~~

## Encrypted  vCon
~~~
{::include examples/ab_call_ext_rec_encrypted.pp}
~~~

## Redacted Signed vCon

## Ammended Signed vCon

## vCon Group


# Acknowledgments
{:numbered="false"}

TODO acknowledge.
