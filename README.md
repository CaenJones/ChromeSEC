<link rel="stylesheet" href="style.css">

# Introduction
Welcome! this project serves as a tool for system administrators to implement safe and privacy respecting controls on their managed systems for end users on chromeOS. We will focus on using tools in the Google Admin panel to implement policies across as many devices as possible.

This is an open-source project so if you have an addition, feel free to submit a pull request on the GitHub project. 

# Securing Kiosk Applications
Kiosk apps are often used for testing, payment, and help desks. This makes it extremely important to protect and manage them to prevent tampering or escape into the operating system. Here, we will discuss browser sandboxing and ways to prevent access to outside applications. 

## Implementing a URL Allowlist
Enabling a whitelist within a Kiosk application to prevent outside browser access is available within the Google Admin panel at **Devices > Chrome > Settings > Device Settings > Kiosk Settings > URL Blocking**

Here, you can either add blocked URl’s to disable certain websites, or setup a whitelist to only allow certain pages. 

## Managing Accessibility Features
Tools like ChromeVOX can aid users with disabilities, but it also has the potential to bypass device policies by overlaying kiosk programs and launching webpages. Because of this, administrators should consider managing or disabling accessibility features during kiosk sessions.

In **Devices > Chrome > Settings > Device Settings > Kiosk Settings**, there is a section called **Kiosk Accessibility Shortcuts**. Admins should choose the option to restrict access to this functionality. 

In the same section, there should be another option for the **Kiosk floating accessibility menu**. This should also be disabled. 
