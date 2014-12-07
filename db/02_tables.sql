--DROP TABLE metadb_ng.metadb;

CREATE TABLE metadb_ng.metadb
(
 ogc_fid serial PRIMARY KEY, 
 identifier varchar NOT NULL, 
 title varchar, 
 abstract varchar, 
 "type" integer, 
 format varchar, 
 modified timestamp, 
 subject varchar, 
 onlineresource varchar, 
 haspart varchar, 
 source varchar, 
 publisher varchar, 
 "language" varchar, 
 rights varchar, 
 relation varchar, 
 x_min float,
 y_min float,
 x_max float,
 y_max float,
 the_geom geometry(POLYGON, 4326)
)
WITH (OIDS=FALSE);
ALTER TABLE metadb_ng.metadb OWNER TO stefan;
GRANT ALL ON metadb_ng.metadb TO stefan;
GRANT SELECT ON metadb_ng.metadb TO mspublic;

CREATE INDEX idx_metadb_ng_metadb_ogc_fid
  ON metadb_ng.metadb
  USING btree
  (ogc_fid);

CREATE INDEX idx_metadb_ng_metadb_title
  ON metadb_ng.metadb
  USING btree
  (title);

CREATE INDEX idx_metadb_ng_metadb_the_geom
  ON metadb_ng.metadb
  USING gist
  (the_geom);


CREATE TABLE metadb_ng.metadb_relation
(
 ogc_fid serial PRIMARY KEY, 
 metadb_id_parent varchar NOT NULL,
 metadb_id_child varchar NOT NULL
)
WITH (OIDS=FALSE);

ALTER TABLE metadb_ng.metadb_relation OWNER TO stefan;
GRANT ALL ON metadb_ng.metadb_relation TO stefan;
GRANT SELECT ON metadb_ng.metadb_relation TO mspublic;

CREATE TABLE metadb_ng.service_dataset
(
 ogc_fid serial PRIMARY KEY, 
 service_id varchar NOT NULL, 
 dataset_id varchar NOT NULL
)
WITH (OIDS=FALSE);

ALTER TABLE metadb_ng.service_dataset OWNER TO stefan;
GRANT ALL ON metadb_ng.service_dataset TO stefan;
GRANT SELECT ON metadb_ng.service_dataset TO mspublic;

-- DROP TABLE metadb_ng.onlineresource;
CREATE TABLE metadb_ng.onlineresource
(
 ogc_fid serial PRIMARY KEY, 
 metadb_id varchar,
 uri varchar,
 format varchar,
 modified timestamp,
 "language" varchar,
 format_txt character varying,
 srs_txt character varying,
 srs_epsg character varying
)
WITH (OIDS=FALSE);

ALTER TABLE metadb_ng.onlineresource OWNER TO stefan;
GRANT ALL ON metadb_ng.onlineresource TO stefan;
GRANT SELECT ON metadb_ng.onlineresource TO mspublic;


CREATE TABLE metadb_ng."type"
(
 ogc_fid serial PRIMARY KEY, 
 code integer,
 code_txt varchar
)
WITH (OIDS=FALSE);

ALTER TABLE metadb_ng."type" OWNER TO stefan;
GRANT ALL ON metadb_ng."type" TO stefan;
GRANT SELECT ON metadb_ng."type" TO mspublic;

