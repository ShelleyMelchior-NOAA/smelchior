#!/bin/bash

proj=PRECIP3-W8R2WPW
echo "project: $proj"

per1="Hong Guan"
per2="Xu Li"
per3="PM"

per1rate=95.72
per2rate=95.72
per3rate=106.01

per1FTE=0.5
per2FTE=0.5
per3FTE=0.025
echo "personnel: $per1 ($per1rate, $per1FTE), $per2 ($per2rate, $per2FTE), $per3 ($per3rate, $per3FTE)
"
# Funds remaining as of 3/31/2025
fundsleftmarch=26273.64
echo "Funds remaining as of March 31, 2025: $fundsleftmarch"


# April cost
per1leave=0
per2leave=0
per3leave=0
billablehrs=$(expr 88 + 88)
echo "April billable hours: $billablehrs"
aprcostper1=$(awk "BEGIN {print $per1rate*$per1FTE*($billablehrs-$per1leave)}")
aprcostper2=$(awk "BEGIN {print $per2rate*$per2FTE*($billablehrs-$per2leave)}")
aprcostper3=$(awk "BEGIN {print $per3rate*$per3FTE*($billablehrs-$per3leave)}")
aprcosttotal=$(awk "BEGIN {print $aprcostper1+$aprcostper2+$aprcostper3}")
echo "Total cost for April: $aprcosttotal"

# Funds reamining as of 4/30/2025
fundsleftapril=$(awk "BEGIN {print $fundsleftmarch-$aprcosttotal}")
echo "Funds remaining as of April 30, 2025: $fundsleftapril"

# Runway for reamining funds
per1dailycost=$(awk "BEGIN {print $per1rate*$per1FTE*8}")
per2dailycost=$(awk "BEGIN {print $per2rate*$per2FTE*8}")
per3dailycost=$(awk "BEGIN {print $per1rate*$per3FTE*8}")
dailycosttotal=$(awk "BEGIN {print $per1dailycost+$per2dailycost+$per3dailycost}")

# Remaining days
days=$(awk "BEGIN {print $fundsleftapril/$dailycosttotal}") #decimal
days=$(awk -v n="$days" 'BEGIN {print int(n)}')             #integer
echo "$fundsleftapril will last for $days working days."
per1days=$(awk "BEGIN {print $per1dailycost*$days}")
per2days=$(awk "BEGIN {print $per2dailycost*$days}")
per3days=$(awk "BEGIN {print $per3dailycost*$days}")
daystotal=$(awk "BEGIN {print $per1days+$per2days+$per3days}")
echo $daystotal

per1hrs=$(awk "BEGIN {print $per1FTE*$days*8}")
per2hrs=$(awk "BEGIN {print $per2FTE*$days*8}")
echo "$per1 will charge $per1hrs hrs for May"
echo "$per2 will charge $per2hrs hrs for May"

# How many hours can PM charge?
