<link rel="stylesheet" href="style.css">

> [!CAUTION]
> Newer versions of the LTMEAT exploit can be leveraged on any fully patched chrome device. When used, device policy and managed extensions can be disabled or even removed. To disable it, [admins can follow these instructions](#preventing-LTMEAT-exploitation).

> [!TIP]
> Like this repo? Star and share it with another chromeOS admin! 😄

# Introduction
Welcome! This project serves as a tool for system administrators to implement policies across chromeOS devices to improve security and limit user risk. To maximise compatibility, all changes will be centered around the Google admin console. 

This is an open-source project so if you have an addition, feel free to submit a pull request on GitHub.

# Securing Kiosk Applications
Kiosk apps are often used for testing, payment, and help desks. This makes it extremely important to protect and manage them to prevent tampering or escape into the operating system. Here, we will discuss browser sandboxing and ways to control access to outside applications.

## Implementing a URL Allowlist
Enabling a whitelist within a Kiosk application to prevent outside browser access is available within the Google Admin panel at **Devices > Chrome > Settings > Device Settings > Kiosk Settings > URL Blocking**

Here, you can either add blocked URLs to disable certain websites or set up a whitelist to only allow certain pages.

## Managing Accessibility Features
Tools like ChromeVOX can aid users with disabilities, but it also has the potential to bypass device policies by overlaying kiosk programs and launching web pages. Because of this, administrators should consider managing or disabling accessibility features during kiosk sessions.

In **Devices > Chrome > Settings > Device Settings > Kiosk Settings**, there is a section called **Kiosk Accessibility Shortcuts**. Admins should choose to restrict access to this functionality.
In the same section, there should be another option for the **Kiosk floating accessibility menu**. This should also be disabled.

## Forcing Wifi Configurations
To bypass Chrome and kiosk policy, users can disable wifi and put the system into a “limbo” state with the application and the Chrome menu.  This also allows them to re-enable blocked accessibility features before re-entering the kiosk program. Because of this, it is recommended to implement an organization policy to prevent changes in user settings and disconnection from networks.

First, you should disable users' ability to access wifi settings in **Devices > Chrome > Settings > Users & browsers > User Experience > and Disabled system features**. Then just select OS Settings, or Wifi Settings to disable access.
Now in **Wifi Settings > Platform Access**, choose **Do not allow for both Chrome users and Chrome devices to use other networks**. Then enable **Automatically Connect** to force devices to only connect to your network when they are in range.

# Controlling Dev Features
Google has included several development tools directly into ChromeOS, however, they are often used to bypass policies and remove device enrollment. It’s important to secure and manage access to these programs.

## Limiting Crosh & Terminal Access
Chrome terminal and Crosh have tools for device management, but admins may want to limit access through the admin console for security purposes.

Admins in the console should go to **Devices > Chrome > Settings > User & browser settings**. You should then see a section called **User Experience and then Disabled System Features**. Add **Crosh** to disable access.
Admins should also consider adding **/html/crosh.html** into the URL blacklist for wider coverage.

## Disabling Chrome Flags
Chrome Flags, a feature built-in on ChromeOS, gives users the option to adjust custom settings for their applications and devices. While this can be helpful in a nonenterprise environment, it’s important to properly manage flags to prevent end users from disabling extensions or removing device policies.

In Google Admin, you can go to **Menu > Devices > Chrome > Settings** and just add **chrome://flags** to the disabled features list. Users will then be unable to access the application.

## Securing Device Recovery Screens
Although developer mode will not be enabled by default on enterprise devices, the recovery screen can still be accessed using keyboard shortcuts. Due to an oversight, attempting to enable developer mode on enterprise machines would result in an automatic powerwash, even if this action is prohibited by device policy. This mistake could lead to serious problems and may even result in the device being removed from enterprise enrollment.

While it is not possible to directly disable the recovery menu, admins can enable an option called **Forced Re-enrollment**, making it impossible to tamper with the device after the powerwash. You can enable this by going to **Devices > Chrome > Settings > Device Settings > Enrollment and Access**. Then navigate down to **Forced re-enrollment** and check **Force device to automatically re-enroll after wiping**.

## Enabling Verified Mode
To provide extra protection against developer mode, admins can enable Verified Boot Mode. This blocks developer mode and prevents system startup unless recovered. This would also help prevent policy circumvention and tampering with OS internals.

Admins can go to **Devices > Chrome > Settings > Device** in the admin console and select the option for **requiring verified mode boot for Verified Access**.

# Setting Up Managed Extensions
Chrome extensions offer a wide range of functions like drive integrations, testing tools, and web filtering. However, unauthorized extensions in the webstore and from 3rd party sources can also pose security risks, and privacy concerns, and can cause issues in device policy. Because of this, administrators should create restrictions on extension access and usage to prevent these risks.

## Blocking Extension Installations
Allowing extensions from the Chrome Web Store could pose a security threat and damage workplace integrity, as most offices do not have antivirus for Chrome devices. Because of this, it is generally best to lock extension access to a pre-approved list to limit risks.

Admins should go to **Devices > Chrome > Apps & extensions** and in the **ExtensionSettings** policy set the mode to blocked to prevent users from installing their extensions.

## Force Install Extensions
Many organizations prefer to have filtering and SSO extensions already installed on their machines for convenience and security purposes. This can be accomplished by configuring the admin console to automatically install these extensions and apps.

This functionality is available in **Devices > Chrome > Apps & extensions** or (depending on your subscription) in **Chrome > Browser > Apps & Extensions**. Next, choose the **Users & browsers** for whom you want to install the extensions and input the application ID. Then just add the **force install** option for your chosen application.

## Adding Optional Extension Installations
Admins have the option to create an optional list of extensions users can install. This could be used for programs that are only needed on some systems but have not been effectively grouped in the active directory, or the Google admin console.

An allow list can be implemented by going to **Devices > Chrome > Apps & Extensions** and then selecting the **Block all apps, admin manages allowlist** option. Then go to the **From the Chrome Web Store** dropdown, and type in the IDs of the extensions you want to allow.

## Preventing LTMEAT Exploitation 
An existing exploit on ChromeOS nicknamed LTMEAT (literally the meatiest exploit of all time) can be leveraged by users on virtually any device to disable and bypass extensions and their policies. Admins in an enterprise environment can take steps to prevent the main exploit and its variations by implementing the following steps.

For the LTMEAT exploit to be leveraged, users need access to one of the larger files in the target extension. This can normally be found with a [crxviewer](https://robwu.nl/crxviewer/). The most common files leveraged are:

- /background.js
- /manifest.json
- /generated_background_page.html
  
Admins can then blacklist these pathways by going to **Menu > Devices > Chrome > Settings > URL Blocking**. Then go through your list of managed extensions and locate the biggest files with the crxviewer (1000 kb or more) + the files shown above. A working entry would be: `chrome-extension://extension_id_here/filename`. All extensions and their ID's can be located at **chrome://extensions**. 

To prevent further exploitation, admins should also block all extension management pages at `chrome://extensions/?id=YOUR_EXTENSIONS_ID_HERE`.  


## Disabling Developer Access
Users can access developer features through the Chrome extensions menu, which could potentially affect security and web filtering. Because of this, administrators may want to disable these features from Google  Admin.

If your devices run v127 or below, you need to disable **DeveloperToolsAvailability** by going to **Devices > Chrome > Settings > User experience > Developer tools** and clicking the disable dropdown.
Admins with devices running the beta (at this time) v128 should navigate to the same menu section as shown in v127 but should instead choose to disable **ExtensionDeveloperModeSettings**.

## Enabling Manifest V2 Extensions
As of May 31st, 2024, Google has launched extension manifest v3, unfortunately some extensions and developers still have not updated to adapt to this change. This may affect tools like 2fa and filtering on some chromeOS devices. Because of this, admins should enable the v2 compatibility as a precaution until developers finish updates.

To enable Manifest v2 compatibility before the switch, admins need to navigate to **Devices > Chrome > Settings > Users & browser settings** and select **Manifest V2 extension availability** and toggle it to enabled. 

# Securing Sign Ins
Ensuring the safety and integrity of an organization’s data is crucial. By using Google Admin’s comprehensive security measures, organizations can safeguard their information and implement strong user controls.  Most, if not all controls mentioned in this section will appear in **Devices > Chrome > Settings > Devices**. Because of this, only a description of the change and its impact will be mentioned per subsection.

## Removing Return Instructions
Oftentimes when an enterprise device is lost or stolen, admins can set up instructions on the login screen to have the device returned.  However, this can lead to unauthorized access and disclosure of sensitive information. By disabling return instructions, admins can effectively brick a device until either returned or recovered.

Admins should choose to **disable with login screen** to completely prevent device access until manually unlocked by an authorized user. Along with appropriate wifi and settings controls, it would be nearly impossible to resell or access the stolen device.

## Disabling Guest Mode
The guest account on Chrome devices lets users access a passwordless, policy-immune account with limited functionality. This could lead to unauthorized access/use of the device and could even be used to circumvent filtering and security protections put in place on the device.

To remove access to the guest account, navigate to the pre-clarified menu subsection and just toggle the **Guest mode** option to disabled.

## Restricting Sign-in Access
To prevent unauthorized entry to enterprise Chromebooks, it is important to limit sign-in access to specific users or domains. This not only improves security but also gives administrators the ability to better control user permissions for different groups.

This functionality can be found in the User & Browser settings where admins can add different domains to different device groups **(e.g., example.com)**. Optionally, admins can also allow consumer accounts for limited personal use (group policy will still apply).

## Hiding Personal Information on Login
Some organizations may have several users log in to the same device every day, or companies may want to hide the personal information of users if the Chromebooks are meant to be taken outside of the building.  Either way, admins may want to consider removing profile pictures and information of users on the general chromeOS login screen.

To set this up, all admins have to do is go to the device settings in the unit you want to change and go to the **sign-in screen section**.  There, just set the value of **Never show user names and photos** to true.

## Preventing Multiple Sign-ins
To ensure that all Chrome policies are always enforced for every user, admins may want to block sign-ins for org users. However,  they can still allow those users to have dual accounts for services such as Gmail while keeping the same controls.

Admins can navigate to **Devices > Chrome > Settings > Users & browsers** and scroll down to **Multiple Sign-In Access**. There should be a toggle for the option to **Block Multiple Sign-in Access to Users in this Organization**.

# Disabling System Features
ChromeOS provides users with several features designed to improve the experience. However, these features also create gaps in terms of user security and device policies. Because of this, administrators may wish to disable certain features to keep device integrity and compliance.

## Managing Certificates
Administrators have the option to prohibit user access to managing CA certificates to minimize the chances of leaked private keys or incorrect modifications to certs. This can improve overall device security posture and can also help in limiting user involvement.

This configuration is available in  **Devices > Chrome > Settings > Users & browsers**.  Under **User management of installed CA certificates**, select **Disallow users from managing certificates** and save.

## Disabling The Task Manager
To ensure the integrity of device extensions and system stability, admins may want to disable the Chrome task manager or set limits on what extensions/applications can be stopped.

The option to disable the Chrome task manager is one of the first under **Devices > Chrome > Settings > Users & browsers**. Admins should choose the option to **block local users from using the task manager**.

## Blocking Internal URLs
Google Chrome has several internal addresses that allow access to developer settings and system changes which can compromise device security and get around policies. Because of this, admins may want to  disable these features in **Devices > Chrome > Settings > Users & browsers > URL Blocking:**
```
chrome://net-export
chrome://sync-internals
chrome://network
chrome://hang
chrome://restart
chrome://kill
javascript://*
data://*
chrome://system
chrome://net-internals
chrome://serviceworker-internals
devtools://*
chrome://settings/performance
chrome://network#state
chrome://inspect#devices
```
## Disabling Incognito Browsing
To ensure that extensions consistently run within a user’s browser and to have full visibility into their activity, it is recommended that admins disable access to incognito mode. This will allow for complete monitoring of users during the day.

Navigate to **Devices > Chrome > Settings** and select **User and Browser**. In this section, you can find an option to **disable incognito mode**. Change the value to **true** and click save to apply the changes.

## Removing Outdated/Unsafe Policies 
Many policies on google admin exist to expand device compatibility, however some of these services are for legacy protocols or are just no longer secure.These policies could have been set by different administrators, or just never removed in a timely manor. This can widen your organizations attack surface and causes unnecessary risk. Admins should be sure to check if any GPOs shown below are enabled in chrome://policy:
```
EnableDeprecatedWebPlatformFeatures
RunAllFlashInAllowMode
SuppressUnsupportedOSWarning
EnableOnlineRevocationChecks
OverrideSecurityRestrictionsOnInsecureOrigin
CertificateTransparencyEnforcementDisabledFor
-Cas
CertificateTransparencyEnforcementDisabledFor
LegacyCas
LegacySameSiteCookieBehaviorEnabled
LegacySameSiteCookieBehaviorEnabledForDomainL
ist
ChromeVariations
DnsOverHttpsMode
LookalikeWarningAllowlistDomains
SafeBrowsingAllowlistDomains
RemoteAccessHostAllowRemoteAccessConnections
```
## Preventing Device Powerwash
The use of powerwashing devices can negatively affect users and admins through data loss, policy and enrollment issues, and application compatibility. Because of this, most organizations choose to disable the option for users to powerwash their devices. 

This setting is available in **Devices > Chrome Devices** and under the **Powerwash** section choose **Do not allow powerwash to be triggered**. This will effectively prevent users from wiping the device except in the case of a TPM firmware update. 
