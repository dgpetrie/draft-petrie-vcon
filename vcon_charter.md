# VCON BOF Charter Proposal

## Introduction and Group Overview

The generation of conversational data, contained in transcripts and multi-media files, is common in business, especially in customer facing organizations.
However, the storage, analysis and sharing of the data they contain is not currently a standard.
Standardizing a container for conversation data (vCon) has numerous advantages, and enables the management of the conversation's content.
For instance, a standard allows for tools to determine the contents of the conversation, such that privacy guarantees and duties can be accurately performed.
Having a standard container for conversation data also allows for easier management of conversation data, privacy concerns and management of party related data.

The VCON working group will define a standard container for conversation data and specify mechanisms to ensure the integrity and privacy of the data in the container.

## Use Case 1: Privacy and Customer Data Protection Scenarios

Having a cohesive, well defined container for conversation data, makes it easier to solve, track or answer the following:

  * One company sent my customer recording to another for analysis. 
    * How is the recipient assured of the integrity of the communication?
    * How are they sure of the privacy?
    * Where did this customer information come from?
  * What information does a company have about me, and how can they express it when it's in analog form?
  * In what machine learning models was my data used for training or testing?
  * Does this recorded conversation contain personal information?  Can they guarantee that it doesn't?
  * How can I measure the effectiveness of customer redaction tools?
  * I want to switch carriers. How is my conversation data moved between them?
  * I want to consolidate the conversation data across all modes of communication which are spread across silos for different product support teams and communication modes (e.g. text, web chat, email, VoIP).

## Use Case 2: Integration of Conversation Analysis Services

Services exist in the cloud and enterprise to perform analysis of conversation data.
These all use proprietary means of containing the conversation data for input and output of analysis and machine learning processing.
Without a standard container, the integration and use of these service requires custom and one off development.

  * Define a standard for containing all conversation related data to ease integration of services which consume or output conversation data and analysis
  * My enterprise has multiple call centers (in house and hosted).  The call data has different formats for each of them.  I want to be able to feed the data into any hosted transcription server.
  * I want to feed email, web chat, SMS and phone conversations for a given customer into machine learning based analysis to derive customer satisfaction over time or at specific points.
  * I want to be able to easily switch from one call transcription service to another.
  * My enterprise needs to label (or perform some analysis on) all email, web chat, SMS and phone conversations with the product(s) to which they reference.
 
## In Scope

The scope of the VCON working group is:

  * Define a JSON based standard container and Media type to contain and/or reference conversational data including: call style meta data, recordings, data exchanged or presented in the conversations, conversation analysis, transcriptions, translations and annotations
  * Define/specify a mechanism for proving integrity of the conversation data
  * Define/specify a mechanism for encrypting conversation data protect the privacy of conversation parties
  * Determine if there is need for defining media types and standard containers for some small set of analysis, annotation or transcription data

## Out of Scope

The following are out of scope:

  * Algorithms or methodologies for transcription, translation, redaction, analysis or annotation of call data
  * Real-time streaming or updating of conversational data
  * Transport mechanisms
  * Storage or databases specifications

## Milestones

This group will produce:
  * Specification for a JSON based container for conversation data
  * Recommendations or analysis of missing (not defined) data containers and media types for components of the conversation data

