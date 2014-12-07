#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import psycopg2.extras
import jinja2
import datetime
import uuid
import sys

from pytz import timezone

psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)


con = None

try:
     
    con = psycopg2.connect(database='rosebud2', user='stefan', password='ziegler12') 
    cur = con.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    
    sql = """SELECT array_agg(uri) as uri, identifier, array_agg(format_txt) as format_txt, array_agg(srs_txt) as srs_txt, array_agg(srs_epsg) as srs_epsg, array_agg(modified) as modified, array_agg(my_format) as format, array_agg(bbox) as bbox, array_agg(title) as title, array_agg(abstract) as abstract
FROM
(
SELECT a.*, c.uri, c.format as my_format, c.format_txt, c.srs_txt, c.srs_epsg, round(y_min::numeric, 8) || ' ' || round(x_min::numeric, 8) || ' ' || round(y_max::numeric, 8) || ' ' || round(x_max::numeric, 8) as bbox
FROM metadb_ng.metadb as a,
(
 SELECT metadb_id_child as id
 FROM metadb_ng.metadb_relation
 WHERE metadb_id_parent = 'fd6884e2-385c-463a-a59a-447560bd187c'
) as b,
metadb_ng.onlineresource as c
WHERE a.identifier = b.id
AND a.identifier = c.metadb_id
ORDER BY a.modified DESC
) as z
GROUP BY identifier
ORDER BY modified DESC"""

    cur.execute(sql)          
    
    rows = cur.fetchall()
    
    items = []
    mytimezone = timezone('Europe/Amsterdam')
    max_modified = datetime.datetime.strptime( "1900-01-01T00:00:00", "%Y-%m-%dT%H:%M:%S" )
    for row in rows:        
        if row['modified'][0] > max_modified:
            max_modified = row['modified'][0]
        row['updated'] = mytimezone.localize(row['modified'][0]).strftime('%Y-%m-%dT%H:%M:%SZ')
        row['title'] = row['title'][0]
        row['abstract'] = row['abstract'][0]        
        row['bbox'] = row['bbox'][0]     
        row['uuid'] = "urn:uuid:" + str(uuid.uuid4())
        items.append(row)
  
    max_modified_tz = mytimezone.localize(max_modified)
    updated = max_modified_tz.strftime('%Y-%m-%dT%H:%M:%SZ')
    

except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)


finally:
    
    if con:
        con.close()
        
# service feed        
env = jinja2.Environment(loader=jinja2.FileSystemLoader("/home/stefan/Dropbox/Projekte/inspire_atom/python"))
output = env.get_template("template_servicefeed.xml").render(items = items, updated = updated).encode('utf-8')

with open("/home/stefan/Dropbox/Projekte/inspire_atom/python/dls/amtlichevermessung", "w") as fh:
    fh.write(output)


# dataset feeds
for item in items:
    # every new feeds gets an new id (=uuid) / Inspire sagt was anderes, dann funktionierts aber nicht z.B. mit Thunderbird
    uuids = []
    for i in range(len(item['uri'])):
        uuids.append("urn:uuid:" + str(uuid.uuid4()))
    item['uuids'] = uuids
 
    env = jinja2.Environment(loader=jinja2.FileSystemLoader("/home/stefan/Dropbox/Projekte/inspire_atom/python"))
    output = env.get_template("template_datasetfeed.xml").render(item = item, updated = updated).encode('utf-8')

    #print output
    with open("/home/stefan/Dropbox/Projekte/inspire_atom/python/dls/"+item['identifier'], "w") as fh:
        fh.write(output)

