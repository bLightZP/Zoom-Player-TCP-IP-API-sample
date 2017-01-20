  Zoom Player Information Display sample for Communication devices.
 ----------------------------------------------------------------------------

 * Introduction:
 This is a sample program that shows you how to intercept
 Zoom Player messages that indicate certain information
 about the playback process.




 * Messages Sent to Zoom Player

 To have Zoom Player recognize your application, you need
 to send it an ATOM String containing the window name.

 The parameters are:
 LParam = 200, WParam = ATOM String value.

 Message Number : [WM_APP+49]




 * Messages Sent by Zoom Player:

 When the SendMessage interface is used, the message number is returned
 on the "WParam" value and the message content is returned on the "LParam"
 value.  If the LParam contain a string, it is stored as an ATOM String.

 When the TCP interface is used, the message number is always returned/sent
 as a 4-digit code. The message content is seperated by a space character
 following the message number.  All content is string based and UTF-8
 encoded to preserve country specific text codes.

 When sending Zoom Player TCP commands, make sure to terminate each
 command with CRLF (Ascii #13#10)..

 The default TCP/IP port is 4769, but a user can change it under
 Advanced Options / Values / Interface.

 External Messages (ZP -> Program, TCP/IP or SendMessage):

 [WParam]                             | [LParam]
 -------------------------------------+----------------------------------------------
 0000 - Application Name              | String describing the Application
 0001 - Application Version           | String with the version text
 1000 - State Change                  | 0  - Closed
                                        1  - Stopped (doesn't apply to DVD,
                                                      DVD Stop = Closed)
                                        2  - Paused
                                        3  - Playing
 1010 - Current Fullscreen State      | 0  - Windowed
                                        1  - Fullscreen
 1020 - Current FastForward State     | 0  - Disabled
                                        1  - Enabled
 1021 - Current Rewind State          | 0  - Disabled
                                        1  - Enabled
 1100 - TimeLine update               | String containing timeline data
 1110 - Current Duration              | Current Duration in milliseconds
 1120 - Current Position              | Current Position in milliseconds
 1200 - OSD Message                   | String containing the OSD message
 1201 - OSD Message Off               | No value, message just tells that the OSD
                                        has disappeared
 1300 - Current Play Mode             | 0  - DVD Mode
                                        1  - Media Mode
                                        2  - Audio Mode
 1310 - TV/PC Mode                    | 0  - PC Mode
                                        1  - TV Mode (unused)
 1400 - DVD Title Change              | Current Title
 1401 - DVD Title Count               | Number of Titles
 1410 - DVD Domain Change             | See EC_DVD_DOMAIN_CHANGE in DirectX SDK
 1420 - DVD Menu Mode                 | 0  - Not in a Menu
                                      | 1  - In a Menu
 1450 - DVD Unique String             | Returns a unique DVD indentifer
 1500 - DVD Chapter Change            | Current Chapter
 1501 - DVD Chapter Count             | Number of Chapters
 1600 - DVD Audio Change              | Current Audio Track
 1601 - DVD Audio Count               | Number of Audio Tracks
 1602 - DVD Audio Name                | Contains the name of the Audio track and a
                                        padded number for example "001 5.1 AC3"
 1700 - DVD Sub Change                | Current Subtitle Track
 1701 - DVD Sub Count                 | Number of Subtitle Tracks
 1702 - DVD Sub Name                  | Contains the name of the Subtitle track and a
                                        padded number for example "001 5.1 AC3"
 1704 - DVD Sub Disabled              | 0 - Sub Visible
                                      | 1 - Sub Hidden
 1750 - DVD Angle Change              | Current Angle
 1751 - DVD Angle Count               | Number of Angles in the DVD Title 
 1800 - Currently Loaded File         | String containing file name
 1810 - Current Play List             | String containing the Zoom Player Play List
                                        structure.  Each entry is separated by the
                                        ">" character.  Each entry is sub-divided
                                        into additional information:
                                        |N .. |n - Name
                                        |E .. |e - Extension
                                        |D .. |d - Date
                                        |S .. |s - Size
                                        |P .. |p - Path
                                        |R .. |r - Duration
                                        |F .. |f - Forced Duration
                                        It is possible addtional tags will be used
                                        in future version, so code safely.
 1855 - End of File                   | End of file has been reached
 1900 - File PlayList Pos             | String containing file
                                        position in play list
 2000 - Video Resolution              | String containing the
                                        video resolution (if there is one)
 2100 - Video Frame Rate              | String containing the
                                        video frame rate (if there is one)
 2200 - AR Change                     | String containing the AR String
                                        (same as OSD message)
 2210 - DVD AR Mode Change            | 0  - Unknown
                                        1  - Full-Frame
                                        2  - Letterbox
                                        3  - Anamorphic
 2300 - Current Audio Volume          | The current Audio Volume
 2400 - Media Content Tags            | Returns Media Content Strings
                                        (ID3/APE/WMA/Etc... Tags)
 2500 - A CD/DVD Was Inserted         | Returns path to drive the disc was inserted to
 3000 - ZP Error Message              | String of error messsage
                                        Note that there can be multiple errors
                                        appearing in sequence, only the last
                                        error may be visible by the user.
 3100 - Nav Dialog Opened             | A Navigator Dialog has opened
                                         0 - Blanking Navigator
                                         1 - Chapter Navigator
                                         2 - Context Navigator
                                         3 - File Navigator
                                         4 - GoTo Navigator
                                         5 - Media Library Navigator
                                         6 - MouseWheel Navigator
                                         7 - Color Control Navigator
                                         8 - Play List Navigator
                                         9 - Resize Navigator
                                        10 - Station Navigator
                                        11 - Web URL Navigator
 3110 - Nav Dialog Closed             | A Navigator Dialog has closed
                                        (Values are the same as #3100)
 3200 - Screen Saver Mode             | The ZP Screen Saver has:
                                        0 - Started
                                        1 - Ended
 5100 - ZP Function Called            | Value contains name of function
 5110 - ZP ExFunction Called          | Value contains name of function
 5120 - ZP ScanCode Called            | Value contains ScanCode.


 External Messages (Program -> ZP, TCP/IP only)
 Messages that contain parameters should be space seperated,
 for example: "5100 fnPlay"
 and a comma used to seperate multiple parameters,
 for example: "5110 exSetAR,1".

 0000 - Get Application Name          | Returns 0000 message
 0001 - Get Version                   | Returns 0001 message
 1000 - Get Play State                | Returns 1000 message
 1010 - Get Fullscreen State          | Returns 1010 message
 1110 - Get Current Duration          | Returns 1110 message
 1120 - Get Current Position          | Returns 1120 message
 1200 - Show a PopUp OSD Text         | Parameter is a UTF8 encoded text to be
                                        shown as a PopUp OSD
 1201 - Temp Disable PopUp OSD        | Temporarily Disables the PopUp OSD
 1202 - Re-Enable PopUp OSD           | Re-Enables the PopUp OSD
 1210 - Set OSD "Visible" Duration    | Value in Seconds
 1300 - Get Play Mode                 | Returns 1300 message
 1400 - Request DVD Title             | Returns 1400 message
 1401 - Request DVD Title Count       | Returns 1401 message
 1420 - Request DVD Menu Mode         | Returns 1420 message
 1500 - Request DVD Chapter           | Returns 1500 message
 1501 - Request DVD Chapter Count     | Returns 1501 message
 1600 - Request DVD Audio             | Returns 1600 message
 1601 - Request DVD Audio Count       | Returns 1601 message
 1602 - Request DVD Audio Names       | Returns 1602 message
 1603 - Set DVD Audio Track           | Set the DVD's Audio Track
                                        Valid values 0-7 or 15 for default track
 1700 - Request DVD Subtitle          | Returns 1700 message
 1701 - Request DVD Subtitle Count    | Returns 1701 message
 1702 - Request DVD Subtitle Names    | Returns 1702 message
 1703 - Set DVD Subtitle Track        | Set the DVD's Subtitle Track
                                        Valid values 0-31, also enables subtitle
 1704 - Hide DVD Subtitle             | Disable DVD Subtitles from showing
 1750 - Request DVD Angle             | Returns 1750 message
 1751 - Request DVD Angle Count       | Returns 1751 message
 1753 - Set DVD Angle                 | Set the DVD's Angle
                                        Valid Values 1-9
 1800 - Request File Name             | Returns 1800 message
 1810 - Request Play List             | Returns 1810 message
 1850 - Play File                     | Play a Media File, Value is a UTF8 encoded
                                        string containing the file name.
 1900 - Get Play List Index           | Returns 1900 message
 1910 - Set Play List Index           | Value from 0 to Number items in
                                        the play list-1 (plays the file in index).
 1920 - Clear Play List               | Clears the Current Play List
                                        (will close any playing file)
 1930 - Add Play List File            | Add a file to the Play List
 1940 - Select Play List Item         | Select an Item in the Play List
 1941 - DeSelect Play List Item       | Remove selection of a Play List item
 2200 - Request AR Mode               | Request the current ZP AR Mode
 2210 - Request DVD AR Mode           | Request the DVD AR Mode (see outgoing #2210)
 2300 - Request Audio Volume          | Request the Audio Volume Level
 2600 - Set Derived Mode Aspect Ratio | Sets the aspect ratio used for Derived Aspect Ratio
                                        mode for the currentply playing video.  The aspect
                                        ratio is specified as:
                                        "Width Ratio"+"Height Ratio" left shifted 16 bits.
                                        For Example, 16:9 would be "16+9*65536" or "16+9<<16"
                                        or "16+(9 shl 16)" (the examples do the same thing
                                        in different syntax).
 3000 - Dismiss ZP Error              | Close the ZP Error message (if visible).
 5000 - Set Current Position          | Sets the Current Play Position (in seconds)
 5010 - Play DVD Title                | Plays a DVD Title (depends on DVD Navigation
                                        accepting the title).
 5020 - Play DVD Title,Chapter        | Same as 5010, Plays a DVD Title at a specific
                                        chapter, value of "1,5" plays Title #1, Chapter #5
                                        (without the "" of course).
 5030 - Play DVD Chapter              | Same as 5010, Plays a DVD Chapter in the
                                        current Title.
 5100 - Call ZP Function              | Calls a Zoom Player function
                                        by name (see skinning tutorial for list)
 5110 - Call ZP ExFunction            | Calls a Zoom Player extended function
                                        by name (see skinning tutorial for list)
                                        Format "exFunctionName,Value"
 5120 - Call ZP ScanCode              | Pass a keyboard scancode number to the
                                        Zoom Player Interperter (such as VK_DOWN),
                                        this can be used to access the Navigator
                                        interfaces, pass the scancode as a parameter.


 Message Number : [WM_APP+444]



 * Getting additional information:

 Message Number : [WM_APP+50]

 Send the message with one of the following parameters in the LParam field (hex):

  ZP_GetFileName    = $1000;
  ZP_GetDuration    = $1010;
  ZP_GetPosition    = $1020;
  ZP_GetMode        = $1030;
  ZP_GetState       = $1040;
  ZP_GetPlayIndex   = $1050;

 The return value of the message will be an integer value with the current
 state (with the exception of "ZP_GetFileName" which returns an atom to a
 string containing the file name, make sure to deallocate the atom).

 * Setting additional data:

 Message Number : [WM_APP+50]

 Send the message with one of the following parameters in the LParam Field
 (hex) and the value in the WParam Field (hex):

  ZP_SetPosition    = $5000;  (WParam is value in Seconds)
  ZP_CallFunction   = $5010;  (WParam is an ATOM string listing
                              the function name (see brownish.skn))
  ZP_CallExFunction = $5020;  (WParam is an ATOM string listing the
                              extended function name (see default.key))
                              The string should be listed as
                              "[function],[value]", for example:
                              "exSetAR,2" (don't include the "" in the string)


 Some functions require you to pass an ATOM string to Zoom Player.
 Use the WinAPI "GlobalAddAtom" function to create the ATOM and pass
 it through the WParam parameter.  Zoom Player will clear the ATOM
 on its own.



 * License:
 This Zoom Player communication interface can only be used by under a
 direct license through Inmatrix.
