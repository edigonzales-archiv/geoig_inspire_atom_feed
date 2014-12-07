-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.7.2
-- PostgreSQL version: 9.0
-- Project Site: pgmodeler.com.br
-- Model Author: ---

SET check_function_bodies = false;
-- ddl-end --

-- object: stefan | type: ROLE --
-- DROP ROLE stefan;
CREATE ROLE stefan WITH 
	CREATEDB
	CREATEROLE
	LOGIN;
-- ddl-end --

-- object: mspublic | type: ROLE --
-- DROP ROLE mspublic;
CREATE ROLE mspublic WITH 
	LOGIN;
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: rosebud2 | type: DATABASE --
-- -- DROP DATABASE rosebud2;
-- CREATE DATABASE rosebud2
-- 	OWNER = stefan
-- ;
-- -- ddl-end --
-- 

-- object: metadb_ng | type: SCHEMA --
-- DROP SCHEMA metadb_ng;
CREATE SCHEMA metadb_ng;
ALTER SCHEMA metadb_ng OWNER TO stefan;
-- ddl-end --

SET search_path TO pg_catalog,public,metadb_ng;
-- ddl-end --

-- object: metadb_ng.metadb | type: TABLE --
-- DROP TABLE metadb_ng.metadb;
CREATE TABLE metadb_ng.metadb(
	ogc_fid serial,
	identifier character varying NOT NULL,
	title character varying NOT NULL,
	abstract character varying,
	type integer NOT NULL,
	modified timestamp,
	x_min double precision,
	y_min double precision,
	x_max double precision,
	y_max double precision,
	the_geom geometry(POLYGON, 4326),
	CONSTRAINT metadb_ng_metadb_pkey PRIMARY KEY (ogc_fid),
	CONSTRAINT unique_identifier UNIQUE (identifier)

);
-- ddl-end --
ALTER TABLE metadb_ng.metadb OWNER TO stefan;
-- ddl-end --

-- object: metadb_ng.type | type: TABLE --
-- DROP TABLE metadb_ng.type;
CREATE TABLE metadb_ng.type(
	ogc_fid serial,
	code integer NOT NULL,
	code_txt character varying NOT NULL,
	CONSTRAINT metadb_ng_type_pkey PRIMARY KEY (ogc_fid),
	CONSTRAINT unique_code UNIQUE (code)

);
-- ddl-end --
ALTER TABLE metadb_ng.type OWNER TO stefan;
-- ddl-end --

-- object: metadb_ng.metadb_relation | type: TABLE --
-- DROP TABLE metadb_ng.metadb_relation;
CREATE TABLE metadb_ng.metadb_relation(
	ogc_fid serial,
	metadb_id_parent character varying NOT NULL,
	metadb_id_child character varying NOT NULL,
	CONSTRAINT metadb_ng_metadb_relation_pkey PRIMARY KEY (ogc_fid)

);
-- ddl-end --
ALTER TABLE metadb_ng.metadb_relation OWNER TO stefan;
-- ddl-end --

-- object: metadb_ng.online_dataset | type: TABLE --
-- DROP TABLE metadb_ng.online_dataset;
CREATE TABLE metadb_ng.online_dataset(
	ogc_fid serial,
	metadb_id character varying NOT NULL,
	uri character varying NOT NULL,
	format_mime character varying NOT NULL,
	format_txt character varying NOT NULL,
	modified timestamp NOT NULL,
	srs_epsg integer NOT NULL,
	srs_txt character varying,
	CONSTRAINT metadb_ng_online_dataset_pkey PRIMARY KEY (ogc_fid)

);
-- ddl-end --
ALTER TABLE metadb_ng.online_dataset OWNER TO stefan;
-- ddl-end --

-- object: metadb_type_fkey | type: CONSTRAINT --
-- ALTER TABLE metadb_ng.metadb DROP CONSTRAINT metadb_type_fkey;
ALTER TABLE metadb_ng.metadb ADD CONSTRAINT metadb_type_fkey FOREIGN KEY (type)
REFERENCES metadb_ng.type (code) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: metadb_relation_parent_metadb_id_fkey | type: CONSTRAINT --
-- ALTER TABLE metadb_ng.metadb_relation DROP CONSTRAINT metadb_relation_parent_metadb_id_fkey;
ALTER TABLE metadb_ng.metadb_relation ADD CONSTRAINT metadb_relation_parent_metadb_id_fkey FOREIGN KEY (metadb_id_parent)
REFERENCES metadb_ng.metadb (identifier) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: metadb_relation_child_metadb_id_fkey | type: CONSTRAINT --
-- ALTER TABLE metadb_ng.metadb_relation DROP CONSTRAINT metadb_relation_child_metadb_id_fkey;
ALTER TABLE metadb_ng.metadb_relation ADD CONSTRAINT metadb_relation_child_metadb_id_fkey FOREIGN KEY (metadb_id_child)
REFERENCES metadb_ng.metadb (identifier) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: online_dataset_metadb_identifier_fkey | type: CONSTRAINT --
-- ALTER TABLE metadb_ng.online_dataset DROP CONSTRAINT online_dataset_metadb_identifier_fkey;
ALTER TABLE metadb_ng.online_dataset ADD CONSTRAINT online_dataset_metadb_identifier_fkey FOREIGN KEY (metadb_id)
REFERENCES metadb_ng.metadb (identifier) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: grant_2ef277cfd3 | type: PERMISSION --
GRANT USAGE
   ON SCHEMA metadb_ng
   TO mspublic;
-- ddl-end --

-- object: grant_7eb3329c6f | type: PERMISSION --
GRANT SELECT
   ON TABLE metadb_ng.metadb
   TO mspublic;
-- ddl-end --

-- object: grant_82a878ee0e | type: PERMISSION --
GRANT SELECT
   ON TABLE metadb_ng.type
   TO mspublic;
-- ddl-end --

-- object: grant_425ebbb1de | type: PERMISSION --
GRANT SELECT
   ON TABLE metadb_ng.metadb_relation
   TO mspublic;
-- ddl-end --

-- object: grant_5174bb5f10 | type: PERMISSION --
GRANT SELECT
   ON TABLE metadb_ng.online_dataset
   TO mspublic;
-- ddl-end --


