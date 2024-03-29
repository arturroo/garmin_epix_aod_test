using Toybox.WatchUi as Ui;
import Toybox.Math;

class CircularBar extends Ui.Drawable {
	hidden var centerX;
    hidden var centerY;

	hidden var percent, color, orientation, barThickness, barGap, startingRadius;	
	
    function initialize(params) {
        Drawable.initialize(params);

        color = params.get(:color);
        percent = params.get(:percent);                
        orientation = params.get(:orientation);
        barThickness = params.get(:barThickness);        
        barGap = params.get(:barGap);      
        
        var tryGetStartingRadius = params.get(:startingRadius); 
        
        if(tryGetStartingRadius != null) {
        	startingRadius = tryGetStartingRadius;
        }
        else {
        	startingRadius = 118; 
        }
                        
    }

    function draw(dc) {
    	centerX = dc.getWidth() / 2;
    	centerY = dc.getHeight() / 2;    
        
        drawArcGroups(dc, 1, barGap);                                                          
        drawArcGroups(dc, percent, barThickness);
    }
    
    function setPercent(newPercent) {
    	percent = newPercent;       	 
    }
    
    hidden function drawArcGroups(dc, percent, barWidth) {      	        	    
    	dc.setColor(color, color);         
    	
    	var radianStart = degreesToRadians(5);
    	var maxRadianAddition = degreesToRadians(55);
    	
    	if(percent > 1) {
    		percent = 1;
    	}
    	
    	// This is to solve a bug where the drawing of the circle flips out
    	// when percent is at 1.
    	// I'm tired. 
    	if(percent < .02) {
    		percent = 0;
    	}
    	
    	var radianEndFromPercent = radianStart + maxRadianAddition * percent;
    	
    	if(radianEndFromPercent <= radianStart)
    	{
    		return;
    	}
    	
    	var orientedStart = radianStart;
    	var orientedEnd = radianEndFromPercent;    	
    	
    	if(orientation == 0) {
    		orientedStart += Math.PI;
    		orientedEnd += Math.PI;
    	}
    	
    	drawDoubleArcs(dc, barWidth, 0, orientedStart, orientedEnd);
    	drawDoubleArcs(dc, barWidth, 1, -orientedStart, -orientedEnd);
    }     
    
    hidden function drawDoubleArcs(dc, thickness, direction, radianStart, radianEnd) {
    	for(var i = 0; i < thickness; i++) {
    		dc.drawArc(centerX, centerY, startingRadius - i, direction, radiansToDegrees(radianStart), radiansToDegrees(radianEnd));
    		
    		dc.drawArc(centerX, centerY, startingRadius - barThickness - barGap - i, direction, radiansToDegrees(radianStart), radiansToDegrees(radianEnd));
    	}        		    	
    }
    
    hidden function degreesToRadians(degrees) {
    	return degrees * Math.PI / 180;
    }  
    
    hidden function radiansToDegrees(radians) {
    	return radians * 180 / Math.PI;
    }  
}