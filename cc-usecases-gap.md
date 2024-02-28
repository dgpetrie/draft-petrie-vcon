
## Contact Center Use case Meta-Data Gap Analysis

The following table maps meta-data requirements defined in draft-rosenberg-vcon-cc-usecases to parameters defined in draft-petrie-vcon:

|draft-rosenberg-vcon-cc-usecases |draft-petrie-vcon |||
| ------------ | --------- | ------- | --------- |
| **CC Meta-Data** | **Parameter** | **Section** | **Action** |
|Interaction Type |Dialog Object: type and mimetype?? |4.3.1 and 4.3.6 |Perhaps more needed? |
|Interaction ID | | |Add to Dialog Object?? ||
|File Type |Dialog Object: type and mimetype |4.3.1 and 4.3.6 ||
|Media meta-data |Dialog Object and Dialog Content |4.3 ||
|Start Time |Dialog Object: start |4.3.2 ||
|Duration |Dialog Object: duration |4.3.3 ||
|Direction of call |Dialog Object: originator |4.3.5 ||
|Participant UUID| | |Add to Party Object |
|First Name |Party Object: name |4.3.4 ||
|Last Name |Party Object: name |4.3.4 ||
|Participant Type | | |Add to Party Object e.g. role?|
|Participant Info |Party Object: tel, stir, mailto, jCard, etc | 4.3.1, 4.2.2, 4.2.3, 4.2.6 and 4.2.X |
|PII and PCI Information | | |Need more time to design |
|Skill | | | Add to Party Object |
|Campaign | | |Add to Dialog Object?? |
|Transfer Bit Flag |Dialog Object: Dialog Transfer |4.3.10 ||
|Conference Bit Flag |Dialog Object: parties |4.3.4 ||
|Number of Conferences |Dialog Object: parties |4.3.4 ||
|Number of Transfers |Dialog Object: Dialog Transfer |4.3.10 ||
|Number of holds | |New Dialog Object type or additional parameter?? |
|Hangup Party | | |Add to Dialog Object ||
|Disposition |Dialog Object: disposition |4.3.9 ||
|Dialing List | | |Add to Party Object?? | 

