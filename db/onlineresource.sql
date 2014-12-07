/*
INSERT INTO metadb_ng.onlineresource (metadb_id, modified, format, uri) 
SELECT metadb_id, modified, 'application/zip'::text as format, 'http://www.catais.org/geodaten/ch/so/kva/av/mopublic/shp/lv03/d/' || substr(uri, 69,4) || '.zip' as uri
FROM metadb_ng.onlineresource
WHERE uri LIKE 'http://www.catais.org/geodaten/ch/so/kva/av/dm01avch24d/itf/lv03/ch_%'
*/

SELECT array_agg(uri), identifier, array_agg(modified) as modified, array_agg(my_format) as format, array_agg(bbox), array_agg(title) as title, array_agg(abstract) as abstract
FROM
(
SELECT a.*, c.uri, c.format as my_format, round(y_min::numeric, 8) || ' ' || round(x_min::numeric, 8) || ' ' || round(y_max::numeric, 8) || ' ' || round(x_max::numeric, 8) as bbox
FROM metadb_ng.metadb as a,
(
 SELECT metadb_id_child as id
 FROM metadb_ng.metadb_relation
 WHERE metadb_id_parent = 'fd6884e2-385c-463a-a59a-447560bd187c'
) as b,
metadb_ng.onlineresource as c
WHERE a.identifier = b.id
AND a.identifier = c.metadb_id
ORDER BY a.modified DESC, a.title ASC
) as z
GROUP BY identifier
ORDER BY modified DESC

