using Toybox.WatchUi as Ui;
import Toybox.Math;

class LongBar extends Ui.Drawable {
	hidden var centerX;
    hidden var centerY;

	hidden var highPowerMode, percent, color, x, y, width, height, radius;
	
    function initialize(params) {
        Drawable.initialize(params);

		highPowerMode = true;

        color = params.get(:color);
        percent = params.get(:percent);
        width = params.get(:width);
        height = params.get(:height);
		radius = params.get(:radius);
        x = params.get(:x);
        y = params.get(:y);
    }

    function draw(dc) {
		dc.setColor(color, color);
        
		if (self.highPowerMode) {
			dc.fillRoundedRectangle(x, y, width, height, radius);
		} else {
			dc.drawRoundedRectangle(x, y, width, height, radius);
		}
    }
    
    function setPercent(newPercent) {
    	percent = newPercent;       	 
    }

    function setHighPowerMode(newHighPowerMode) {
    	highPowerMode = newHighPowerMode;
    }

    function setPosition(dc, newX, newY, center_relative) {
        if (center_relative) {
       	    centerX = dc.getWidth() / 2 + newX;
    	    centerY = dc.getHeight() / 2; 
		    x = centerX - width / 2;
		    y = centerY + newY;
        } else {
            x = newX;
		    y = newY;
        }
    }
    
}