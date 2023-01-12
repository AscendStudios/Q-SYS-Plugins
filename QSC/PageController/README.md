# Page Navigation

This is a plugin that allows you to control pages of a given touch panel. This can be both a UCI viewer or a dedicated panel.

## Properties

  - Page Buttons
    - INT: This allow the user to define how many page flip buttons they would like to use. 

  - Defined Pass Codes
    - INT: This allow the user to set a number of custom pin codes to access various pages in the UCI.

  - Admin Pin
    -STRING: This allows the user to set a "backdoor" pin to allow access to a specific touch panel page. 

## Using The Plugin

**Warning**
In Q-SYS 9.5 and later - You must enable the script access for any touch panel that you would like this script to access. This option can be found in the script access section of the property panel. The script access field must be set to script or all for the plugin to see the panel. 

**Note**
You may need to put the design into emulation mode and manually set the UCI for association the first time running the plugin within the design. 

### Configuration Page

#### Panel Selection

This is a dropdown menu that allows the user to choosae which panel the plugin should be linked to. Switching this will dymanically update the plugin options, and can be done even on a LIVE core.

#### UCI Selection

If the UCI was set to dynamic, then the user can use this field to dynamically change which UCI is being loaded on to the panel selected in "Panel Selection". 

#### Pin Code Configuration

###### Admin Page

This is where the user can set the page they would like to navigate to when the admin pin is entered in the pin pad. This pin is always active. 

###### Custom Pins

The number of available pins are determined by the properties of the touch panel plugin. Each custom pin has three fields that can be updated. 

  - Enable button:
    - This button allows the user to quickly and dynamically enable or disable pin codes. 
  - Pin:
    - This is the actual pin string that a user would like to set. NOTE: This technically can be alphanumeric, however the plugin itself only provides the user with a number pad.
  - Page:
    - This is where the user can set the page they would like the pin code to send the end user to upon entering the correct pin.

#### Pin Code Configuration

This is simply a number pad with a display. 

Users won't see the actual digits they are inputting but will instaead see "*" for each digit. 

There are also back, clear, and enter buttons. 

#### Control

This is the main page.

###### Page Selection

This is the main driving force behind the page switching for this plugin. In the backend when we execute a page change what we're actually doing is changing this String. 

As a dropdown it can be used directly or the user can choose a number of dedicated buttons that will drive this selector. 

###### Page Buttons

The number of available Page Buttons are determined by the properties of the touch panel plugin. This allows the user to creat buttons that when pushed will always point to the same page no matter what. This also allows for UCI navigation to be done with either buttons or a dropdown menu. 

There is a dropdown menu next to each of the buttons that will allow the user to pick which page they want the button to land on when pressed. 
