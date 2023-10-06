#The  VCON BOF Charter Proposal

## Introduction and Group Overview

The vCon work group is about passing conversational data.
Such data is commonly generated and collected in business environments, from chat logs to transcripts to recordings.
Most systems provide way to store such information, but there are not many standards or interoperability within the storage or transmission mechanisms or formats.

The two opposing forces influencing such information passing are trying to enforce privacy of personal data and providing the ability and interest to use conversations in various ways, e.g.,  AI analysis.
For the first force the key is knowing what information exists, where it comes from, and being able to protect it appropriately. Or being able to refer to conversations without exposing their contents or assure suitable redaction has been performed.
For the second force the key is being able to integrate data between multiple systems (phones, chat systems, email, etc.), move data when transitioning from one software or provider to another, and so on.
There is a lot of conversational data already being exchanged, but using proprietary formats and per-case engineered exchange solutions, from using FTP and other legacy components, to file naming conventions, and so on.
There are also open source systems implementing vCon which may yield input to the requirements.

The use of a standard for conversation container will focus on the following data exchange scenarios:
  * Communication System to Data Owner/Consumer
  * Data Owner/Consumer to Analysis or Storage Services
  * Analysis Services to Data Consumer

The Communication System is an application, service or system which is able to capture the the conversation metadata and the conversation.
The Analysis Services will add data to existing conversation data container.
It should be noted that these entities are not always distinct.
For example the Communications System may also provide some analysis data.
It should also be noted that these entities may also exist in multitude.
For example an enterprise may have a communication system for each mode (e.g. text, message, voice, video) or for each corporate product or division.

 
## In Scope

The scope of the VCON working group is:

### Standards Track RFC Output

  * Define a JSON based standard container and Media type to contain and/or reference conversational data including: call style metadata, recordings, data exchanged or presented in the conversations, conversation analysis, transcriptions, translations and annotations
  * Define/specify the use of an existing mechanism for proving integrity and optionally authenticity of the conversation data
  * Define/specify the use of an existing mechanism for encrypting of the objects enclosed in the vCon conversation data container to provide privacy of the participants and/or confidentiality of the data independent of transport such that some parts of the vCon may be disclosed to different parties
  * Determine if there is need for defining media types and standard containers for some small set of analysis, annotation or transcription data

### Informational Internet Draft Output
The Working Group may develop use cases in drafts for reference, but there is no expectation they will be published as an RFC.
The use cases should include considerations for data minimization.
The Working Group may consider the following as well as other use cases:

  * Contact Center Data Exchange
  * Non-Contact Center Data Exchange with Customer Relationship Management (CRM)
  * Conversations of Record including ECRIT Environments
  * Message History Data Exchange

## Out of Scope

The following are out of scope:

  * Algorithms or methodologies for transcription, translation, redaction, analysis or annotation of call data
  * Real-time streaming or updating of conversational data
  * Transport mechanisms
  * Storage or databases specifications
  * Key management
  * API definitions
  * Definition of a new object security model  
    It is expected that JOSE or other existing IETF technology is sufficient.

## Milestones

This group will produce:
  * Specification for a JSON based container for conversation data
  * Recommendations or analysis of missing (not defined) data containers and media types for components of the conversation data

