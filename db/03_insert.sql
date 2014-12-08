INSERT INTO metadb_ng."type" (code, code_txt) VALUES (0, 'undefined');
INSERT INTO metadb_ng."type" (code, code_txt) VALUES (100, 'dataset');
INSERT INTO metadb_ng."type" (code, code_txt) VALUES (200, 'wms');  
INSERT INTO metadb_ng."type" (code, code_txt) VALUES (210, 'wmts');  
INSERT INTO metadb_ng."type" (code, code_txt) VALUES (220, 'wfs');  
INSERT INTO metadb_ng."type" (code, code_txt) VALUES (230, 'wps');  
INSERT INTO metadb_ng."type" (code, code_txt) VALUES (500, 'postgres');  


INSERT INTO metadb_ng.metadb (identifier, title, abstract, "type") VALUES ('fd6884e2-385c-463a-a59a-447560bd187c', 'Amtliche Vermessung', 'Amtliche Vermessung des Kantons Solothurn', 0);


INSERT INTO metadb_ng.metadb (identifier, title, abstract, "type") VALUES ('203726e0-577f-45da-901f-5417a5e0022c', 'Basisplan der amtlichen Vermessung', 'Basisplan der amtlichen Vermessung des Kantons Solothurn', 0);

INSERT INTO metadb_ng.metadb (identifier, title, abstract, "type") VALUES ('93eb36e5-5f16-4d98-b704-f6e087f647b8', 'Basisplan (farbig) der amtlichen Vermessung', 'Basisplan (farbig) der amtlichen Vermessung des Kantons Solothurn', 0);

INSERT INTO metadb_ng.metadb (identifier, title, abstract, "type") VALUES ('0d2dc950-6cf0-415d-8e94-6fdf133d8da0', 'Basisplan (schwarz-weiss) der amtlichen Vermessung', 'Basisplan (schwarz-weiss) der amtlichen Vermessung des Kantons Solothurn', 0);

INSERT INTO metadb_ng.metadb_relation (metadb_id_parent, metadb_id_child) VALUES ('203726e0-577f-45da-901f-5417a5e0022c', '93eb36e5-5f16-4d98-b704-f6e087f647b8');
INSERT INTO metadb_ng.metadb_relation (metadb_id_parent, metadb_id_child) VALUES ('203726e0-577f-45da-901f-5417a5e0022c', '0d2dc950-6cf0-415d-8e94-6fdf133d8da0');
