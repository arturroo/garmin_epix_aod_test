# garmin_epix_aod_test

# Theory
Garmin says, that his Epix Gen 2 Smartwatch has alway-on display. In my opinion it is creative marketing.
As I have analysed the screen of Epix it is not always-on.

# About me
I am Python, Scala and now also Monkey C developer. I am fan of Garmin devices. I use Fenix 3 HR since year 2016. I like to swim, go hiking, ride trail and enduro MTB.

# Laboratory

## WatchFace "af_epix" and "Coros Vertix2 Meteo"
### Without pixel burning prevention in always-on mode (on every minute update no pixel is turned off and no other is turned on)
1. After choosing the watchface it starts in high-power Mode
2. After timeout (8s) it goes into low-power mode, then starts 3 minute timer for each pixel
3. After 3 minutes of having watch on hand but without makeing any gestures, the display is turned off and stays black.
4. When screen is black (off), then gesture makes is go back to the high-power state (Step 1.) and the timers are restarted.


## Estimated pixel occupance in a string area
I have created a black string "16:40" with Arial font size 62px on white background, in Gimp. I have fitted image on this string. Then I have selected white color, inverse selection and I have done the histogram, where was shown number of selected pixels.
Results
- Fitted Image size: 151x46 pixels = total 6946 pixels in image.
- Selected black color (string "16:40"): 2997 pixels
- Occupance of black color: ( 2997 / 6946 ) * 100% = 43%

So to estimate number of active pixels I will use 50% of area given from Monkey C Library Dc.getTextDimensions(). This is little more then 43% just to be sure that I do not overcome 10% of active pixels, because it is only estimation.

## MTB Trail in full sun and in forest
In full sun it is very hard to read something from the screen in low-power mode (dimmed).
When I ride a bike I have my hands on the handlebar - obvious.
If I want to see something on the watch I do the small twist of wrist to see the watchface, keeping hand on the handlebar.

In Epix this move is not recognized as gesture and it do not light up (do not go into high-power mode). So in full sun and on the MTB Trai in low-power mode Epix is for me not readable. Here Fenix 3 was much better.
There is some angle of wrist and eyes, where the screen in low-power mode in full sun is so not readable, that it looks like completely black.

To read properly I need to take my hand of the handlebar and do the gesture, to invoke high-power mode and light up the screen, then every thing is very good readable, but what if I will exactly in this time ride on some rock and loose the balance. 

In forest the screen of Epix also in low-power mode was very good readable.

So dear Garmin please make the gestures not only for runners but also for bikers and beside maximum brightness level, make additional setting of minimum brightness level.





# Additional resources about AMOLED and not always-on
## Incorporating Visual Design and Product Personalities
https://developer.garmin.com/connect-iq/user-experience-guidelines/incorporating-the-visual-design-and-product-personalities/

Best Practices

If you can only choose one, focus on light-on-dark themes. A light-on-dark theme will still look acceptable on devices with a default dark-on light display. On the other hand, a dark-on-light them will look out of place on an AMOLED display. Dark-on-light themes are best reserved for apps intended for outdoor activities on MIP displays.

## Watch Faces
https://developer.garmin.com/connect-iq/user-experience-guidelines/watch-faces/

Low- and High-Power Modes

Connect IQ watch faces typically operate in a low-power state where the system requests updates every minute. When the user gestures to look at the watch, the system will request the watch face enter a high-power state. During this period, typically 10 seconds, the watch face can enable timers and play animations. Use this time to add some action to your watch faces.

Always Active

MIP watch faces by default update once a minute. High-power mode does allow drawing seconds or a second hand for a period of time, but sometimes the user wants that kind of information available the moment their eyes focus on the watch.

Always-active watch faces can perform a partial update of the screen every second. The update must operate under a 20 millisecond time frame, which does not allow updating the whole screen but can allow for an update on a small portion. For example, the seconds area of this watch face (highlighted in pink) could be updated once a second:

Always On (AMOLED)

Devices with AMOLED displays typically disable the display when not in use to save power, but they do allow the user to enable an always-on mode. Because long-term display use affects the battery life and can wear down the display, Connect IQ has special rules for AMOLED always-on mode. When the watch face enters always-on mode, the watch face will only update every minute, and each update is limited to using 10% of the available pixels of the display. In addition, a burn-in prevention mechanism will further guide the use of the display on some devices.

## Pixel Count in Epix - field of a cicrle
epix_pixel_count = 2 * Pi * sqrt(418/2) = 137227.9

10% of pixels = 13 722

## Entry Points
https://developer.garmin.com/connect-iq/user-experience-guidelines/entry-points/

Watch Face

Watch faces render in different ways based on what the device supports:

- MIP standard – The watch face will request an update every minute. When the user gestures to look at the watch face, the watch face will begin requesting updates every second for a short period.

- MIP always active – The watch face will request a full update every minute but will allow a small portion of the screen to be updated every second. When the user gestures to look at the watch face, the watch face will begin requesting updates every second for a short period.

- AMOLED standard – The screen is off by default. When the user gestures to look at the watch face, the display will enable, and the watch face will begin requesting updates every second for a short period.

- AMOLED always active (version 1) – The watch face operates with a burn-in detection mechanism that will prevent any pixel from being enabled for more than four minutes, or for the watch face from using more than 10% of the screen pixels. When the user gestures to look at the watch face, the display will turn on, the pixel limits are disabled, and the watch face will begin requesting updates every second for a short period.

- AMOLED always active (version 2) - The watch face is prevented from using more than 10% of the screen pixels. When the user gestures to look at the watch face, the display will turn on, the pixel limits are disabled, and the watch face will begin requesting updates every second for a short period.

## How do I Make a Watch Face for AMOLED Products?
https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-make-a-watch-face-for-amoled-products/

### Since API level 3.1.0

The Venu is the first Garmin watch with an AMOLED screen, AMOLED displays provide vibrant colors with a high pixel density, but over time the organic materials used to create the display will decay. In order to mitigate the decay and prolong the screen life in general, a protective mechanism is deployed to watches that have AMOLED screen, such as Venu.

### What Qualifies as Burn-In

Pixels in an AMOLED display only draw power when illuminated, so a pixel is considered on when rendering any color other than black, and is considered off when and only when rendering black pixel.

Burn-in protection is only activated when Connect IQ watch face is in foreground and after system enters sleep mode. Under such conditions, if more than 10% of the screen pixels are on or any pixel is on for longer than 3 minutes, the system will shut off the screen.

Most of the existing Connect IQ watch faces will trip the burn-in protector, however there is still hope to have an always-on watch face on AMOLED screens.

### Best Practices for AMOLED Screens

Now on AMOLED Garmin products, your apps can have breathtaking presentations of information and gorgeous imagery, while still retaining days of battery life. However, now that we have given you all these gorgeous colors, could you, like, not use them? Please?

Here is the challenge with AMOLED – every pixel draws power. If you want your apps to fall within the regular amount of battery life, you want to have as much black on screen as possible, especially in screens that are showing activity information. You’ll notice that with most of the native applications, black is the new black. It’s okay to work a periodic splash screen or gradient into your apps – make the app look great! – but for screens that are supposed to show constantly updating data, the blacker the better. Also, if you have header and footer gradients, try to have the darker parts at the outer edges.

Just remember this handy guide when doing app layouts for AMOLED screens:

How to Create Always-On Watch Faces
Always On watch faces behave differently from MIP to AMOLED. With MIP screens, you can use View.onPartialUpdate to update a portion of the screen every second. With AMOLED screen, this is no longer allowed. Instead, when WatchUi.onEnterSleep is called, you are allowed to render a watch face that must obey the rules of the AMOLED burn-in protector:

- No more than 10% screen pixels can be on
- No pixel can be on longer than 3 mins

Ways you can prevent burn in are by drawing the time with a thin font, shifting the time every minute as not to repeatedly leave the same pixels on, and not having static tick marks that leave the same pixels on.

Note: App can detect whether a product has screen protection enforced by checking the value of DeviceSettings.requiresBurnInProtection.

## Good watchface basics example from Joshua Miller
- https://medium.com/@JoshuaTheMiller/making-a-watchface-for-garmin-devices-8c3ce28cae08
- https://github.com/JoshuaTheMiller/Multivision-Watch/blob/main/Source/source/PluralsightTributeView.mc

### How to count estimated pixel count of a string in monkey C
1. getTextDimensions(text as Lang.String, font as Graphics.FontType) as Lang.Array<Lang.Number>
https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics/Dc.html#getTextDimensions-instance_function

2. Gimp Histogram to count selected pixels on an image
https://docs.gimp.org/2.10/en/gimp-histogram-dialog.html
Pixels : The number of pixels in the active layer or selection.

