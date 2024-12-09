<img src="src/ChromeSEC Logo.png" alt="ChromeSEC Logo">

> [!IMPORTANT]  
> Countdown to Kv5 starts... Now!

> [!TIP]  
> Like this repo? Star and share it with another chromeOS admin! 😄

# Introduction
Hola! Welcome to ChromeSEC. We know that system administrators constantly work within their organization on numerous projects and often do not have the time to hunt for forum posts, decipher Google documentation, or pay for support.

Because of this, we have created an always-changing, comprehensive guide to enable administrators to properly set up and secure their Chromebooks quickly.

We are an open-source project, so if you would like to make a change or add something feel free to open a pull request! You can also check out our [acknowledgements page](Acknowledgements.md).

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
ChromeOS was originally developed to allow user modification of the system. However, this could be damaging to enterprise environments, and it is often used to bypass policies and remove device enrollment. This makes it important to secure and manage access to these processes.

## Limiting Crosh & Terminal Access
Chrome terminal and Crosh allow users to customise and change ChromeOS, but admins may want to limit access through the admin console for security purposes and to prevent damage to the device.

Admins should use GAC to enter **Devices > Chrome > Settings > User & browser settings**. You should then see a section called **User Experience and then Disabled System Features**. Add **Crosh** to disable access.
Admins should also add **/html/crosh.html** into the URL blacklist to fully prevent access.

## Disabling Chrome Flags
Chrome Flags, is a feature built-in on ChromeOS that gives users the option to enable experimental features on their chrome device. While this can be helpful in a nonenterprise environment, it’s important to properly manage flags to prevent end users from making the system unstable, and tampering with the device.

In Google Admin, you can go to **Menu > Devices > Chrome > Settings** and just add **chrome://flags** to the disabled features list. Users will then be unable to access the application.

## Securing Device Recovery Screens
Although developer mode will not be disabled by default on enterprise devices, the recovery screen can still be accessed using keyboard shortcuts. Due to an oversight, attempting to enable developer mode on enterprise machines would result in an automatic powerwash, even if this is prohibited by device policy. This mistake could lead to serious problems and may even result in the device being removed from enterprise enrollment due to a glitch on the signin menu.

While it is not possible to directly disable the recovery menu, admins can enable an option called **Forced Re-enrollment**, making it impossible to unenroll with the device after a powerwash. You can enable this by going to **Devices > Chrome > Settings > Device Settings > Enrollment and Access**. Then navigate down to **Forced re-enrollment** and check **Force device to automatically re-enroll after wiping**.

## Enabling Verified Mode
To provide extra protection against developer mode and firmware-level modification, admins can enable Verified Boot Mode. This blocks developer mode and prevents system startup unless recovered with a signed ChromeOS image. 

Admins can go to **Devices > Chrome > Settings > Device** in the admin console and select the option for **requiring verified mode boot for Verified Access**.

# Setting Up Managed Extensions
Chrome extensions allow for new functionality on Chromebooks such as drive integrations, testing tools, and web filtering. However, unauthorized extensions in the webstore and from 3rd party sources can also pose security risks, privacy concerns, and can cause issues in device policy. Because of this, administrators should create restrictions on extension access and usage.

> [!NOTE]  
> While most guides recommend blocking <a href="https://chromewebstore.google.com/detail/cjpalhdlnbpafiamejdnhcphjbkeiagm">uBlock Origin</a> and might recommend <a href="https://chromewebstore.google.com/detail/ddkjiahejlhfcafbddmgiahcphecmpfh">uBlock Origin Lite</a>, it is possible to restrict uBlock Origin in what it is and is not allowed to do. More details can be found <a href="https://github.com/gorhill/ublock/wiki/Deploying-uBlock-Origin">here</a>. It should also be known that lots of adblockers provide functionality to execute scripts on a page, like <a href="https://adguard.com/">AdGuard</a>.

## Blocking Extension Installations
Allowing extensions from the Chrome Web Store could pose a security threat and allow for malicious programs to be installed. This poises a bigger threat on Chromebooks as most offices and schools do not have antivirus for Chrome devices. Because of this, it is generally best to lock extension access to a pre-approved list.

Admins should go to **Devices > Chrome > Apps & extensions** and in the **ExtensionSettings** policy set the mode to blocked to prevent users from installing their own extensions.

## Force Install Extensions
Many organizations want to have filtering and SSO extensions already installed on their computers. This can be done by configuring the admin console to automatically install these extensions and apps during device enrollment.

This option is available in **Devices > Chrome > Apps & extensions** or (depending on your GAC tier) in **Chrome > Browser > Apps & Extensions**. Next, choose the **Users & browsers** for who you want to install the extensions and input the application ID. Then just add the **force install** option for your chosen application.

## Adding Optional Extension Installations
Admins have the option to create an optional list of extensions users can install from the webstore. This could be used for programs that are only needed on some systems or for certain users. An allow list can be added by going to **Devices > Chrome > Apps & Extensions** and then selecting the **Block all apps, admin manages allowlist** option. Then go to the **From the Chrome Web Store** dropdown, and type in the IDs of the extensions you want to allow.

## Disabling Developer Access
Users can access developer features through the Chrome extensions menu, which could affect security and web filtering. Because of this, administrators may want to disable these features from Google Admin.

If your devices run v127 or below, you need to disable **DeveloperToolsAvailability** by going to **Devices > Chrome > Settings > User experience > Developer tools** and clicking the disable dropdown.
Admins with devices running v128 or above should navigate to the same menu section as shown in v127 but should instead choose to disable **ExtensionDeveloperModeSettings**.

## Enabling Manifest V2 Extensions
As of May 31st, 2024, Google has launched extension manifest v3, unfortunately some extensions and developers still have not updated to adapt to this change. This may affect extensions giving 2fa and filtering  services on all chromeOS devices. Because of this, admins should enable the manifest v2 compatibility as a precaution until developers finish updates.

To do this, admins need to navigate to **Devices > Chrome > Settings > Users & browser settings** and select **Manifest V2 extension availability** and enable it. 

## Disabling Bookmarklets While Allowing Functionality 
While `javascript://` and `data:` bookmarklets can be used to disable extensions and tamper with the device. Howver, fully disabling them can break normal functionality on websites and programs. Because of this, admins can use a device policy called `JavaScriptBlockedForUrls`. 

This policy is available in **Devices > Chrome > User & Browser Settings > Security > Javascript Settings**. There should be a section where you can add different URLs to prevent javascript from running. It is recommended that you add the following addresses:
```
file://*
data://*
javascript://*
html://*
devtools://*
```

# Securing Sign Ins
Keeping an organization’s data safe is very important. Google Admin provides a range of security features that help organizations protect their information and set up strong controls for users. All of these controls can be found under **Devices > Chrome > Settings > Devices**. Therefore, only a short description of each change and its effects will be added in the following sections.

## Removing Return Instructions
Oftentimes when an enterprise device is lost or stolen, admins can set up instructions on the login screen to have the device returned. However, this can allow users to bypass locked mode and enter the signin menu. By disabling return instructions, admins can effectively brick a device until its either returned or recovered.

Admins should choose to **disable without login screen** to completely prevent device access until manually unlocked by an authorized user. Along with correct networking controls, it would be impossible to unenroll or resell the device.

## Disabling Guest Mode
The guest account on Chrome devices lets users access a passwordless, policy-immune account with limited functionality. This could lead to unauthorized use of the device and could be used to bypass filtering and security protections.

To remove access to the guest account, just set the **Guest mode** option to disabled.

## Restricting Sign-in Access
To prevent unauthorized access to your Chromebooks, it is important to limit sign-in access to specific users or domains for each device. This not only improves security but also gives administrators the ability to better control user permissions for different groups.

This functionality can be found in the **User & Browser Settings** where admins can add different domains to different device groups **(e.g., example.com)**. Admins can also allow normal accounts for limited personal use but group policy will still apply.

## Hiding Personal Information on Login
Some organizations may have several users log in to the same device every day, or companies may want to hide the personal information of users if the Chromebooks are meant to be taken outside of the building.  Either way, admins may want to consider removing profile pictures and information of users on the general chromeOS login screen.

To set this up, all admins have to do is go to the device settings in the unit you want to change and go to the **sign-in screen section**. There, just set the value of **Never show user names and photos** to true.

## Preventing Multiple Sign-ins
To make sure that all Chrome policies are always enforced for every user, admins may want to block several sign-ins for enterprise users. However, personal accounts can still be added to the devices if wanted, with the same controls in effect.

Admins can navigate to **Devices > Chrome > Settings > Users & browsers** and scroll down to **Multiple Sign-In Access**. There should be an option to **Block Multiple Sign-in Access to Users in this Organization** that should then be enabled.

# Disabling System Features
ChromeOS gives users several features made to improve the general experience. However, these features also create gaps in terms of user security and device policies. Because of this, administrators may wish to disable certain features in order to enhance pre-existing controls.

## Managing Certificates
Administrators have the option to prevent user access to the certificate management page to make it harder to leak private keys or incorrectly modify certs. This can improve overall device security and can also help in limiting user configuration.

This change is available in  **Devices > Chrome > Settings > Users & browsers**. Then, under **User management of installed CA certificates**, select **Disallow users from managing certificates** and save it.

## Disabling The Task Manager
To ensure the integrity of device extensions and system stability, admins may want to disable the Chrome task manager or set limits on what extensions/applications can be stopped.

The option to disable the Chrome task manager is one of the first under **Devices > Chrome > Settings > Users & browsers**. Admins can then choose the option to **block local users from using the task manager**.

## Blocking Internal URLs
Google Chrome has several internal addresses that allow access to developer settings and system changes which can compromise device security and get around policies. Because of this, admins may want to  disable these pages in **Devices > Chrome > Settings > Users & browsers > URL Blocking:**
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
chrome://borealis-installer
devtools://*
chrome://settings/performance
chrome://network#state
chrome://inspect#devices
chrome://indexeddb-internals/
chrome://crostini-installer
chrome://shimless-rma/
chrome://chrome-signin
chrome-extension://*/manifest.json
html/crosh.html
chrome-untrusted://*
chrome://policy
```
## Disabling Incognito Browsing
To ensure that extensions consistently run in the browser, it is recommended that admins disable access to incognito mode.

Navigate to **Devices > Chrome > Settings** and select **User and Browser**. In this section, you can find an option to **disable incognito mode**. Change the value to **true** and click save to apply the changes.

## Removing Outdated/Unsafe Policies 
Many policies on google admin exist to expand device compatibility, however some of these services are for outdated systems and are no longer secure. These policies could have been set by different administrators, or just never removed. This can widen your organizations attack surface and causes unnecessary risk. Admins should be sure to check and remove any GPOs shown below that are enabled in chrome://policy:
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
The option to powerwash devices can negatively affect users and admins through data loss, policy changes, and enrollment issues. Because of this, most organizations choose to disable the option for users to powerwash their devices. 

This setting is available in **Devices > Chrome Devices**. Under the **Powerwash** section, choose **Do not allow powerwash to be triggered**. This will prevent users from wiping the device except during a TPM firmware update. 

## Disabling User Enrollment
Admins may want to prevent user enrollment to better control their devices. This means that systems, such as personal Chromebooks that are not from the organization, don't get set to enterprise policies if users set up with their work account. It also enables easier detection of user unenrollment as users would have to request that their systems get re-enrolled.

By navigating to **Devices > Chrome > Settings > Users & browsers** and then looking for the **Enrollment permissions** tab, admins can set the polcy to **Do not allow users in this organization to enroll new or re-enroll existing devices** to disable user enrollment. 

> [!WARNING]
> **THIS HAS ONLY BEEN PARTIALLY TESTED:** It is currently possible on unenrolled Chromebooks with developer mode enabled to run `vpd—i RW_VPD -s check_enrollment=1` in VT2 to bypass policy and re-enroll. The exploit kit Rigtools v2 also has a new functionality called `Riienrollment,` which can also bypass enrollment policy set in the admin console. [(kkilobyte as source)](https://github.com/kkilobyte)

## sh1mmer 
sh1mmer is an exploit that takes advantage of how factory shims are verified for the device. By only checking the kernel signature, it was possible to modify the normal shim image to allow users to manipulate the device. 

In order to fix sh1mmer on TI50 devices Google has had to roll all shim keys on the boards, however this has happened to some boards like `nissa` on around v124. On older CR50 systems, it is currently impossible to patch sh1mmer. Admins can still track sh1mmer usage in their workspace by checking for old device policy sync dates in the admin console and removing enrollment permissions for general users.

# Website Licensing
All the code for the website if made by Kanav Gupta, or [s0urce-c0de](https://github.com/s0urce-c0de). Parts of this code is from stackoverflow or docs, but all the code (for rendering the website) is under the UNLICENSE.
```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
```
As of right now, this includes the `_includes`, `_plugins`, `_sass`, `assets`, `Gemfile`, and `_config.yml` files/directories. The license is related exclusively to the Jekyll side of this repository and nothing else. This README and all images and other files not listed here are under the MIT License of Caen Kole Jones.
