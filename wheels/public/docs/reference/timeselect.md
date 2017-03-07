```coldfusion
// View code 
<cfoutput>
    #timeSelect(objectName="business", property="openUntil")#
</cfoutput>

// Show fields for hour and minute 
<cfoutput>
	#timeSelect(objectName="business", property="openUntil", order="hour,minute")#
</cfoutput>

// Only show 15-minute intervals 
<cfoutput>
	#timeSelect(objectName="appointment", property="dateTimeStart", minuteStep=15)#
</cfoutput>
```