
## Contact Center Use case Meta-Data Gap Analysis

The following table maps meta-data requirements defined in draft-rosenberg-vcon-cc-usecases to parameters defined in draft-petrie-vcon:

|draft-rosenberg-vcon-cc-usecases |draft-petrie-vcon |||
| ------------ | --------- | ------- | --------- |
| **CC Meta-Data** | **Parameter** | **Section** | **Action** |
|Interaction Type |Dialog Object: type and mimetype?? |4.3.1 and 4.3.6 |Perhaps more needed?  Currently no differentiation between email, SMS and web chat; or video and screen recording. |
|Interaction ID | | |Add interaction parameter to Dialog Object?? ||
|File Type |Dialog Object: type and mimetype |4.3.1 and 4.3.6 ||
|Media meta-data |Dialog Object and Dialog Content |4.3 ||
|Start Time |Dialog Object: start |4.3.2 ||
|Duration |Dialog Object: duration |4.3.3 ||
|Direction of call |Dialog Object: originator |4.3.5 ||
|Participant UUID| | |Add uuid parameter to Party Object |
|First Name |Party Object: name |4.3.4 ||
|Last Name |Party Object: name |4.3.4 ||
|Participant Type | | |Add role parameter to Party Object?  Do we need a defined list of tokens for role types? |
|Participant Info |Party Object: tel, stir, mailto, jCard, etc | 4.3.1, 4.2.2, 4.2.3, 4.2.6 and 4.2.X |
|PII and PCI Information | | |Need to think about this some more |
|Skill | | |Add skills parameter to Party Object |
|Campaign | | |Add TBD parameter to Dialog Object?? |
|Transfer Bit Flag |Dialog Object: Dialog Transfer |4.3.10 ||
|Conference Bit Flag |Dialog Object: parties |4.3.4 ||
|Number of Conferences |Dialog Object: parties |4.3.4 ||
|Number of Transfers |Dialog Object: Dialog Transfer |4.3.10 ||
|Number of holds | | |New Dialog Object type or additional parameter?? |
|Hangup Party | | |Add parameter with list of party drop and reconnect times to Dialog Object?? List for each or one list with event type? |
|Disposition |Dialog Object: disposition |4.3.9 ||
|Dialing List | | |Add TBD parameter to Party Object?? contact_list or address_book or name_list or dialing_list | 

