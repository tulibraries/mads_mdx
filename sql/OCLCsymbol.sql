/*Use to spit out the OCLC symbol based on library name and location. To use, add an index to the Analytics report, select 'Edit formula', and paste the following into 'Column formula', replacing existing text. To rename the column header, check 'Custom headings' above (in the same 'Edit formula' window) and edit the column name. 
*/
CASE 
	WHEN "Location"."Library Name" = 'Paley Library'
		THEN 'TEU'
	WHEN "Location"."Library Name" = 'Blockson Collection'
		THEN 'TEU'
	WHEN "Location"."Library Name" = 'Media Services'
		THEN 'TEU'
	WHEN "Location"."Library Name" = 'Ambler Campus Library'
		THEN 'TEU'
	WHEN "Location"."Library Name" = 'Special Collections Research Center'
		THEN 'TEU'
	WHEN "Location"."Library Name" = 'Ginsburg Health Science Library'
		THEN 'TMY'
	WHEN "Location"."Library Name" = 'Harrisburg Campus Library'
		THEN 'TEU'
	WHEN "Location"."Library Name" = 'Podiatry Library'
		THEN 'QBA'
	WHEN "Location"."Library Name" = 'Law Library'
		THEN 'tulaw'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Paley Remote Stacks')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Paley Remote Microform')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Paley Remote Media')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Paley GovDocs')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Paley GovDoc Micro')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Ambler Rare Stacks')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Blockson Rare Stacks')
		THEN 'TEU'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Ginsburg Remote Stacks')
		THEN 'TMY'
	WHEN ("Location"."Library Name" = 'Remote Storage' AND "Location"."Location Name" = 'Ambler Rare Stacks')
		THEN 'TEU'
	ELSE 'No OCLC symbol'
END