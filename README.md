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

## Forcing Wifi Configurations 

To bypass Chrome and kiosk policy, users can disable wifi and put the system into "limbo" state with the application and the chrome menu. This also allows them to re-enable blocked accessibility features before re-entering the kiosk program. Because of this, it is recommend to implement an organization policy to prevent changes in user settings and disconnection from networks.

First, you should disable users ability to access wifi settings in **Devices > Chrome > Settings > Users & browsers > User Experience > and Disabled system features**. Then just select **OS Settings**, or **Wifi Settings** to disable access. 

Now in **Wifi Settings > Platform Access**, choose **Do not allow for both Chrome users and Chrome devices to use other networks**. Then enable **Automatically Connect** to force devices to only connect to your network when they are in range.

# Controling Dev Features
Google has included several development tools directly into chromeOS, however they are often used to bypass policies and remove device enrollment. It's important to secure and manage access to these programs.

## Limiting Crosh & Terminal Access 

Chrome terminal and crosh have tools for device management, but admins may want to limit access through the admin console for security purposes.

Admins in the console should go to **Devices > Chrome > Settings > User & browser settings**. You should then see a section called **User experience** and then **Disabled system features**. Choose to add Crosh to disable access. 

Admins should also consider adding ***/html/crosh.html** into the URL blacklist to further limit access. 

## Disabling Chrome Flags

Chrome Flags, a feature built in on ChromeOS, gives users the option to adjust custom settings for their applications and devices. While this can be helpful in a non enterprise environment, it's important to properly manage flags to prevent end users from disabling extensions or removing device policies.

In Google Admin, you can go to **Menu > Devices > Chrome > Settings** and just add **chrome://flags** to the disabled features list. Users will then be unable to access the application. 

## Securing Device Recovery Screens

Although developer mode will not be enabled by default on enterprise devices, the recovery screen can still be accessed using  keyboard shortcuts. Due to an oversight, attempting to enable developer mode on enterprise machines would result in an automatic powerwash, even if this action is prohibited by device policy. This mistake could lead to serious problems and may even result in the device being removed from enterprise enrollment.

While it is not possible to directly disable the recovery menu, admins can enable an option called **Forced Re-enrollment**, making it impossible to tamper with the device after the powerwash. You can enable this by going to **Devices > Chrome > Settings > Device Settings > and Enrollment and access**. Then navigate down to **Forced re-enrollment** and check **Force device to automatically re-enroll after wiping**.

