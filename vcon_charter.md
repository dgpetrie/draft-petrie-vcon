# VCON BOF Charter Proposal

## Introduction and Group Overview

The vCon work group is about passing conversational data.
Such data is commonly generated and collected in business environments, from chat logs to transcripts to recordings.
Most systems provide way to store such information, but there are not many standards or interoperability within the storage or transmission mechanisms or formats.

The two opposing forces influencing such information passing are trying to enforce privacy of personal data and providing the ability and interest to use conversations in various ways, e.g.,  AI analysis.
For the first force the key is knowing what information exists, where it comes from, and being able to protect it appropriately. Or being able to refer to conversations without exposing their contents or assure suitable redaction has been performed.
For the second force the key is being able to integrate data between multiple systems (phones, chat systems, email, etc.), move data when transitioning from one software or provider to another, and so on.
There is a lot of conversational data already being exchanged, but using proprietary formats and per-case engineered exchange solutions, from using FTP and other legacy components, to file naming conventions, and so on.
There are also open source systems implementing vCon which may yield input to the requirements.

TODO:
Communicaitons System -> Data Owner/Consumer
Data Owner/Consumer -> Analysis or Storage Services
Analysis Services -> Data Consumer

## Use Case 1: Contact Center Data Exchange

Contact centers manage communications with a company's customers.
Staff in a contact center have conversations with customers using phone calls, emails, texts, and other messaging systems.
The contact center may be operated by the company or a 3rd party.
The company would like to have a standard way to accomplish at least the following:

  * Retrieve the conversation data from the in house or 3rd party contact center
  * Provide the conversation data to a service to keep recordings for conversations of record or for compliance reasons
  * Provide the conversation data to a service to analyze and provide quality management in the contact center
  * Provide the conversation data to a service to provide speech analytics
  * Redact or hide information in the conversation such as personally identifiable information (PII) and payment card information (PCI) that does not need to be disclosed to some consumers of the conversation data
  * Contain the entire conversation or omnichannel where the conversation takes place in multiple modes of communication such as SMS, phone call, emails, texts, and other messaging
  * Provide means of protecting privacy or confidentiality during exchange using encryption

## Use Case 2: Non-Call Center Customer Relationship Management

People working outside of contact centers may have customer relationship management (CRM) responsibilities at their companies.
They may be performing as sales persons, account management, business development or general management.
The customer that they interact with may be internal to the company.
The requirements for this case, at a high level, are not largely different from the Contact Center case.
The primary difference is that they do not have contact center staff or an IT organization providing them support.
The user has no control or choice over the phone or communication systems that they must use.
Having a standard container for conversation data enables them to:

  * Retrieve the conversation data from their phone system provider or communications systems providers
  * Feed the conversation data to a SaaS provider accepting a standard conversation container as input and providing numerous services such as:
    * transcription
    * note-taking
    * annotations such as action items
    * importing to a CRM system
    * coaching and mentoring


## Use Case 3: Conversations of Record

In some contact centers or company functions, it may be required to capture conversation data and maintain them as a conversation of record.
For example emergency service contact centers (ECRIT) may be required to record all information related to an emergency call.
In some call centers, compliance reasons may require recording of conversation and related information

  * The integrity of the captured conversation and metadata may be the most critical feature in this use case
  * Location of one or more of the parties to the conversation may be relevant to the conversation of record


## Use Case 4: Message History Exchange

Today many instant messaging applications allow multiple clients for the same user, ex: laptop and mobile, or old mobile phone migrating to new mobile phone.
Being able to share the message history from an existing device to a new device seems like a nice way to share messages that the new client could not have an end-to-end session for.

Another case is when you have a group chat with substantive discussion and then add some other users who were not party to the conversation.
Allowing an administrator in the group be able to catch them up by sharing message history from some relevant point in the past would be a nice to have feature.

 
## In Scope

The scope of the VCON working group is:

  * Define a JSON based standard container and Media type to contain and/or reference conversational data including: call style metadata, recordings, data exchanged or presented in the conversations, conversation analysis, transcriptions, translations and annotations
  * Define/specify the use of an existing mechanism for proving integrity and optionally authenticity of the conversation data
  * Define/specify the use of an existing mechanism for encrypting of the objects enclosed in the vCon conversation data container to provide privacy of the participants and/or confidentiality of the data independent of transport such that some parts of the vCon may be disclosed to different parties

  * Determine if there is need for defining media types and standard containers for some small set of analysis, annotation or transcription data
  * Consider data minimization for each of the use cases
  * Create one or more use case I-Ds to expand upon the use cases in this charter

## Out of Scope

The following are out of scope:

  * Algorithms or methodologies for transcription, translation, redaction, analysis or annotation of call data
  * Real-time streaming or updating of conversational data
  * Transport mechanisms
  * Storage or databases specifications
  * The key management
  * API definitions
  * Definition of a new object security model  
    It is expected that JOSE or other existing IETF technology is suffient.

## Milestones

This group will produce:
  * Specification for a JSON based container for conversation data
  * Recommendations or analysis of missing (not defined) data containers and media types for components of the conversation data

