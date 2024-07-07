---
title: "The CDDL format for vCon - Conversation Data Container"
abbrev: "CDDL vCon"
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
 - conversation
 - vcon
 - CDR
 - call detail record
 - call meta data
 - call recordings
 - email thread
 - text conversation
 - video recording
 - video conference
 - conference recording
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

  RFC3339:

  GEOPRIV: RFC4119

  CBOR: RFC8949

  CDDL: RFC8610

  HTTPS: RFC9110

  JSON: RFC8259

  JWS: RFC7515

  JWE: RFC7516

  JWK: RFC7517

  MAILTO: RFC6068

  MIME: RFC2045

  PASSporT: RFC8225

  PIDF-LO: RFC5491

  TEL: RFC3966

  UUID: I-D.draft-peabody-dispatch-new-uuid-format

informative:

  ISOBMFF:
    target: https://www.iso.org/standard/83102.html
    title: "Information technology -- Coding of audio-visual objects -- Part 12: ISO base media file format"
    refcontent: ISO/IEC 14496-12:2022
    date: January 2022
    org: International Organization for Standardization

  JMAP: RFC8620

  JWT: RFC7519

  SHA-512: RFC6234

  SIP-XFER: RFC5589

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

--- abstract

A vCon is the container for data and information relating to a real-time, human conversation.
It is analogous to a {{vCard}} which enables the definition, interchange and storage of an individual's various points of contact.
The data contained in a vCon may be derived from any multimedia session, traditional phone call, video conference, SMS or MMS message exchange, webchat or email thread.
The data in the container relating to the conversation may include Call Detail Records (CDR), call meta data, participant identity information (e.g. STIR PASSporT), the actual conversational data exchanged (e.g. audio, video, text), realtime or post conversational analysis and attachments of files exchanged during the conversation.
A standardized conversation container enables many applications, establishes a common method of storage and interchange, and supports identity, privacy and security efforts (see {{vCon-white-paper}})

--- middle

# Introduction

The generation of conversational data, contained in transcripts and multi-media files, is common in business, especially in customer facing organizations.
However, the storage, analysis and sharing of the data they contain is not currently a standard.
Standardizing a container for conversation data (vCon) has numerous advantages, and enables the management of the conversation's content.
Very often the system providing the communications service, the consumer and/or owner of the communications data and the communications analysis services are distinct systems and in many case separate business entities.
The point of a vCon is to provide a standard means of exchanging communications data between these systems and services.
The use of vCons can ease service integration by using a common container and format for enterprise communications.
A vCon becomes the standardized input to communication analysis tools and machine learning and categorization.
For a sales lead organization, a vCon can be the container of assets sold to sales teams.
For conversations of record, the vCon can be a legal instrument.
For machine learning efforts, vCons can track what information was used in the training of models, so that as the result of a customer requested deletion of their data, the affected models can be identified.

## What's in a vCon?

A vCon contains four major categories of data: metadata , dialog , analysis and attachments.
The metadata portion allows for an expanded set of data from a typical call detail record ([CDR]), with identifications of the participants or parties to the conversation, references to related or earlier versions of the vCon.
The dialog portion contains a set of multimedia and mime elements, each representing the actual, physical conversation in it's original media form: text, audio or video.
The analysis portion contains data derived from the metadata and dialog portions, intended to carry items like transcripts, translations, summaries, text to speech, sentiment analysis and other semantic tagging.
Finally, the attachment portion contains any other documents, such as slide deck or sales lead information, which provides context and support for the conversation itself.
The vCon may also container integrity checking information such as the issuer of the vCon and tamperproof features such as signatures.

A vCon acts as the definition of the conversation, and are created by systems during and after the conversation itself.
Some communication modes, like SMS texting, lack natural session boundaries and require explicit definition.
vCons may have two or more parties involved, but at least one should be a human.
For instance, an interaction between a bot and a human is an appropriate scope for vCons, but a conversation between two bots would not.

Due to the size and complexity of some portions of a vCon, both inline and externally referenced dialog, analysis, attachments and other vCon reference assets are supported.
For instance, vCons may reference a videoconference media recording as an external URL with an accompanying signature of the contents to detect tampering.
Alternatively, vCons may directly contain the media of the entire dialog internally, keeping the conversation in one place, and optionally encrypted.

vCons are designed to be a digital asset, versioned and signed.
For instance, different versions of vCon may arise due to redaction (e.g. for PII or other reasons), added analysis or the addition of other content.
In the metadata, vCons contain the unique ID of the parent vCon, such that they may be traversed while maintaining their data integrity and provenance.

## Use Cases and Requirements

In large enterprises, different products may be served by different call centers (inhouse or out sourced).
The call centers may have different communications infrastructure and even different platform vendors (e.g. IP PBX, email servers).
Consequently, the CDR and meta data as well as the conversation recordings may be stored in different formats and locations.
This creates artificial silos of storage and analysis.
Using vCon as a standard exchange, storage, analysis input and output format, would ease integration efforts and cross enterprise analysis of products and call center metrics.
This would also ease customer analysis across product lines which may currently be difficult due to separated, heterogeneous communications silos.
Having conversation data in the vCon format would lower the cost and speed deployment of both inhouse and outsourced analysis tools for import into ML and AI based tools, transcription, translation and sentiment analysis.
Having conversation data in a standard vCon container would ease the export of conversation data from hosted services.
This would enable more analysis capabilities.

In some locations, regulations make it mandatory for enterprises to delete private information upon request of the individual.
Large enterprises with siloed communications systems have difficulty locating or identifying all of the private data for an individual due to the disparate communications systems.
Using the vCon as the standard container for all communications system, storing the conversation data centrally and removing it from the siloed communications systems, allows for easier management, correlation, tracking and deletion of individual's private data.
Without centralizing the storage of the conversations in a standardized container, deleting an individuals private data is untenable and the enterprise cannot assert that they have fulfilled their requirement to locate and delete all of the private data.

Large call centers may have tens of thousands of call agents making hundreds of thousands of calls a day.
Supervising the agents and calls in a large call center is a huge efort.
Using vCons to capture all of the conversations for all of the agents, enables more automation of evaluation, training and coaching of call center agents.
DEVOPS tools such as checking for conversation with too low a volume or agents with faulty headsets becomes easier and less costly using vCons.
Call centers often have to provide service level proof and reports to their customers.
These service level evaluations, monitoring and reporting can be more easily provided and at a lower cost via third party solutions with vCons as a standard conversation container.

Conversations can have legal and regulatory significance.
Regulations may require conversation of record to be stored for compliance.
A conversation can become a verbal contract, making the conversation data a legal instrument.
Having a standard container for the conversation data and asserting the integrity of the data make it easier to distribute the conversation data to the parties involved.

The initial set of use cases for vCons are expected to be in the interchange between front end and back end application and lower layers of the network stack, critical for enablement of analysis of conversations.
It is expected that JavaScript handling of vCons in the front end and RESTful interfaces and back end platforms will be used for operations and manipulation of vCons.
Many media analysis services which will be used with vCons, such as transcription, already use JSON based interfaces.
For this reason, JSON has been chosen for the initial format binding of vCons and the scope of this document.
The [CDDL] schema definition for vCon is included in [vCon CDDL Schema](#vcon-cddl-schema) to enable formatting vCOn in either [JSOn] or [CBOR] formats.
Other bindings may be consider for vCon in the future in other documents.

Requirements:

* Standardize container for conversational data exchange

* Consolidation of data and information for a conversation

* Multiple modes of communication, changing over time

* Snapshots of conversation during or once completed along with analysis

* Ease of integration of services and analysis

* Better organize conversational data so that it can be handled in a consistent, privacy safer means

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

* Standardization of analysis data formats or file media types

# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

* analysis - analysis, transformations, summary, sentiment, or translation typically of the dialog data

* conversation - an exchange of communication using text, audio or video medium between at least one human and one or more bots or humans

* de-identification - removal of all information that could identify a party in a conversation.  This includes PII as well as audio and video recordings.  Voice recordings might be re-vocalized with a different speaker.

* dialog - the captured conversation in its original form (e.g. text, audio or video)

* encrypted form - encrypted JWE document with the JWS signed vCon form contained in the ciphertext

* file - a data block either included or referenced in a vCon

* object - JSON object containing key and value pairs

* parameter - JSON key and value pair

* party - an observer or participant to the conversation, either passive or active

* payload - the contents or bytes that make up a file

* PII - Personal Identifiable Information

* PII masked - may include voice recordings, but PII is removed from transcripts and recordings (audio and video).

* vCon - container for conversational information

* vCon instance - a vCon populated with data for a specific conversation

* vCon instance version - a single version of an instance of a conversation, which may be modified to redact or append additional information  forming a subsequent vCon instance version

* vCon syntax version - the version for the data syntax used for form a vCon

* signed form - JWS signed document with the unsigned vCon form contained in the payload

## JSON Notation

For the ease of documentation, the convention for [JSON] notation used in this document is copied from sections 1.1-1.5 of [JMAP].
It is also acceptable to format vCon using [CBOR].
It is intended that both of these formats are easily coverted to the other and that the parameters and objects are compatible with the exceptions of binary parameters which are express in [BASE64URL] in [JSON] and binary text in [CBOR].
[CCDL] provides for this dualality with type 6.21.

Date - A string that MUST have the form of an [RFC3339] date string as defined for the Date type in section 1.4 of [JMAP].

"String" - a JSON string type

"UnsignedInt" - a positive JSON integer as defined in section 1.3 of [JMAP].

"UnsignedFloat" - a positive JSON floating point number containing a decimal point as defined in section 6 of [JSON].

"Mime" - A "String" value that MUST be of the following form as defined in section 5.1 of [MIME]:
    type "/" subtype

"A[]" and array of values of type A.

All parameters are assumed to be mandatory unless other wise noted.

Objects or arrays with no or null values MAY be excluded from the vCon.

## Inline Files

Objects that contain a file or data inline (i.e. within the vCon) MUST have the parameters: body and encoding.
JSON does not support binary data values.
For this reason inline files MUST be base64url (see Section 2 [JWS]) encoded to be included as a valid JSON string value if they are not already valid JSON strings.

### body

The body parameter contains the payload of the file to be included inline.  Depending upon the data in the file, it may require encoding to be used as a valid JSON string value.

* body: "String"

### encoding

The encoding parameter describes the type of encoding that was performed on the string value of the body parameter.

* encoding: "String"

    This MUST be one of the following strings:

    * "base64url": The payload of the file has been base64url encoded and provided as the string value of the body parameter.

    * "json": The value of the body string is a JSON object.

    * "none": The payload of the file is a valid JSON string and can be included without modification as the string value to the body parameter.

## Externally Referenced Files

Files and data stored externally from the vCon MUST be "signed" to ensure that they have not been modified.
Objects that refer to a file which is externally stored from the vCon MUST have the parameters: url, alg and signature.  These parameters are defined in the following subsections.
The use of [SHA-512] hash for ensuring that the externally referenced data or file has not been modified, is defined in this document.
Other methods of ensuring integrity may be added in the future.
The following subsections define how the specific algorithm used and how that signature information is included in a vCon so that the content can be verified.

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

    The string value of the signature parameter is the Base64Url Encoded value of the SHA-512 hash (as defined in section 6.3 and 6.4 [SHA-512]) of the body of the content at the given url.

# vCon JSON Object

The JSON form of a vCon is contained in a JSON object in one of three forms:

* unsigned
* signed
* encrypted

The unsigned form of the vCon has a single top level object.
This top level vCon object is also contained as described in the [signed](#signed-form-of-vcon-object) and [encrypted](#encrypted-form-of-vcon-object) forms of the vCon.
The selection of the JSON format enables interchange between application and lower layers of the network stack, critical for enablement of analysis of conversations.

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
The new vCon instance version SHOULD refer to the prior vCon instance version via the redacted ([redacted](#redacted)) or appended ([appended](#appended)) parameters.

## vCon JSON Object Keys and Values

The keys and values for the top level vCon JSON object are defined in the following subsections.

### vcon

The the value of vcon parameter contains the syntactic version of the JSON format used in the vCon.

* vcon: "String"

    For syntax defined in this document, the string MUST have the value: "0.0.1"

### uuid

The [UUID] for the vCon is used to refer to it when privacy or security may not allow for inclusion or URL reference to a vCon.
The UUID MUST be globally unique.

* uuid: "String"

    The value of the string SHOULD be generated using the version 8 UUID defined in [UUID] which is generated identically to a version 7 UUID with the exception that:

    * rand_b/custom_c is generated from the high 62 bits of the SHA-1 hash of the FQHN string

    * the variant and version fields are set as described for version 8 UUID

    The DNS name string used in generating the uuid value SHOULD be the same FQHN, or a subdomain to allow for more distributed generation of UUIDs, as would used in the signing certificate as they are the same domains of uniqueness.

### created_at

The created_at parameter provides the creation time of this vcon, which MUST be present, and should not changed once the vcon object is created.

* created_at: "Date"

### updated_at

The updated_at parameter provides the last modified time of this vcon, which MAY be present.
For unsigned forms, the updated_at of the vcon object SHOULD be updated as it is modified.
For signed forms of the vCon object, the updated_at contains the time when this vcon was last signed. Future updates MUST first set the updated_at to the new signing time as the vcon object is signed again.

* updated_at: "Date"

### subject

The subject or the topic of the conversation is provided in the subject parameter.
This parameter is optional as not all conversations have a defined subject.
Email threads and prescheduled calls and video conferences typically have a subject which can be captured here.
The subject may also be derived from analysis of the dialog.

* subject: "String" (optional)

    The string value of the subject parameter is a free formed JSON string with no constrained syntax.

### redacted

A redacted vCon SHOULD provide a reference to the unredacted or prior, less redacted, vCon instance version of itself.
The purpose of the Redacted Object is to provide the reference to the unredacted or less redacted version of the vCon from which this vCon was derived.
For privacy reasons, it may be necessary to redact a vCon to construct another vCon without the PII.
This allows the non-PII portion of the vCon to still be analyzed or used in a broader scope.
The Redacted Object SHOULD contain the uuid parameter and MAY include the vCon inline via the body and encoding parameters or alternatively the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).
If the unredacted vCon is included in the body, the unredacted vCon MUST be in the encrypted form.
If a reference to the unredacted vCon is provided in the url parameter, the access to that URL MUST be restricted to only those who should be allowed to see the identity or PII for the redacted vCon.

The method(s) for redaction of text, audio and video can be done with existing post processing of media.
The method of redaction is out of scope of this document.
The assurance of the accuracy of the redaction is made by the entity that creates the redaction which SHOULD sign the redacted version of the vCon.

All data and parameters in the prior, less redacted, vCon instance version are either:

* Removed entirely in the redacted version
* Copied and partially redacted
* Copied as is

Data which is to be completely removed from the redacted version, that is contained in a JSON array in the unredacted vCon, SHOULD create an empty placeholder such that object array indices do not change for the rest of the elements of the array.

* redacted: "Redacted" (optional, mutually exclusive with appended and group parameters)

A Redacted Object contains the following parameters:

* uuid: "String"

    The value contains the [uuid string value](#uuid) of the unredacted/prior vCon instance version.
    The absence of a value for uuid indicates that the less redacted version of this vCon is not available or does not exist.

* type: "String"

    The value of the redacted type parameter is used to indicate the type of redaction that was performed on this vCon relative to the less redacted version referenced by the redacted uuid parameter.
    This should indicate the type of information that was redacted.

As defined in [Inline Files](#inline-files) body and encoding MAY be included:

* body: "String"
* encoding: "String"

Alternatively, as defined in [Externally Referenced Files](#externally-referenced-files) url, alg and signature MAY be included:

* url: "String"
* alg: "String"
* signature: "String"

The following diagram illustrates an example partial JSON object tree for a redacted vCon.
The top level object is a JWS signed vCon which contains a vCon in the unsigned form in the payload parameter.
The second level object is the redacted vcon which refers to the encrypted unredacted vCon in it's redacted parameter.
Note that the redacted vCon references the JWE encrypted vCon by UUID and may reference it by URL or direct inclusion.
The JWE encrypted unredacted vCon contains the signed version of the unredacted vCon in the ciphertext parameter.
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

The prior vCon instance version SHOULD be referenced via the uuid of the prior vCon instance version, and MAY include the body and encoding parameters or alternatively the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

* appended: "Appended" (optional, mutually exclusive with redacted and group parameters)

The Appended Object contains the following parameters:

* uuid: "String" (optional if inline or external reference provided)

    The value contains the [uuid string value](#uuid) of the unredacted/original vCon instance version.

Alternatively, as defined in [Inline Files](#inline-files) body and encoding MAY be included:

* body: "String"
* encoding: "String"

Alternatively, as defined in [Externally Referenced Files](#externally-referenced-files) url, alg and signature MAY be included:

* url: "String"
* alg: "String"
* signature: "String"

The following figure illustrates an example partial JSON object tree for an appended vCon.
The top level object is the JWS signed appended vCon which contains the unsigned form of the vCon in it's payload parameter.
The second level object is the appended vCon with additional conversational data (e.g. analysis data).
It refers to its original parent (or prior vCon instance version) of the vCon in its appended parameter.
Note: the appended parameter may include the original in the body parameter or refer to it via URL.
The appended vCon in this figure refers to the JWS signed version of the vCon, which in turn contains the original vCon in unsigned form in its payload parameter.

~~~
{::include appended-vcon-tree.ans}
~~~
{: #diagram2 title="appended vCon object tree"}

### group Objects Array

The scope of a conversation is defined by the observer.  It may be any of the following in this non-exhaustive list:

* a quick text exchange

* a simple 2-way call

* an evolving group chat

* a class lecture and question and answer session

* a web chat, evolving to a 2 way call, progressing to a transferred 3-way call transitioning to a video conference

* a series of weekly status calls

In support of these constructs, it may be desirable to aggregate a group of vCons as opposed to including all of the dialog in a single vCon.
The conversations may be over heterogeneous or homogeneous medium.
A vCon MAY aggregated a group of vCon instances in the group array, using a Group Object for each vCon instance.

* group: "Group[]" (optional, mutually exclusive with redacted and appended parameters)

    The group array contains a [Group Object](#group-object) for each vCon.

### parties Objects Array

The name, identity or contact information of all of the parties involved with the conversation are included in the parties object array.
Whether the parties were observers, passive or active participants in the conversation, they each are included as a Party Object in the parties array.

TODO: Should this be a object not an array to make it easier to append parties (i.e. indices of append vCons change when appended)?

* parties: "Party[]"

    The value of the parties parameter is an array of [Party Objects](#party-object).

### dialog Objects Array

The actual conversation which occurred over text, audio or video that was captured, is contained in the dialog Objects Array.

* dialog: "Dialog[]" (optional)

    The value of the dialog parameter is an array of [Dialog Objects](#dialog-object).

### analysis Objects Array

Analysis, which is performed on the conversational data, is stored in the analysis Objects array.

* analysis: "Analysis[]" (optional)

    The value of the analysis parameter is an array of [Analysis Objects](#analysis-object).

### attachments Objects Array

Ancillary documents, discussed, presented, referenced or related to the conversation may be stored in the attachments array.

* attachments: "Attachment[]" (optional)

    The value of the attachments parameter is an array of [Attachment Objects](#attachment-object).

## Party Object

### tel

If the tel URL for the party is known, it can be included in the tel parameter.

* tel: "String" (optional)

    The value of the tel parameter SHOULD be a valid [TEL] URL.  The URL scheme prefix (i.e. "tel:") is optional.


### stir

If the STIR [PASSporT] was provided to identify the party, the PASSporT can be included in the stir parameter for the party.

* stir: "String" (optional)

    The string value of the stir parameter contains the [PASSporT] in the JWS Compact Serialization form.

### mailto

If the mailto URL is known for the party, it can be included in the mailto parameter.

* mailto: "String" (optional)

    The value of the mailto parameter is a string of the format of a valid [MAILTO] URL.  The URL scheme prefix (i.e. "mailto:") is optional.

### name

If the party's name is known, it can be included in the name parameter.

* name: "String" (optional)

    The string value of the name parameter is a free form JSON string in which part or all of the party's name can be included.

### validation

Proof of authorization of the communication channel through STIR, login or possession of a device, is often not sufficient proof of the identity of the person at the other end of the communications channel.
It is common in call centers to validate the identity of the person on the communication channel through verification of some sort of personal identification information.
The methods used, often varies with the situation and is business practices specific.
The purpose of the validation parameter, is to allow the validator to save a label or token which identifies the method of identity validation used to identify the person at the other end of the communication channel.
For confidentially reasons, it SHOULD NOT contain the data used to validate the name.
However it MAY name the data used to validate the name (e.g. "SSN", "DOB", "user ID and password").
It is up to the domain creating the vCon to define the set of tokens or values to be used for the validation parameter.

* validation: "String" (SHOULD be provided if name parameter is provided)

    The value of the validation string MAY be "none" or enterprise or domain defined token or string values.

### jCard

TODO: Do we want to support including a jCard for the party?

### gmlpos

If the geolocation of the party is known, it can be added in the gmlpos parameter.
The gmlpos parameter contains the latitude and longitude of the location of the party at the time of the conversation start.

* gmlpos: "String" (optional)

    The gmlpos parameter value contains a string of the same format as the gml:pos element defined in section 3.2 of the [PIDF-LO] PIDF.

### civicaddress

The the civicaddress parameter value contains a Civicaddress Object which is optional and contains civic address information about the location for the party.

* civicaddress: "Civicaddress" (optional)

The Civicaddress Object MAY contain any or all of the following parameters: country, a1, a2, a3, a4, a5, a6, prd, pod, sts, hno, hns, lmk, loc, flr, nam, pc as defined in section 2.2.1 of [GEOPRIV].
The values of all of these parameters are of type String.
Note that the parameter names MUST be in lower case when contained in the Civicaddress Object even though they are in upper case in [GEOPRIV].

* country: "String" (optional)
* a1: "String" (optional)
* a2: "String" (optional)
* a3: "String" (optional)
* a4: "String" (optional)
* a5: "String" (optional)
* a6: "String" (optional)
* prd: "String" (optional)
* pod: "String" (optional)
* sts: "String" (optional)
* hno: "String" (optional)
* hns: "String" (optional)
* lmk: "String" (optional)
* loc: "String" (optional)
* flr: "String" (optional)
* nam: "String" (optional)
* pc: "String" (optional)

TODO: Do we need RFC6848 civic address extensions?

TODO: Is there a need for any temporal location?  For example should location be an array, each element with a time stamp?

TODO: Do we just specify for the start of the conversation?

### timezone

TODO: timezone for the location of the party?

### uuid

The uuid is a unique identifier for the participant.
In a contact center, this is particularly important for the call agent participant, and must be static across interactions to allow correlation with the actual agent configuration provisioned into the systems.

* uuid: "String" (optional)


### role

The role that the participant played in the conversation.
In a call center there are roles: such as: agents, customer, supervisor and specialist.
In conferences there are roles: host, cohost, speaker, panelist, participant and other roles.
The role parameter provides the ability to label the role that the part played in the conversation.

* role: "String" (optional)

The following values for the role parameter MAY be used:

  + "agent"
  + "customer"
  + "supervisor"
  + "sme" (for subjet mater expert)
  + "thirdparty"

Other values for the role parameter MAY also be used.

### contact_list

In a contact center scenario, the conversation with this party may be part of a larger effort of contacting a group of parties, individually or perhaps in groups.
It is sometimes useful to reference the list from which this party was included.
The contact_list may be used as a label for foreign key reference to the contact list that this party was on.

*  contact_list "String" (optional)

## Dialog Object

The Dialog object references or contains text, audio or video captured from the conversation.
Currently two types of dialog objects are defined in this document.
One for text media and the other for audio or video recording files.

TODO: Is there other signalling data that we want to capture other than start and duration and the media (e.g. from jabber, sms, mms, email, SIP, etc.)?

### type

* type: "String"

    The sting MUST have the value of either "recording", "text", "transfer" or "incomplete".
    A dialog of type "recording" has Dialog Content that either contains a body or refers to via url, which is a recording of the video and/or audio of a segment of the conversation.
    A dialog of type "text" had  has Dialog Content that either contains a body or refers to via url, which contains the text from one of the parties for a segment of the conversation.
    A dialog of type "transfer" does not capture actual conversation exchange, but rather captures operations, parties and relations between dialog segments.
    A dialog of type "incomplete" or "transfer" MUST NOT have Dialog Content.
    In the "incomplete" case the call or conversation failed to be setup to the point of exchanging any conversation.
    Incomplete dialogs MUST have a disposition parameter which indicates why the call or conversations failed.
    In the "transfer" case, the conversation is recorded in other dialogs.
    The Dialog Transfer parameters, are used to show the roles and relationships between the parties and other dialogs as the transfer process occurred.


### start

The start parameter contains the date and time for the beginning of the captured piece of dialog.
For text it is the time that the party started typing or if not available, then it is the time the text was sent.
For audio and video recordings, it is the time which corresponds to the beginning of the recording.

* start: "Date"

### duration

The duration parameter contains the duration in seconds of the referenced or included piece of dialog.
For text, if known, it is the time duration from when the party started typing to when they completed typing and the text was sent.
For recordings, it is the duration of the recording.

* duration: "UnsignedInt" \| "UnsignedFloat" (optional)

    The value MUST be the dialog duration in seconds.

### parties

The party(s) which generated the text or recording for this piece of dialog are indicated in the parties parameter.

* parties: "UnsignedInt" \| "UnsignedInt[]" \| ("UnsignedInt" \| "UnsignedInt[]")[]

    Single channel recordings should have a parties value of the form: "UnisignedInt" or "UnsignedInt[]" where the integer value or array of integer values are the indices to the Party Object(s) in the parties array that contributed to the mix for the single channel recording.
    The index for the Party Object SHOULD be included even if the indicated party was silent the entire piece of dialog.

    Multi-channel recordings MUST have a parties value that is an array of the same size as the number of channels in the recording.
    The values in that array are either an integer or an array of integers which are the indices to the parties that contributed to the mix for the associated channel of the recording.
    The index for Party Objects SHOULD be included even if the party was silent the entire conversation.

    It is implied that the first party in the dialog Object parties list, is the originator of the dialog.
    However, in some situations, it is difficult to impose the constraint that the first channel of a recording is the originator.
    If ensuring that the first channel and party listed is the originator is not possible, the optional originator parameter indicates the originator party.
    In other cases, there may be a separate recording file for each party in a conversation, where only one party is recorded per file.
    In this situation, it is necessary to indicate the originator as the dialog Object parties parameter will contain only one party and may not be the originator.

TODO: For an email thread, To and Cc parties are all passive.  Do we just put the sender as the party or do we want to list all of the recipients and by convention the sender is the first party?  Note that each dialog/email could have a difference set of recipients.

### originator

The originator party for this dialog.
For email and text, this is the sender of the text.
For audio and video, this is the caller or host of the call or conference.
The originator parameter is only provided if the first party of the dialog Object parties list is NOT the originator.

* originator: "UnsignedInt" (optional)

    The originator value is the index into the parties Objects Array, to the party that originated the dialog.

### mimetype

The media type for the piece of dialog included or referenced is provided in the mimetype parameter.
The mimetype parameter MUST be provided for inline dialog files and MUST be provided if the Content-Type header in the [HTTPS] response for the externally referenced URL is not provided.

* mimetype: "Mime" (optional for externally referenced files)

    The media types SHOULD be one of the following strings:

    * "text/plain"
    * "audio/x-wav"
    * "audio/x-mp3"
    * "audio/x-mp4"
    * "audio/ogg"
    * "video/x-mp4"
    * "video/ogg"
    * "multipart/mixed"

    Note: multi-part will also likely include the boundary parameter

### filename

It is sometimes useful to preserve the name of the file which originally contained this piece of dialog.
This can be done in the filename parameter.

* filename: "String" (optional)

### Dialog Content

The Dialog Object SHOULD contain the body and encoding parameters or the url, alg and signature parameters for all dialog types other than "incomplete" and "transfer", these parameters MUST NOT be present for "incomplete" or "transfer" dialog types (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

For inline included dialog:

* body: "String"
* encoding: "String"

Alternatively, for externally referenced dialog:

* url: "String"
* alg: "String"
* signature: "String"

### disposition

If the dialog type is "incomplete", it must have a disposition parameter.
The value of the disposition parameter provides the reason that the "call control" failed.
The term: "call control" is used in a loose sense, as there in not always a call involved, to differentiate from a call disposition that an agent may assign to a call to indicate the reason, issue addressed or outcome of a conversation.
This latter definition of call disposition is not dialog, but analysis of the conversation and is not included in the dialog portion.

* disposition: "String" (required for incomplete type dialogs, SHOULD NOT be present for other dialog types)

    The value of the disposition parameter MUST be one of the following string:

    * "no-answer" - a call or connection was attempted, but no one answered or accepted the connection
    * "congestion" - a call or connection was attempted, but was unable to be completed due to system load
    * "failed" - a call or connection was attempted, but failed
    * "busy" - a call or connection was attempted, but the party was busy with another conversation
    * "hung-up" - a call or connection was made, but the party hung-up before any conversation occurred
    * "voicemail-no-message" - a call or connection was made, the voicemail system answered, but no message was left

    Note: if a message was left with the voicemail system this is no longer an "incomplete" type dialog, it is a "recording" type and the conversation SHOULD be included in the Dialog Content.

### party_history Objects Array

Participants in a dialog may not all join and leave at the same time.
To support the capturing of the information when parties join, drop, go on hold or mute and unmute, the party_history array may be added to the Dialog Object.

* party_history: "Party_History[]" (optional)

#### Party_History Object

The Party_History Object contains the following parameters:

* party: "UnsignedInt"

    The index of the party for this event.

* event: "String"

    The string token for the event which MUST be one of the following:

    * "join" - when the party joins the dialog

    * "drop" - when the party drops out of the dialog

    * "hold" - when the party is put on hold

    * "unhold" - when the part is taken off hold

    * "mute" - when the party is muted

    * "unmute" - when the part is taken off mute

* time: "Date"

### Dialog Transfer

A dialog of type "transfer" documents the rolls of three parties and the relationship between 2 or three dialog segments.
In a transfer operation, the roles of the three parties to a transfer are defined in [SIP-XFER] as:

    * Transferee
    * Transferor
    * Transfer Target

There are two or three calls in which the parties are connected:

    * original call
    * consultative call (optional as this call may not get created)
    * target call

To capture the above roles and dialog segments, the following parameters are defined and SHOULD be present in the "transfer" type dialog and MUST NOT be present in other dialog types.

    * transferee: "UnsignedInt"

    The value of the transferee parameter is the index into the parties Object array to the party that played the role of the Transferee.

    * transferor: "UnsignedInt"

    The value of the transferor parameter is the index into the parties Object array to the party that played the role of the Transferor.

    * transfer-target: "UnsignedInt"

    The value of the transfer-target parameter is the index into the parties Object array to the party that played the role of the Transfer Target.

    * original: "UnsignedInt"

    The value of the original parameter is the index into the dialogs Object array to the "recording" or "text" type dialog for the original dialog between the Transferee and the Transferor.

    * consultation: "UnsignedInt" (optional)

    The value of the consultation parameter is the index into the dialogs Object array to the "recording", "text" or "incomplete" type dialog for the consultative dialog between the Transferor and the Transfer Target.

    * target-dialog: "UnsignedInt"

    The value of the target-dialog parameter is the index into the dialogs Object array to the "recording", "text" or "incomplete" type dialog for the target dialog between the Transferee and the Transfer Target.

    A "transfer" type dialog MUST NOT contain the parties, originator, mimetype, filename or Dialog Content parameters.

The "transfer" type dialog only captures the roles, operations and events of the parties and the dialog setup.
It does not capture the purpose or reason for the transfer as that is analysis to be captures in the analysis section of the Vcon after the conversation has occurred.

### campaign

In a contact center scenario, a dialog may be initiated as part of a campaign or set of dialogs initiated with a common goal or focus or to be handled or treated in a specific way.
The campaign parameter is string that may be used as a label or foreign key in reference to an external specification for how the communication is to be initiated, handled or treated.
In some case it may be appropriate to attached the campaign data as an Attachment Object.

* campaign: "String" (optional)

### interaction

In a contact center scenario, interactions with a party are often labeled.
In some case the interaction is contained in a single dialog.
In others there may be multiple dialogs (e.g. messages or calls) that are all part of a single interaction.
There may also be many interactions for a single conversation or vCon.
The interaction parameter is used as a label or foreign key in reference to the interaction ID.

* interaction "String" (optional)

### skill

A contact center may service multiple purposes or customers.
In this scenario it is important to label the conversation segment or dialog.
The agent or automita which services the dialog are required to have a specific skill.
To facilitate this in a vCon dialog, the skill parameter is provided.
The string values of the skill parameter are contact center specific.

* skill "String" (optional)

## Analysis Object

Analysis is a broad and in some cases developing field.
This document does not attempt to suggest a SHOULD support list of types.
Nor are formats for analysis data defined in this document.
That is for research and specification outside the scope of this document.
For this reason the Analysis Object provides multiple ways to define the media type of the analysis file.
If a well known media or mime type is defined, it SHOULD be used.
For analysis data or files types for which a media type is not defined, the vendor and schema parameters SHOULD be used.

### type

The type parameter is used to label the semantic type of analysis data.

* type: "String"

    The string value SHOULD be one of the following:

    * "summary"
    * "transcript"
    * "translation"
    * "sentiment"
    * "tts"

### dialog

Analysis typically pertains to one or more of the Dialog Objects in the dialog array.
The dialog parameter is used to indicate which Dialog Objects this analysis was based upon.

* dialog: "UnsignedInt" \| "UnsignedInt[]" (optional only if the analysis was not derived from any of the dialog)

    The value of the dialog parameter is the index to the dialog or array of indices to dialogs in the dialog array to which this analysis object corresponds.

### mimetype

The media type for the included or referenced analysis file is provided in the mimetype parameter.

* mimetype: "Mime" (optional for externally referenced files, if it this is provided in the [HTTPS] Content-Type header)

    The mimetype string contains the media type or [MIME] type of the analysis file.

### filename

It is sometimes useful to preserve the name of the file which originally contained this analysis data.
This can be done in the filename parameter.

* filename: "String" (optional)

    The file name string contains an optional name for the analysis data file referenced in this Analysis Object.

### vendor

There may not be a IANA registered media type for the file format containing the analysis data.
Even if a media type is defined, it is often useful to keep a record of the vendor that produced the software that produced the analysis.
Different implementations perform differently and knowing the implementation can be useful in interpreting the analysis.
For this reason, the vendor or product name is provided in the vendor parameter.

* vendor: "String"

    The vendor string value contains the vendor or product name of the software which generated this analysis.

### product

As the vendor may have more than one product, the product parameter may be used to differentiate it from other products which may have different schemas of analysis data.

* product: "string" (optional)

### schema

The same vendor or software product may produce different formats or data for the same analysis.
The schema parameter allows the data format, schema or configuration used to generate the analysis to be saved with the included or referenced analysis data.

* schema: "String" (optional)

    The schema string contains a token or label for the data format or schema for the analysis data.
    As the vendor name may not be specific enough to identify the format of the analysis, the schema value is provide to differentiate from potentially multiple data formats for analysis provided by the same vendor or software.

### Analysis Content

The Analysis Object SHOULD contain the body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

For inline included analysis:

* body: "String"
* encoding: "String"

Alternatively, for externally referenced analysis:

* url: "String"
* alg: "String"
* signature: "String"

## Attachment Object

Ancillary documents to the conversation are included or referenced in the Attachment Object.
There is no constraint on the types files which can be included or referenced.
As most modes of communication, that allow the exchange of files, do not constrain the file type, any file type may be included here.

### type or purpose

TODO: Do we want a semantic type like: contract or presentation?  Or a subject or title.

### start

The start parameter contains the date and time that the Attachment Object was sent/exchanged.

* start: "Date"

### party

In most conversations, ancillary documents originate from one of the parties to the conversation.
This is not necessarily the author, but the person who distributed the document.
This party is identified by the party parameter in the Attachment Object.

* party: "UnsignedInt"

    The value of the party parameter is the index into the Parties Object array to the party that contributed the attachment.

### mimetype

The media type for the included or referenced attachment file is provided in the mimetype parameter.

* mimetype: "Mime" (optional for externally referenced files, if it this is provided in the [HTTPS] Content-Type header)

    The mimetype string contains the media type or [MIME] type of the attached file.

### filename

It is sometimes useful to preserve the name of the file which originally contained this attachment file.
This can be done in the filename parameter.

* filename: "String" (optional)

    The file name string contains an optional name for the attachment file referenced in this Attachment Object.

### Attachment Content

The Attachment Object SHOULD contain the body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).

For inline included attachments:

* body: "String"
* encoding: "String"

Alternatively, for externally referenced attachments:

* url: "String"
* alg: "String"
* signature: "String"

## Group Object

A conversation may have take place using different modes (e.g. web chat which evolves to email, which evolves to phone call, which evolves to video conference).
A conversation could take place over several calls (e.g. multiple calls regarding a support incident or problem).
Each of these examples might be considered a single conversation event though there are multiple sets of dialog in each.
What is considered the boundary of a conversation is a business decision.
There are situations in the above example, where it is desired to treat these as a single conversation, but each set of dialog is created in a single vCon (e.g. each dialog occurred in a separate communication silo or security domain) which gets signed.
For this reason, it may be necessary to aggregate the separate vCon into a single vCon which is considered the whole of a conversation.
The Group Object includes or refers to a vCon to be aggregated into the whole of a single vCon conversation.

The Group Object SHOULD contain the uuid and either the body and encoding parameters or the url, alg and signature parameters (see [Inline Files](#inline-files) and [Externally Referenced Files](#externally-referenced-files)).
The vCon MAY be referenced via UUID:

* uuid: "String"

    The value of the uuid parameter, is the [uuid string value](#uuid) of the referenced vCon to be aggregated.

The vCon MAY be included in line as the value of the body parameter.
The encoding parameter MUST be included with the body parameter, if provided, to describe the encoding of the vCon body.

* body: "vCon"

    The JSON unsigned form of the vCon, the JWS signed form of the vCon or the JWE encrypted form of the vCon.

* encoding: "String"

    The encoding string MUST have the value: "json".

Alternatively, the vCon can be externally referenced.
The url, alg and signature parameters and values are defined in [Externally Referenced Files](#externally-referenced-files).

* url: "String"
* alg: "String"
* signature: "String"

# Security Considerations

The security concerns for vCons can put into two categories: making the conversation immutable through integrity verification and protecting the confidentiality of privacy of the parties to the conversation and/or their PII.
These requirements along with need to evolve a vCon (e.g. adding analysis, translations and transcriptions) conflict in some ways.
To enable this, multiple versions of a vCon may be created.
Versions of a vCon may add information (e.g. analysis added to a prior vCon referenced by the appended ([appended](#appended))) and versions that remove information (e.g. redactions of privacy information removed from the vCon referenced in the redacted ([redacted](#redacted))).
Redactions may be at different levels for example:

* PII masked to remove PII data in the text, audio, video or transcripts

* De-identified to remove segments or whole recordings that might be used for voice printing or facial recognition

Different parts and versions of a vCon may be created in different security domains over a period of time.
In addition, some conversation data may be referenced externally through an HTTPS URL as opposed to completely contained within the vCon.
Typically a conversation of one mode, will be hosted or observed in a single domain.
This will likely fall into one of the following hosting situations:

* Enterprise Hosted Communications

* Software as a Service (SaaS) Hosted Communications

* Service Provider Hosted Communications

The distinction among these has gotten clouded over recent years.
The import consideration is that each is a different security domain.
Information about a conversation captured in an enterprise communications system (e.g. meta data and Dialog Object(s) recorded in an IP PBX) is a different security domain from a SaaS transcription service (i.e. an Analysis Object).
Before a vCon leaves a security domain, it SHOULD be signed to prevent it from being altered.
If the new security domain needs to alter it, a new vCon is created with the removed or added data and the prior version is referenced (i.e. via the redacted ([redacted](#redacted)) or appended ([appended](#appended))).
See the redacted vCon object tree figure-1 and appended vCon object tree figure-2.
If information is redacted for privacy reasons, the vCon referenced in the redacted ([redacted](#redacted)), if inline, SHOULD be encrypted to protect the privacy information in the unredacted version of the vCon.

The secure storage and access of externally referenced conversation data is considered out of scope from this document.
Secure mechanisms for HTTPS access and storage of files are well defined.
Identity and credentials for accessing externally stored data will be exchanged out of band from the vCon.
The one requirement for externally referenced data from the perspective of this document, is proof of integrity of that data.

Using the above described approach for redaction and appending of data, we can reduce the security operations on a vCon to signing and encryption.
Two approaches to signing are needed as we have data, in JSON format, that is contained within the vCon and may have data (typically media and file formats, often binary) not contained, inline in the vCon, that is externally referenced.

Externally referenced data will be "signed" using [SHA-512] hash which along with the URL of the externally referenced data is included in the vCon.
[SHA-512] was chosen due to the relatively low cost to generate and verify the signature for what could be very large externally referenced media files.
As the hash for each externally referenced file is contained in the vCon which will be signed, the chain of authentication is provided via the signature on the vCon itself.

This document specifies the JSON format for vCons.  So it seemed the logical solution for signing vCons, is JOSE [JWS] JSON Serialization and likewise for encrypting vCons is JOSE [JWE] JSON Serialization.  The solutions are well documents, implementations are readily available and tested.

Methods of redaction exist for text, audio and video using post processing of the media.
The method of redaction used is out of the scope of this document.
A redacted vCon SHOULD reference it's non-redacted version.
The non-redacted version of the vCon referenced from the redacted vCon MUST be encrypted such that only those with permission to view the non-redacted content can decrypt it.

Any time a vCon is shared outside its original security domain, it SHOULD be signed and optionally encrypted.
Files externally referenced by a vCon SHOULD always be signed with the verification information included in the vCon that references the external file as defined in [Externally Referenced Files](#externally-referenced-files) and [Signing Externally Referenced Files](#signing-externally-referenced-files).
Externally referenced files SHOULD only be transported over [HTTPS] and SHOULD be access controlled to those who are permitted to read the contents of that non-redacted vCon.
vCons transported over non-secure channels such as email MUST be in the encrypted form.

## Signing Externally Referenced Files

In some deployments, it is not practical to include all of the file contents of a vCon inline.
In support of that, a file may be externally referenced.
When external files are referenced, the signature on the vCon does not secure the file contents from modification.
For this reason any externally referenced files SHOULD also have a signature.
vCons use the [SHA-512] hash method for integrity checking of externally referenced file content and include its url, alg and signature in the vCon which are included in the integrity signature for the whole vCon.

After retrieving externally referenced files, before using its content, the payload of the HTTPS request should be verified using the signature parameter value for the hash for the url body using the procedure defined in section 6.3 and 6.4 of [SHA-512].

## Signed Form of vCon Object

A signed vCon uses [JWS] and takes the General JWS JSON Serialization Syntax form as defined in section 7.2.1 of [JWS].
The vCon General JWS JSON Serialization MUST include x5c or x5u in the unprotected header.

* payload: "String"

    The value of the payload is the Base64Url Encoded string containing the unsigned form of the JSON vCon.
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

The Header Object and its contents are defined in section 4 of [JWS].
The Header Object for a signed vCon MUST include the alg and either the x5c or x5u arrays.
The x5c or x5u requirement makes the management and use of vCons easier, allowing the certificate chain to be found as the vCon is moved.

* alg: "String"

    The string value of alg is defined in section 4.1.1 of [JWS].  For a signed vCon this value SHOULD be "RS256" to maximize interoperability.

* x5c: "String[]" (MUST provide x5c or x5u)

    The array of string values for x5c are defined in section 4.1.6 of [JWS].

* x5u: "String" (MUST provide x5c or x5u)

    The string value of x5u MUST contain an [HTTPS] URL as defined in section 4.1.5 of [JWS].

TODO: How to deal with expired signatures?

## Encrypted Form of vCon Object

TODO: Check this terminology:

A vCon MUST be signed first using JWS as defined in [Signed Form of vCon Object](#signed-form-of-vcon-object), then encrypted using JWE as opposed to just encrypted with integrity protection.
The rationale is that meta data and dialog will typically be collected in one security domain, then may be stored or exported to another.
The signing is likely for the lifetime of the vCon, where the encryption may be shorter term or domain specific.
vCons may be stored in unencrypted form, but the signed form MUST be maintained to ensure its integrity.

A encrypted vCon uses [JWE] and takes the General JWE JSON Serialization Syntax form as defined in section 7.2.1 of [JWE].

* unprotected: "Unprotected"

* recipients: "Recipient[]"

* iv: "String"

    The string value of iv is the Initialization Vector as constructed as defined in section 7.2.1 of [JWE].

* ciphertext: "String"

    The string value of ciphertext is constructed as defined in section 7.2.1 of [JWE] using the signed form of the vCon as the plaintext input for encryption.

* tag: "String"

    The string value of tag is the the Authentication Tag as defined in section 7.2.1 of [JWE].

### Unprotected Object

* cty: "String"

    The string value of cty SHOULD be "application/vcon"

* enc: "String"

    The string value of enc SHOULD be "A256CBC-HS512"

TODO: do we want to put the vCon UUID in the Unprotected Object so that we can use it as a key?

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

# vCon CDDL Schema

The following is the [CDDL] schema for vCon.

Note: this CDDL schema is not fully verified and needs some stylistic edits.

~~~
{::include vcon.cddl}
~~~

# Example vCons

This appendix contains example vCons in the unsigned, signed and encrypted form.
The JSON has been indented for readability.
Long text lines have been wrapped with a left hand white space indent for readability purposes.

## Two Party Call vCon With Inline Recording

This example vCon is for a simple 2 party PSTN call.
It has a single Dialog Object which contains a single channel wav format recording with the two parties audio mixed into the single channel.

~~~
{::include examples/ab_call_int_rec.pp}
~~~

## Text Chat vCon

TODO: text vCon example

## Email Thread Multipart vCon

The following is an unsigned form of an vCon for a 2 message email thread between 2 parties.
The email messages are multipart MIME message bodies.

~~~
{::include examples/ab_email_acct_prob_thread.pp}
~~~

## Email Thread Text vCon

The following is an unsigned form of an vCon for a 3 message email thread between 2 parties.
The email messages are plain text message bodies.

~~~
{::include examples/ab_email_prob_followup_text_thread.pp}
~~~

## Two Party Call vCon With Externally Referenced Recording

This example vCon is for a simple 2 party PSTN call.
It has a single Dialog Object which reference a single channel wav format recording with the two parties audio mixed into the single channel.

~~~
{::include examples/ab_call_ext_rec.pp}
~~~

## Two Party Call vCon with Analysis

TODO: vCon with analysis example

## Signed vCon

This example vCon is the signed form of the [Two Party Call vCon With Externally Referenced Recording](#two-party-call-vcon-with-externally-referenced-recording) example.
The private key used to sign this can be found at:

    https://raw.githubusercontent.com/vcon-dev/vcon/main/certs/fake_grp.key

The certificate chain is included in the x5c parameter of the header Object.

~~~
{::include examples/ab_call_ext_rec_signed.pp}
~~~

## Encrypted  vCon

This example vCon is the encrypted form of the [Signed vCon](#signed-vcon) example.
The private key to decrypt it can be found at:

    https://raw.githubusercontent.com/vcon-dev/vcon/main/certs/fake_grp.key

~~~
{::include examples/ab_call_ext_rec_encrypted.pp}
~~~

## Redacted Signed vCon

TODO: redacted vCon example

## Appended Signed vCon

TODO: appended vCon example

## vCon Group

TODO: group vCon example

# Acknowledgments
{:numbered="false"}

  * Thank you to Jonathan Rosenberg and Andrew Siciliano for their input to the vCon container requirements in the form of I-D: draft-rosenberg-vcon-cc-usecases.
  * Thank you to Rohan Mahy for his help in getting started with the CDDL schema for vCon.

