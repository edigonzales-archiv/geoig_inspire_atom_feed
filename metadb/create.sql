DELETE FROM "metadb" WHERE title LIKE "AV%";

CREATE TABLE "metadb" 
(
 "pkuid" integer NOT NULL, 
 "identifier" varchar NOT NULL, 
 "title" varchar, 
 "abstract" varchar, 
 "type" varchar, 
 "format" varchar, 
 "modified" datetime, 
 "subject" varchar, 
 "onlineresource" varchar, 
 "haspart" varchar, 
 "source" varchar, 
 "publisher" varchar, 
 "language" varchar, 
 "rights" varchar, 
 "relation" varchar, 
 "xmin" float,
 "ymin" float,
 "xmax" float,
 "ymax" float,
 PRIMARY KEY ("pkuid")
);

CREATE TABLE "metadbrelation"
(
 "pkuid" integer NOT NULL, 
 "metadb_id_parent" varchar NOT NULL,
 "metadb_id_child" varchar NOT NULL,
 PRIMARY KEY ("pkuid")
);



CREATE TABLE "servicedataset" 
(
 "pkuid" integer NOT NULL, 
 "service_id" varchar NOT NULL, 
 "dataset_id" varchar NOT NULL, 
 PRIMARY KEY ("pkuid")
);

CREATE TABLE "onlineresource"
(
 "pkuid" integer NOT NULL,
 "metadb_id" varchar,
 "format" varchar,
 "modified" datetime,
 "language" varchar,
 PRIMARY KEY ("pkuid")
);

CREATE TABLE "type" 
(
 "pkuid" integer NOT NULL,
 code integer,
 code_txt varchar,
 PRIMARY KEY ("pkuid")
);


INSERT INTO "type" (code, code_txt) VALUES (0, 'undefined');
INSERT INTO "type" (code, code_txt) VALUES (1, 'dataset');
INSERT INTO "type" (code, code_txt) VALUES (2, 'service'); -- wfs / wms etc. einzeln
INSERT INTO "type" (code, code_txt) VALUES (3, 'postgres');

INSERT INTO [metadb] ([pkuid], [identifier], [title], [abstract], [type], [format], [modified], [subject], [onlineresource], [haspart], [source], [publisher], [language], [rights], [relation], [xmin], [ymin], [xmax], [ymax]) VALUES (1, '{fd6884e2-385c-463a-a59a-447560bd187c}', 'Amtliche Vermessung', 'Amtliche Vermessung des Kantons Solothurn', 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);