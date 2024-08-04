<link rel="stylesheet" href="style.css">

# Table of Contents 
- [Introduction](#introduction)
- [Securing Kiosk Applications](#securing-kiosk-applications)
  * [Implementing a URL Allowlist](#implementing-a-url-allowlist)
  * [Managing Accessibility Features](#managing-accessibility-features)
  * [Forcing Wifi Configurations](#forcing-wifi-configurations)
- [Controling Dev Features](#controling-dev-features)
  * [Limiting Crosh & Terminal Access](#limiting-crosh---terminal-access)
  * [Disabling Chrome Flags](#disabling-chrome-flags)
  * [Securing Device Recovery Screens](#securing-device-recovery-screens)
  * [Enabling Verified Mode](#enabling-verified-mode)
- [Setting Up Managed Extensions](#setting-up-managed-extensions)
  * [Blocking Extension Installations](#blocking-extension-installations)
  * [Force Install Extensions](#force-install-extensions)
  * [Adding Optional Extension Installations](#adding-optional-extension-installations)
  * [Disabling Developer Access](#disabling-developer-access)
  * [Enabling Manifest V2 Extensions](#enabling-manifest-v2-extensions)
- [Securing Sign Ins](#securing-sign-ins)
  * [Removing Return Instructions](#removing-return-instructions)
  * [Disabling Guest Mode](#disabling-guest-mode)
  * [Restricting Sign in Access](#restricting-sign-in-access)
  * [Hiding Personal Information on Login](#hiding-personal-information-on-login)
  * [Preventing Multiple Sign ins](#preventing-multiple-sign-ins)

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

## Enabling Verified Mode 

To provide extra protection against developer mode, admins can enable **Verified Boot Mode**. This blocks developer mode and prevents system startup unless recovered. This would also help prevent policy circumvention and tampering with OS internals. 

Admins can go to **Devices > Chrome > Settings > Device** in the admin console and select the option for requiring verified mode boot for Verified Access. 

# Setting Up Managed Extensions
Chrome extensions offer a wide range of functions like drive integrations, testing tools, and web filtering. However, unauthorized extensions in the webstore and from 3rd party sources can also pose security risks, privacy concerns, and can cause issues in device policy. Because of this, administrators should create restrictions on extension access and usage to prevent these risks.

## Blocking Extension Installations

Allowing extensions from the Chrome Web Store could pose a security threat and damage workplace integrity, as most offices do not have antivirus for Chrome devices. Because of this, it is generally best to lock extension access to a pre-approved list to limit risks. 

Admins should go to **Devices > Chrome > Apps & extensions** and in the **ExtensionSettings** policy set the mode to blocked to prevent users from installing their own extensions. 

## Force Install Extensions 

Many organizations prefer to have filtering and SSO extensions already installed on their machines for convenience and security purposes. This can be accomplished by configuring the admin console to automatically install these extensions and apps.

This functionality is available in  **Devices > Chrome > Apps & extensions** or (depending on your subscription) in **Chrome > Browser > Apps & Extensions**. Next, choose **Users & browsers** for who you want to install the extensions for and input the applications ID. Then just add the force install option for your chosen application. 

## Adding Optional Extension Installations 

Admins have the option to create an optional allow list of extensions users can install. This could be used for programs that are only needed on some systems, but have not been effectively grouped in active directory, or the google admin console.  

An allow list can be implemented by going to **Devices > Chrome > Apps & Extensions** and then selecting the **Block all apps, admin manages allowlist** option. Then go to the From the Chrome Web Store dropdown, and typing in the ID’s of the extensions you want to allow. 

## Disabling Developer Access

Users can access developer features through the chrome extensions menu, which could potentially affect security and web filtering. Because of this, administrators may want to disable these features from Google Admin.

If your devices run v127 or below, you need to disable **DeveloperToolsAvailability** by going to **Devices > Chrome > Settings > User experience > Developer tools** and clicking the disable dropdown.

Admins with devices running the beta (at this time) v128 should navigate to the same menu section as shown in v127 but should instead choose to disable the **ExtensionDeveloperModeSettings**. 

## Enabling Manifest V2 Extensions

Starting May 31st, 2024, Google will launch extension manifest v3, but most extensions and developers have not updated yet. This may affect tools like 2fa and filtering on current chromeOS devices, so admins should consider enabling the v2 compatibility until developers finish updating.

To enable manifest v2 compatibility before the switch, admins need to navigate to **Devices > Chrome > Settings > Users & browser settings** and select the policy **Manifest V2 extension availability**. Then just toggle **Enable manifest V2 extensions**.

# Securing Sign Ins
Ensuring the safety and integrity of an organization's data is crucial. By using Google Admin's comprehensive security measures, organizations can safeguard their information and implement strong user controls.  Most, if not all controls mentioned in this section will appear in **Devices > Chrome > Settings > Devices**. Because of this, only a description of the change and its impact will be mentioned per subsection. 

## Removing Return Instructions 

Oftentimes when an enterprise device is lost or stolen, admins can setup instructions on the login screen to have the device returned. However, this can lead to unauthorized access and disclosure of sensitive information. By disabling return instructions, admins can effectively brick a device until either returned or recovered. 

Admins should choose to **disable with login screen** to completely prevent device access until manually unlocked by an authorized user. Along with appropriate wifi and settings controls, it would be near impossible to resell or access the stolen device. 

## Disabling Guest Mode

The guest account on chrome devices lets users access an passwordless, policy-immune account  with limited functionality. This could lead to unauthorized access / use of the device and could even be used to circumvent filtering and security protections put in place on the device. 

To remove access to the guest account, navigate to the pre-clarified menu subsection and just toggle the **Guest mode** option to disabled. 

## Restricting Sign in Access 

To prevent unauthorized entry to enterprise chromebooks, it is important to limit sign-in access to specific users or domains. This not only improves security, but also gives administrators the ability to better control user permissions for different groups.

This functionality can be found in the **User & Browser settings** where admins can add different domains to different device groups **(e.g., `example.com`)**. Optionally, admins can also allow consumer_accounts for limited personal use (group policy will still apply).

## Hiding Personal Information on Login

Some organizations may have several users login to the same device every day, or companies may want to hide the personal information of users if the chromebooks are meant to be taken outside of the building. Either way, admins may want to consider removing profile pictures and information of users on the general chromeOS login screen. 

To set this up, all admins have to do is go to the device settings in the unit you want to change, and go to the sign-in screen section. There, just set the value of **Never show user names and photos** to true. 

## Preventing Multiple Sign ins

In order to ensure that all Chrome policies are always enforced for every user, admins may want to block sign-ins for org users. However, they can still allow those users to have dual accounts for services such as Gmail while keeping the same controls.

Admins can navigate to **Devices > Chrome > Settings > Users & browsers** and scroll down to **Multiple Sign-In Access**. There just toggle the option to **Block Multiple Sign in Access to Users in this Organization**.

