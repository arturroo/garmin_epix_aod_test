import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class af_epixView extends WatchUi.WatchFace {
    private var powerMode;
    private var highPowerMode;
    private var highPowerColors;
    private var lowPowerColors;
    private var timeColors;
    private var modeColors;

    function initialize() {
        self.powerMode = "START";
        self.highPowerMode = true;
        self.timeColors = {
              "START" => 0xFF55FF
            , "HIGH" => 0xFF55FF
            , "LOW" => 0x0055FF
        };
        self.modeColors = {
              "START" => 0x33FF88
            , "HIGH" => 0x33FF88
            , "LOW" => 0x226633
        };

        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        setTimeDisplay();
        setPowerModeDisplay();
        // setArcDisplay(dc);
        setBatteryDisplay();
        setStepsDisplay();


        // Call the parent onUpdate function to redraw the layout        
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        // status used in onUpdate();
        self.powerMode = "HIGH";
        self.highPowerMode = true;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
        // status used in onUpdate();
        self.powerMode = "LOW";
        self.highPowerMode = false;
    }

    // draw AF watchface
    function setTimeDisplay() as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var view = View.findDrawableById("TimeDisplay") as Text;
        view.setColor(self.timeColors.get(self.powerMode));
        view.setText(timeString);
    }

    function setPowerModeDisplay() as Void {
        var mymode = View.findDrawableById("ModeDisplay") as Text;
        mymode.setColor(self.modeColors.get(self.powerMode));
        mymode.setText(self.powerMode);
    }

    function setBatteryDisplay() {
    	var battery = System.getSystemStats().battery;	
		var batteryBarDisplay = View.findDrawableById("BatteryBarDisplay");
		batteryBarDisplay.setPercent(battery/100);
    }

    function setStepsDisplay() {
        var stepCount = ActivityMonitor.getInfo().steps.toString();
		var stepsBarDisplay = View.findDrawableById("StepsBarDisplay");
		stepsBarDisplay.setHighPowerMode(self.highPowerMode);
    }

}
