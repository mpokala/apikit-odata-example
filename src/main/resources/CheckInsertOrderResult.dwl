%dw 1.0
%output application/java

// APIkit Odata Service puts an inbound property that contains the table's name 
%var remoteEntityName = inboundProperties['odata.remoteEntityName']

// APIkit Odata Service puts an inbound property that contains the fields of your entity. It's a list of string (List<String>)
%var entityFields = inboundProperties['odata.fields']

%var originalPayload = flowVars['originalPayload']

%var orderId = payload[0].GENERATED_KEY

// This key is not autogenerated so it's in the original payload
%var shipName = originalPayload.ShipName
---
"SELECT " ++ ( ( entityFields map "`$`" ) joinBy ", ") ++ " FROM $remoteEntityName where OrderID = '$orderId' and ShipName = '$shipName'"
