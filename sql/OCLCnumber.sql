/*Use to cull the OCLC master record number from the 'Network number' index, which includes 035s and 019s. To use, add the 'Network number' index to the Analytics report, select 'Edit formula', and paste the following into 'Column formula', replacing existing text. See http://emory.screenstepslive.com/s/alma/m/analytics/l/799868-oclc-number-sql-query for more information.

To rename the column header, check 'Custom headings' above (in the same 'Edit formula' window) and edit the column name.*/
CASE 
	WHEN UPPER("Physical Items"."Bibliographic Details"."Network Number") LIKE '%OCOLC%'
		THEN REPLACE(LEFT(SUBSTRING("Physical Items"."Bibliographic Details"."Network Number" FROM LOCATE('(OCOLC',UPPER("Physical Items"."Bibliographic Details"."Network Number"))),LOCATE(' ',SUBSTRING(CONCAT("Physical Items"."Bibliographic Details"."Network Number",'; ') FROM LOCATE('(OCOLC',UPPER("Physical Items"."Bibliographic Details"."Network Number"))))),';','')
	WHEN UPPER("Physical Items"."Bibliographic Details"."Network Number") LIKE '%OCM%'
		THEN REPLACE(LEFT(SUBSTRING("Physical Items"."Bibliographic Details"."Network Number" FROM LOCATE('OCM',UPPER("Physical Items"."Bibliographic Details"."Network Number"))),LOCATE(' ',SUBSTRING(CONCAT("Physical Items"."Bibliographic Details"."Network Number",'; ') FROM LOCATE('OCM',UPPER("Physical Items"."Bibliographic Details"."Network Number"))))),';','')
	WHEN UPPER("Physical Items"."Bibliographic Details"."Network Number") LIKE '%OCN%'
		THEN REPLACE(LEFT(SUBSTRING("Physical Items"."Bibliographic Details"."Network Number" FROM LOCATE('OCN',UPPER("Physical Items"."Bibliographic Details"."Network Number"))),LOCATE(' ',SUBSTRING(CONCAT("Physical Items"."Bibliographic Details"."Network Number",'; ') FROM LOCATE('OCN',UPPER("Physical Items"."Bibliographic Details"."Network Number"))))),';','')
	WHEN UPPER("Physical Items"."Bibliographic Details"."Network Number") LIKE '%ON%'
		THEN REPLACE(LEFT(SUBSTRING("Physical Items"."Bibliographic Details"."Network Number" FROM LOCATE('ON',UPPER("Physical Items"."Bibliographic Details"."Network Number"))),LOCATE(' ',SUBSTRING(CONCAT("Physical Items"."Bibliographic Details"."Network Number",'; ') FROM LOCATE('ON',UPPER("Physical Items"."Bibliographic Details"."Network Number"))))),';','')
	WHEN UPPER("Physical Items"."Bibliographic Details"."Network Number") LIKE '%OCLC%'
		THEN REPLACE(LEFT(SUBSTRING("Physical Items"."Bibliographic Details"."Network Number" FROM LOCATE('OCLC',UPPER("Physical Items"."Bibliographic Details"."Network Number"))),LOCATE(' ',SUBSTRING(CONCAT("Physical Items"."Bibliographic Details"."Network Number",'; ') FROM LOCATE('OCLC',UPPER("Physical Items"."Bibliographic Details"."Network Number"))))),';','')
	ELSE 'No OCLC Number Available'
END