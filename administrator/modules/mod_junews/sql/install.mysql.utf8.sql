/* enable module, set position to 'status', hide title and put module as last in status container */
UPDATE #__modules
SET position = 'cpanel'
,   published = 1
,   showtitle = 0
,	ordering = 99
WHERE module = 'mod_junews'
AND   client_id = 1;

/* show module for all menus in adminstrator */
INSERT INTO #__modules_menu (moduleid, menuid)
SELECT #__modules.id, 0 
FROM #__modules 
WHERE #__modules.module = 'mod_junews'
AND   #__modules.position = 'cpanel'
AND   NOT EXISTS (SELECT 1 FROM #__modules_menu WHERE moduleid = #__modules.id)
ORDER BY id DESC
LIMIT 1;
