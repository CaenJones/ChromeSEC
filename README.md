<img src="https://github.com/CaenJones/ChromeSEC/blob/main/src/ChromeSEC%20Logo.png?raw=true" alt="ChromeSEC Logo.png"/>

> [!CAUTION]
> The Sh1mmer and Sh1mmless RMA exploits can be used to unenroll any fully updated managed device. To track is usage, [admins can follow these instructions](#monitoring-sh1mmer-exploitation).

> [!TIP]
> Like this repo? Star and share it with another chromeOS admin! 😄

# Introduction
Hola! Welcome to ChromeSEC. We know that system administrators constantly work within their organization on numerous projects and often do not have the time to hunt for forum posts, decipher Google documentation, or pay for support. Because of this, we have created an always-changing, comprehensive guide to enable administrators to properly set up and secure their Chromebooks quickly.

We are an open-source project, so if you would like to make a change or add something feel free to open a pull request!

# Securing Kiosk Applications
Kiosk apps are often used for testing, payment consoles, and helpdesk systems. This makes it extremely important to protect and configure them to prevent tampering or the ability to misuse them as filtering and monitoring extensions are usually inactive. Here is how you can properly setup your Kiosk programs to run in a safe and secure manner. 

## Implementing a URL Allowlist
Enabling a domain whitelist inside a Kiosk application can prevent users from accessing unfiltered pages within the program. Using the Google Admin panel at **Devices > Chrome > Settings > Device Settings > Kiosk Settings > URL Blocking** you can either add blocked URLs to disable certain websites or set up a whitelist to only allow certain pages.

## Managing Accessibility Features
Tools like ChromeVOX and other accessibility features have the potential to bypass device policies by overlaying kiosk programs and enabling users to launch web pages. Because of this, administrators should consider managing or disabling certain accessibility features in kiosk programs.

In **Devices > Chrome > Settings > Device Settings > Kiosk Settings**, there is a section called **Kiosk Accessibility Shortcuts**. Admins should choose to disable these shortcuts.
In the same section, there should be another option for the **Kiosk floating accessibility menu**. This should also be disabled.

## Forcing Wifi Configurations
To bypass Chrome and kiosk policy, users can disable wifi and put the system into a “limbo” state with the application and the Chrome browser.  This also allows them to re-enable blocked accessibility features before using the kiosk program. Because of this, it is recommended to implement an organization policy to prevent changes in user network settings and the ability to disconnect from networks.

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
An existing exploit on ChromeOS nicknamed LTMEAT can be leveraged by users on virtually any device to disable and bypass managed extensions. Fortunately, admins can take steps to prevent the exploit and its variations by implementing the following steps.

For the LTMEAT exploit to be leveraged, users need access to the chrome extensions menu, or an internal file within the extension package. To prevent this, admins can go to **Devices > Chrome > Settings > URL Blocking** and add the following addresses:
```
chrome-extension://*
chrome://extensions
```
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
chrome://indexeddb-internals/
chrome://crostini-installer
chrome://shimless-rma/
chrome://chrome-signin
html/crosh.html
chrome-untrusted://*
chrome://policy
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
CertificateTransparencyEnforcementDisabledForCas
CertificateTransparencyEnforcementDisabledForLegacyCas
LegacySameSiteCookieBehaviorEnabled
LegacySameSiteCookieBehaviorEnabledForDomainList
ChromeVariations
DnsOverHttpsMode
LookalikeWarningAllowlistDomains
SafeBrowsingAllowlistDomains
RemoteAccessHostAllowRemoteAccessConnections
```
## Preventing Device Powerwash
The use of powerwashing devices can negatively affect users and admins through data loss, policy and enrollment issues, and application compatibility. Because of this, most organizations choose to disable the option for users to powerwash their devices. 

This setting is available in **Devices > Chrome Devices** and under the **Powerwash** section choose **Do not allow powerwash to be triggered**. This will effectively prevent users from wiping the device except in the case of a TPM firmware update. 

## Monitoring Sh1mmer Exploitation 
Sh1mmer is an exploit that takes advantage of how factory shims are verified for the device. By only checking the kernel signature, it was possible to modify the retail shim image to allow for the removal of write protection, and total device un-enrollment. 

While no current fix exists for Sh1mmer, admins can track its usage in their workspace by checking for old device policy sync dates in the admin console and removing enrollment permissions for general users.

### Sh1mless RMA
The Shimless RMA menu is a tool embedded into ChromeOS that allows technicians to make limited changes to the device after repairs. However, it can be accessed without authentication and used to fully reset and unenroll the device. 

As the Shimless RMA menu is part of the device's firmware, it is not possible to patch it at this time. Admins should blacklist access to `https://chromeos.google.com/partner/console/` and use the same methods shown with Sh1mmer to detect this exploit in the workspace. 



