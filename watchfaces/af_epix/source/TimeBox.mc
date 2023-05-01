using Toybox.WatchUi as Ui;
import Toybox.Math;
import Toybox.System;
import Toybox.Lang;


class TimeBox extends Ui.Text {
	hidden var centerX;
    hidden var centerY;

	hidden var highPowerMode;
    //, text, color, x, y, font;
	
    function initialize(params) {
        Drawable.initialize(params);

		highPowerMode = true;

        text = params.get(:text);
        color = params.get(:color);
        locX = params.get(:x);
        locY = params.get(:y);
        font = params.get(:font);
        justification = params.get(:justification);
    }

    // function draw(dc) {
	// 	dc.setColor(color, color);
    //     
	// 	if (self.highPowerMode) {
	// 		dc.fillRoundedRectangle(x, y, width, height, radius);
	// 	} else {
	// 		dc.drawRoundedRectangle(x, y, width, height, radius);
	// 	}
    // }
    // 
    // function setPercent(newPercent) {
    // 	percent = newPercent;       	 
    // }

    function setHighPowerMode(newHighPowerMode) {
    	highPowerMode = newHighPowerMode;
    }

    function setPosition(dc, newX, newY, center_relative) {
        if (center_relative) {
       	    centerX = Ui.LAYOUT_HALIGN_CENTER;
    	    centerY = Ui.LAYOUT_VALIGN_CENTER; 
		    x = centerX - width / 2 + newX;
		    y = centerY - height / 2 + newY;
        } else {
            x = newX;
		    y = newY;
        }
    }

    function getTimeString() {
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
        return timeString;
    }
    
}