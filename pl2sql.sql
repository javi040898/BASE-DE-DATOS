-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: public."Músico" | type: TABLE --
-- DROP TABLE IF EXISTS public."Músico" CASCADE;
CREATE TABLE public."Músico"(
	"DNI" varchar(9) NOT NULL,
	"CP" integer,
	"TLF" integer,
	"Nombre" varchar(40),
	"Apellidos" varchar(40),
	"Ciudad" varchar,
	"Provincia" varchar,
	"Instrumento" varchar(40),
	"Código Grupo_Grupo" integer,
	"calle_Direccion" varchar(40),
	"número_Direccion" smallint,
	"piso_Direccion" varchar(40),
	CONSTRAINT "Músico_pk" PRIMARY KEY ("DNI")

);
-- ddl-end --
ALTER TABLE public."Músico" OWNER TO postgres;
-- ddl-end --

-- object: public."Grupo" | type: TABLE --
-- DROP TABLE IF EXISTS public."Grupo" CASCADE;
CREATE TABLE public."Grupo"(
	"Género" varchar(40),
	"Código Grupo" integer NOT NULL,
	CONSTRAINT "Grupo_pk" PRIMARY KEY ("Código Grupo")

);
-- ddl-end --
ALTER TABLE public."Grupo" OWNER TO postgres;
-- ddl-end --

-- object: "Grupo_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Músico" DROP CONSTRAINT IF EXISTS "Grupo_fk" CASCADE;
ALTER TABLE public."Músico" ADD CONSTRAINT "Grupo_fk" FOREIGN KEY ("Código Grupo_Grupo")
REFERENCES public."Grupo" ("Código Grupo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Disco" | type: TABLE --
-- DROP TABLE IF EXISTS public."Disco" CASCADE;
CREATE TABLE public."Disco"(
	"Título" varchar(40),
	"Género" varchar,
	"Número de referencia" integer NOT NULL,
	"Fecha" date,
	"Formato" varchar(40),
	"Código Grupo_Grupo" integer,
	"Numero Opinion_Opinion" smallint,
	CONSTRAINT "Disco_pk" PRIMARY KEY ("Número de referencia")

);
-- ddl-end --
ALTER TABLE public."Disco" OWNER TO postgres;
-- ddl-end --

-- object: "Grupo_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Disco" DROP CONSTRAINT IF EXISTS "Grupo_fk" CASCADE;
ALTER TABLE public."Disco" ADD CONSTRAINT "Grupo_fk" FOREIGN KEY ("Código Grupo_Grupo")
REFERENCES public."Grupo" ("Código Grupo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Canción" | type: TABLE --
-- DROP TABLE IF EXISTS public."Canción" CASCADE;
CREATE TABLE public."Canción"(
	"Nombre" varchar(40) NOT NULL,
	"Duración" time,
	"Fecha de Grabación" date NOT NULL,
	"DNI_Músico" varchar(9),
	"Número de referencia_Disco" integer,
	CONSTRAINT "Canción_pk" PRIMARY KEY ("Nombre","Fecha de Grabación")

);
-- ddl-end --
ALTER TABLE public."Canción" OWNER TO postgres;
-- ddl-end --

-- object: "Músico_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Canción" DROP CONSTRAINT IF EXISTS "Músico_fk" CASCADE;
ALTER TABLE public."Canción" ADD CONSTRAINT "Músico_fk" FOREIGN KEY ("DNI_Músico")
REFERENCES public."Músico" ("DNI") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Disco_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Canción" DROP CONSTRAINT IF EXISTS "Disco_fk" CASCADE;
ALTER TABLE public."Canción" ADD CONSTRAINT "Disco_fk" FOREIGN KEY ("Número de referencia_Disco")
REFERENCES public."Disco" ("Número de referencia") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Concierto" | type: TABLE --
-- DROP TABLE IF EXISTS public."Concierto" CASCADE;
CREATE TABLE public."Concierto"(
	"Fecha" date,
	"País" varchar(40),
	"Recinto" varchar(40),
	"Ciudad" varchar(40),
	"Código" integer NOT NULL,
	"Numero Opinion_Opinion" smallint,
	CONSTRAINT "Concierto_pk" PRIMARY KEY ("Código")

);
-- ddl-end --
ALTER TABLE public."Concierto" OWNER TO postgres;
-- ddl-end --

-- object: public."muchos_Concierto_tiene_muchos_Grupo" | type: TABLE --
-- DROP TABLE IF EXISTS public."muchos_Concierto_tiene_muchos_Grupo" CASCADE;
CREATE TABLE public."muchos_Concierto_tiene_muchos_Grupo"(
	"Código_Concierto" integer NOT NULL,
	"Código Grupo_Grupo" integer NOT NULL,
	CONSTRAINT "muchos_Concierto_tiene_muchos_Grupo_pk" PRIMARY KEY ("Código_Concierto","Código Grupo_Grupo")

);
-- ddl-end --

-- object: "Concierto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."muchos_Concierto_tiene_muchos_Grupo" DROP CONSTRAINT IF EXISTS "Concierto_fk" CASCADE;
ALTER TABLE public."muchos_Concierto_tiene_muchos_Grupo" ADD CONSTRAINT "Concierto_fk" FOREIGN KEY ("Código_Concierto")
REFERENCES public."Concierto" ("Código") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Grupo_fk" | type: CONSTRAINT --
-- ALTER TABLE public."muchos_Concierto_tiene_muchos_Grupo" DROP CONSTRAINT IF EXISTS "Grupo_fk" CASCADE;
ALTER TABLE public."muchos_Concierto_tiene_muchos_Grupo" ADD CONSTRAINT "Grupo_fk" FOREIGN KEY ("Código Grupo_Grupo")
REFERENCES public."Grupo" ("Código Grupo") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Entrada" | type: TABLE --
-- DROP TABLE IF EXISTS public."Entrada" CASCADE;
CREATE TABLE public."Entrada"(
	"Precio" money,
	"Código" integer NOT NULL,
	"Código_Concierto" integer,
	"DNI_Usuario" varchar(9),
	CONSTRAINT "Entrada_pk" PRIMARY KEY ("Código")

);
-- ddl-end --
ALTER TABLE public."Entrada" OWNER TO postgres;
-- ddl-end --

-- object: "Concierto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Entrada" DROP CONSTRAINT IF EXISTS "Concierto_fk" CASCADE;
ALTER TABLE public."Entrada" ADD CONSTRAINT "Concierto_fk" FOREIGN KEY ("Código_Concierto")
REFERENCES public."Concierto" ("Código") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Usuario" | type: TABLE --
-- DROP TABLE IF EXISTS public."Usuario" CASCADE;
CREATE TABLE public."Usuario"(
	"Nombre" varchar(40),
	"Apellidos" varchar(40),
	"DNI" varchar(9) NOT NULL,
	"e-mail" varchar(40),
	"Puntos" integer,
	"Numero Opinion_Opinion" smallint,
	CONSTRAINT "Usuario_pk" PRIMARY KEY ("DNI")

);
-- ddl-end --
ALTER TABLE public."Usuario" OWNER TO postgres;
-- ddl-end --

-- object: "Usuario_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Entrada" DROP CONSTRAINT IF EXISTS "Usuario_fk" CASCADE;
ALTER TABLE public."Entrada" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("DNI_Usuario")
REFERENCES public."Usuario" ("DNI") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."muchos_Usuario_tiene_muchos_Disco" | type: TABLE --
-- DROP TABLE IF EXISTS public."muchos_Usuario_tiene_muchos_Disco" CASCADE;
CREATE TABLE public."muchos_Usuario_tiene_muchos_Disco"(
	"DNI_Usuario" varchar(9) NOT NULL,
	"Número de referencia_Disco" integer NOT NULL,
	CONSTRAINT "muchos_Usuario_tiene_muchos_Disco_pk" PRIMARY KEY ("DNI_Usuario","Número de referencia_Disco")

);
-- ddl-end --

-- object: "Usuario_fk" | type: CONSTRAINT --
-- ALTER TABLE public."muchos_Usuario_tiene_muchos_Disco" DROP CONSTRAINT IF EXISTS "Usuario_fk" CASCADE;
ALTER TABLE public."muchos_Usuario_tiene_muchos_Disco" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("DNI_Usuario")
REFERENCES public."Usuario" ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Disco_fk" | type: CONSTRAINT --
-- ALTER TABLE public."muchos_Usuario_tiene_muchos_Disco" DROP CONSTRAINT IF EXISTS "Disco_fk" CASCADE;
ALTER TABLE public."muchos_Usuario_tiene_muchos_Disco" ADD CONSTRAINT "Disco_fk" FOREIGN KEY ("Número de referencia_Disco")
REFERENCES public."Disco" ("Número de referencia") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Direccion" | type: TABLE --
-- DROP TABLE IF EXISTS public."Direccion" CASCADE;
CREATE TABLE public."Direccion"(
	calle varchar(40) NOT NULL,
	"número" smallint NOT NULL,
	piso varchar(40) NOT NULL,
	CONSTRAINT "Direccion_pk" PRIMARY KEY (calle,"número",piso)

);
-- ddl-end --
ALTER TABLE public."Direccion" OWNER TO postgres;
-- ddl-end --

-- object: "Direccion_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Músico" DROP CONSTRAINT IF EXISTS "Direccion_fk" CASCADE;
ALTER TABLE public."Músico" ADD CONSTRAINT "Direccion_fk" FOREIGN KEY ("calle_Direccion","número_Direccion","piso_Direccion")
REFERENCES public."Direccion" (calle,"número",piso) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Opinion" | type: TABLE --
-- DROP TABLE IF EXISTS public."Opinion" CASCADE;
CREATE TABLE public."Opinion"(
	"Opinion concierto" varchar(150),
	"Opinion Disco" varchar(150),
	"Numero Opinion" smallint NOT NULL,
	CONSTRAINT "Opinion_pk" PRIMARY KEY ("Numero Opinion")

);
-- ddl-end --
ALTER TABLE public."Opinion" OWNER TO postgres;
-- ddl-end --

-- object: "Opinion_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Usuario" DROP CONSTRAINT IF EXISTS "Opinion_fk" CASCADE;
ALTER TABLE public."Usuario" ADD CONSTRAINT "Opinion_fk" FOREIGN KEY ("Numero Opinion_Opinion")
REFERENCES public."Opinion" ("Numero Opinion") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Usuario_uq" | type: CONSTRAINT --
-- ALTER TABLE public."Usuario" DROP CONSTRAINT IF EXISTS "Usuario_uq" CASCADE;
ALTER TABLE public."Usuario" ADD CONSTRAINT "Usuario_uq" UNIQUE ("Numero Opinion_Opinion");
-- ddl-end --

-- object: "Opinion_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Concierto" DROP CONSTRAINT IF EXISTS "Opinion_fk" CASCADE;
ALTER TABLE public."Concierto" ADD CONSTRAINT "Opinion_fk" FOREIGN KEY ("Numero Opinion_Opinion")
REFERENCES public."Opinion" ("Numero Opinion") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Concierto_uq" | type: CONSTRAINT --
-- ALTER TABLE public."Concierto" DROP CONSTRAINT IF EXISTS "Concierto_uq" CASCADE;
ALTER TABLE public."Concierto" ADD CONSTRAINT "Concierto_uq" UNIQUE ("Numero Opinion_Opinion");
-- ddl-end --

-- object: "Opinion_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Disco" DROP CONSTRAINT IF EXISTS "Opinion_fk" CASCADE;
ALTER TABLE public."Disco" ADD CONSTRAINT "Opinion_fk" FOREIGN KEY ("Numero Opinion_Opinion")
REFERENCES public."Opinion" ("Numero Opinion") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Disco_uq" | type: CONSTRAINT --
-- ALTER TABLE public."Disco" DROP CONSTRAINT IF EXISTS "Disco_uq" CASCADE;
ALTER TABLE public."Disco" ADD CONSTRAINT "Disco_uq" UNIQUE ("Numero Opinion_Opinion");
-- ddl-end --


