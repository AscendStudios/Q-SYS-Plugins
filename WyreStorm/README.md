# Wyrestrom NHD Plugin 

This is a simple plugin to allow you to quickly route sources to destinations. 

# Setup

You can set up and configure the plugin to fit your needs. Start by selecting the number of transmitters and recievers that you would like to use. Additionally, you can set a number of serial commands that you would like to include. (This will allow you to send serial commands like power on/off to remote devices.)

Enable DEV mode is a settign that wiil allow you to alter the port that the plugin transmits across. The default is 23. Dev mode will also preset the IP address to localhost. 

# Getting Started
In order to get started, the NHD should have aliases set and saved to the NHD CTL. This is the easiest way to connect. Once you have the aliases set, simply copy them into the plugin under the router page. The order doesn't matter - As long as each alias is listed you can select it by the button next to it. 


# Using the plugin

### Routing Page

In 

Only one source can be selected at a time, but several destinations can be selected, allowing you to send a single source to serveral locations at once. For quick selection; you can use the select all under the transmitter side. 

Once you send a source the buttons will clear themselves. 

Routing can be done in any order. You can chose the source then the destination or you can chose the destination(s) and then the source you'd like. 

### Serial Page
This is where you can set custom serial strings to be sent to the receievers. Here the order does matter. the destination needs to be selected first then the serial button. 

The serial buttons are set to be momnetary and do not clear the state of the destination buttons. This is so that if you are using a volume button; you can simply select the destination and then press the serial button as many times as needed. 

### Configuration Page
This is the network config page. It's pretty simple. Just set the IP and hit connect. 




