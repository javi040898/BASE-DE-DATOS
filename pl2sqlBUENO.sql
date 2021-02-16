
drop table "Concierto";
drop table "Opinion";
drop table "Entrada";
drop table "Direccion";
drop table "Usuario";
drop table"Músico";
drop table "Grupo";
drop table "Disco";
drop table "Canción";
drop table "muchos_Usuario_tiene_muchos_Disco";
drop table "muchos_Concierto_tiene_muchos_Grupo";




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




ALTER TABLE public."Músico" OWNER TO postgres;

CREATE TABLE public."Grupo"(
	"Género" varchar(40),
	"Código Grupo" integer NOT NULL,
	CONSTRAINT "Grupo_pk" PRIMARY KEY ("Código Grupo")

);




ALTER TABLE public."Grupo" OWNER TO postgres;

ALTER TABLE public."Músico" ADD CONSTRAINT "Grupo_fk" FOREIGN KEY ("Código Grupo_Grupo")
REFERENCES public."Grupo" ("Código Grupo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public."Disco"(
	"Título" varchar(40),
	"Género" varchar,
	"Número de referencia" integer NOT NULL,
	"Fecha" date,
	"Formato" varchar(40),
	"Tamaño (MB)" integer,
	"Código Grupo_Grupo" integer,
	"Tipo" varchar(40),
	CONSTRAINT "Disco_pk" PRIMARY KEY ("Número de referencia")

);


ALTER TABLE public."Disco" OWNER TO postgres;

ALTER TABLE public."Disco" ADD CONSTRAINT "Grupo_fk" FOREIGN KEY ("Código Grupo_Grupo")
REFERENCES public."Grupo" ("Código Grupo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public."Canción"(
	"Nombre" varchar(40) NOT NULL,
	"Duración" time,
	"Fecha de Grabación" date NOT NULL,
	"DNI_Músico" varchar(9),
	"Número de referencia_Disco" integer,
	CONSTRAINT "Canción_pk" PRIMARY KEY ("Nombre","Fecha de Grabación")

);

create table public. "Disparador_Cancion" (
	"NombreD" varchar(40) not null,
	"DuracionD" time,
	"FechaD" date not null,
	"DNID" varchar(9),
	"NumDiscoD" integer
);

ALTER TABLE public."Disparador_Cancion" OWNER TO postgres;


ALTER TABLE public."Canción" OWNER TO postgres;

ALTER TABLE public."Canción" ADD CONSTRAINT "Músico_fk" FOREIGN KEY ("DNI_Músico")
REFERENCES public."Músico" ("DNI") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public."Canción" ADD CONSTRAINT "Disco_fk" FOREIGN KEY ("Número de referencia_Disco")
REFERENCES public."Disco" ("Número de referencia") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public."Concierto"(
	"Fecha" date,
	"País" varchar(40),
	"Recinto" varchar(40),
	"Ciudad" varchar(40),
	"Código" integer NOT NULL,
	CONSTRAINT "Concierto_pk" PRIMARY KEY ("Código")

);


ALTER TABLE public."Concierto" OWNER TO postgres;

CREATE TABLE public."muchos_Concierto_tiene_muchos_Grupo"(
	"Código_Concierto" integer NOT NULL,
	"Código Grupo_Grupo" integer NOT NULL,
	CONSTRAINT "muchos_Concierto_tiene_muchos_Grupo_pk" PRIMARY KEY ("Código_Concierto","Código Grupo_Grupo")

);



ALTER TABLE public."muchos_Concierto_tiene_muchos_Grupo" ADD CONSTRAINT "Concierto_fk" FOREIGN KEY ("Código_Concierto")
REFERENCES public."Concierto" ("Código") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE public."muchos_Concierto_tiene_muchos_Grupo" ADD CONSTRAINT "Grupo_fk" FOREIGN KEY ("Código Grupo_Grupo")
REFERENCES public."Grupo" ("Código Grupo") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE public."Entrada"(
	"Precio" money,
	"Código" integer NOT NULL,
	"Código_Concierto" integer,
	"DNI_Usuario" varchar(9),
	CONSTRAINT "Entrada_pk" PRIMARY KEY ("Código")

);



ALTER TABLE public."Entrada" OWNER TO postgres;

ALTER TABLE public."Entrada" ADD CONSTRAINT "Concierto_fk" FOREIGN KEY ("Código_Concierto")
REFERENCES public."Concierto" ("Código") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public."Usuario"(
	"Nombre" varchar(40),
	"Apellidos" varchar(40),
	"DNI" varchar(9) NOT NULL,
	"e-mail" varchar(40),
	--CONTRASEÑA--
	"Puntos" integer,
	CONSTRAINT "Usuario_pk" PRIMARY KEY ("DNI")

);



ALTER TABLE public."Usuario" OWNER TO postgres;

ALTER TABLE public."Entrada" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("DNI_Usuario")
REFERENCES public."Usuario" ("DNI") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public."muchos_Usuario_tiene_muchos_Disco"(
	"DNI_Usuario" varchar(9) NOT NULL,
	"Número de referencia_Disco" integer NOT NULL,
	CONSTRAINT "muchos_Usuario_tiene_muchos_Disco_pk" PRIMARY KEY ("DNI_Usuario","Número de referencia_Disco")

);

ALTER TABLE public."muchos_Usuario_tiene_muchos_Disco" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("DNI_Usuario")
REFERENCES public."Usuario" ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE public."muchos_Usuario_tiene_muchos_Disco" ADD CONSTRAINT "Disco_fk" FOREIGN KEY ("Número de referencia_Disco")
REFERENCES public."Disco" ("Número de referencia") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE public."Direccion"(
	calle varchar(40) NOT NULL,
	"número" smallint NOT NULL,
	piso varchar(40) NOT NULL,
	CONSTRAINT "Direccion_pk" PRIMARY KEY (calle,"número",piso)

);


ALTER TABLE public."Direccion" OWNER TO postgres;

ALTER TABLE public."Músico" ADD CONSTRAINT "Direccion_fk" FOREIGN KEY ("calle_Direccion","número_Direccion","piso_Direccion")
REFERENCES public."Direccion" (calle,"número",piso) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;


CREATE TABLE public."Opinion"(
	"Opinion concierto" smallint,
	"Opinion Disco" smallint,
	"Numero Opinion" smallint NOT NULL,
	"Número de referencia_Disco" integer,
	"Código_Concierto" integer,
	"DNI_Usuario" varchar(9),
	CONSTRAINT "Opinion_pk" PRIMARY KEY ("Numero Opinion")

);


ALTER TABLE public."Opinion" OWNER TO postgres;


ALTER TABLE public."Opinion" ADD CONSTRAINT "Disco_fk" FOREIGN KEY ("Número de referencia_Disco")
REFERENCES public."Disco" ("Número de referencia") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public."Opinion" ADD CONSTRAINT "Concierto_fk" FOREIGN KEY ("Código_Concierto")
REFERENCES public."Concierto" ("Código") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public."Opinion" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("DNI_Usuario")
REFERENCES public."Usuario" ("DNI") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public."Opinion" ADD CONSTRAINT "Opinion_uq" UNIQUE ("DNI_Usuario");

Alter table public."Disco" add constraint "CK_tipo_existente" check("Formato"='Físico' or "Formato"='Digital');

Alter table public."Músico" add constraint "CK_cantidad_cifras" check("TLF">=600000000 and "TLF"<=999999999);

Alter table public."Músico" add constraint "CK_codigo_postal" check("CP">=1000 and "CP"<=52999);

Alter table public."Entrada" add constraint "CK_precio" check("Precio">=cast(0.0 as money));

Alter table public."Usuario" add constraint "CK_puntos" check("Puntos">=0);

DELETE FROM "Músico";
insert into "Músico" values('47856322D',28821,943218255,'Antonio','García','Madrid','Madrid','Guitarra',6,'Avenida de España','56','3A');
insert into "Músico" values('47825322R',48544,914778545,'Javier','Martín','Coslada','Madrid','Violín',3,'Honduras','24','1B');
insert into "Músico" values('57356322T',25789,914782255,'Ignacio','Afuera','Morata','Madrid','Trompeta',1,'Segunda Avenida','28','16C');
insert into "Músico" values('41259322E',45375,918716523,'Christian','Ayala','Arganda','Madrid','Xilófono',5,'Calle Mayor','246','4A');
insert into "Músico" values('478552R0D',45345,917770355,'Alberto','González','Alcalá','Madrid','Guitarra',4,'Calle Alcalá','108','3D');
insert into "Músico" values('15379054Y',37676,914782255,'Mario','Adán','Mejorada','Madrid','Contrabajo',2,'Gran Avenida','124','9B');
insert into "Músico" values('35736322G',27867,914720465,'Sergio','Fernández','Guadalajara','Castilla-La-Mancha','Bajo',6,'Calle Real','2','8A');
insert into "Músico" values('47127792U',27868,911782255,'Guillermo','Perales','Torrejón','Madrid','Flauta',4,'Avenida de Madrid','22','12D');
insert into "Músico" values('56455680E',44769,913782255,'Branimir','Stefanov','Alcalá','Madrid','Saxofón',2,'Boulevard','14','7B');
insert into "Músico" values('44566322T',48544,914778545,'Carlos','Martín','Coslada','Madrid','Saxofón',3,'Honduras','24','1B');
insert into "Músico" values('57906322J',25789,914782255,'David','Afuera','Morata','Madrid','Tambor',1,'Segunda Avenida','28','16C');
insert into "Músico" values('33245323O',25789,914782255,'José Ignacio','Afuera','Morata','Madrid','Viola',1,'Segunda Avenida','28','16C');
insert into "Músico" values('51209782E',45375,918716523,'Oscar','Ayala','Arganda','Madrid','Batería',5,'Calle Mayor','246','4A');
insert into "Músico" values('53461124W',28500,987654321,'Diego','Godín','Madrid','Madrid','Triángulo',3,'Gran Vía',46,'1A');
insert into "Músico" values('53462567S',28445,984678921,'Diego','Forlan','Madrid','Madrid','Batería',6,'Calle Las Musas',12,'15D');
insert into "Músico" values('15234054Y',37676,914782255,'Antonio','Adán','Mejorada','Madrid','Guitarra',2,'Gran Avenida','124','9B');

select * from "Músico";

delete from "Grupo";
insert into "Grupo" values('Pop',1);
insert into "Grupo" values('Jazz',2);
insert into "Grupo" values('Jazz',3);
insert into "Grupo" values('Rock',4);
insert into "Grupo" values('Heavy Metal',5);
insert into "Grupo" values('Blues',6);

select * from "Grupo";

delete from "Disco";
insert into "Disco" values('Monstruos', 'Pop',1,'01/06/2006 12:00:00','Físico',NULL,1,'CD');
insert into "Disco" values('Amor', 'Pop',2,'05/10/2010 12:00:00','Digital',40,1,'MP3');
insert into "Disco" values('Montaña Rusa', 'Jazz',3,'30/06/2007 12:00:00','Físico',NULL,2,'CD');
insert into "Disco" values('Robots', 'Jazz',4,'01/05/2011 12:00:00','Digital',35,2,'AAC');
insert into "Disco" values('Planetas', 'Jazz',5,'02/02/2008 12:00:00','Digital',38,3,'FLAC');
insert into "Disco" values('Refugio', 'Jazz',6,'13/10/2018 12:00:00','Digital',42,3,'WMA');
insert into "Disco" values('Sentidos', 'Rock',7,'25/08/2018 12:00:00','Digital',51,4,'WMA');
insert into "Disco" values('Random', 'Rock',8,'21/06/2013 12:00:00','Digital',33,4,'MP3');
insert into "Disco" values('Zapatillas', 'Heavy Metal',9,'02/08/2007 12:00:00','Físico',NULL,5,'LAP');
insert into "Disco" values('Tiempo', 'Heavy Metal',10,'24/11/2018 12:00:00','Digital',29,5,'AAC');
insert into "Disco" values('Thriller', 'Blues',11,'05/12/2009 12:00:00','Digital',34,6,'MP3');
insert into "Disco" values('Cielo', 'Blues',12,'05/06/2018 12:00:00','Digital',47,6,'WMA');

select * from "Disco";

delete from "Canción";
insert into "Canción" values('Lagrimas','02:55','01/06/2006 12:00:00','57356322T',1);
insert into "Canción" values('Desordenadas','02:34','01/06/2006 12:00:00','57356322T',1);
insert into "Canción" values('Móvil','05:34','01/06/2006 12:00:00','57356322T',1);
insert into "Canción" values('Luna','02:55','05/10/2010 12:00:00','57356322T',2);
insert into "Canción" values('Llena','02:34','05/10/2010 12:00:00','57356322T',2);
insert into "Canción" values('Fotocopiadora','03:12','30/06/2007 12:00:00','56455680E',3);
insert into "Canción" values('Granjero','03:12','30/06/2007 12:00:00','56455680E',3);
insert into "Canción" values('Lo siento','03:12','01/05/2011 12:00:00','56455680E',4);
insert into "Canción" values('Sorry','04:00','01/05/2011 12:00:00','56455680E',4);
insert into "Canción" values('Come back','02:25','02/02/2008 12:00:00','47825322R',5);
insert into "Canción" values('Vuelve','03:34','02/02/2008 12:00:00','47825322R',5);
insert into "Canción" values('Scooby Doo Papa','02:25','13/10/2018 12:00:00','47825322R',6);
insert into "Canción" values('Superman','03:34','13/10/2018 12:00:00','47825322R',6);
insert into "Canción" values('Sin Capa','02:29','25/08/2018 12:00:00','47127792U',7);
insert into "Canción" values('Princesas','03:45','25/08/2018 12:00:00','47127792U',7);
insert into "Canción" values('La Macarena','02:29','21/06/2013 12:00:00','47127792U',8);
insert into "Canción" values('Con Calma','03:45','21/06/2013 12:00:00','47127792U',8);
insert into "Canción" values('La Gasolina','02:00','02/08/2007 12:00:00','41259322E',9);
insert into "Canción" values('Aloha','04:46','02/08/2007 12:00:00','41259322E',9);
insert into "Canción" values('Lunares','02:00','24/11/2018 12:00:00','41259322E',10);
insert into "Canción" values('Perro Viejo','04:46','24/11/2018 12:00:00','41259322E',10);
insert into "Canción" values('Despacito','03:25','05/12/2009 12:00:00','47856322D',11);
insert into "Canción" values('Rapidito','03:34','05/12/2009 12:00:00','47856322D',11);
insert into "Canción" values('See you Again','03:34','05/06/2018 12:00:00','47856322D',12);
insert into "Canción" values('Novocaine','03:34','05/06/2018 12:00:00','47856322D',12);

create or replace function insertar_cancionT() returns trigger as $insertar$
declare begin 
	insert into "Disparador_Cancion" values(new."Nombre",new."Duración",new."Fecha de Grabación",
	new."DNI_Músico",new."Número de referencia_Disco");
	return null;

end;

$insertar$ language plpgsql;


DROP TRIGGER inserta_cancion3;


create trigger inserta_cancion3 after insert on "Canción" 
for each row execute procedure insertar_cancionT();

select * from "Disparador_Cancion";

select * from "Canción";

delete from "Concierto";
insert into "Concierto" values('06/12/2018 23:00:00','España','Wizink Center','Madrid',1);
insert into "Concierto" values('08/11/2015 22:00:00','España','Las Ventas','Madrid',2);
insert into "Concierto" values('04/10/2012 21:00:00','España','Vicente Calderón','Madrid',3);
insert into "Concierto" values('12/09/2006 23:30:00','España','Riazor','A Coruña',4);
insert into "Concierto" values('11/08/2008 03:00:00','España','Teatro Real','Madrid',5);
insert into "Concierto" values('01/07/2008 19:00:00','España','Camp Nou','Barcelona',6);
insert into "Concierto" values('02/01/2005 22:00:00','España','Palau Sant Jordi','Barcelona',7);
insert into "Concierto" values('24/02/2007 21:00:00','España','El Molinón','Gijón',8);
insert into "Concierto" values('02/09/2009 21:50:00','España','Mestalla','Valencia',9);
insert into "Concierto" values('03/06/2012 00:45:00','Alemania','Berlin Arena','Berlin',10);
insert into "Concierto" values('04/01/2019 00:30:00','España','Wanda Metropolitano','Madrid',11);
insert into "Concierto" values('09/06/2018 18:00:00','España','Wizink Center','Madrid',12);
insert into "Concierto" values('24/02/2007 21:00:00','España','El Molinón','Gijón',13);
insert into "Concierto" values('02/09/2018 20:45:00','Italia','Olímpico de Turín','Turín',14);
insert into "Concierto" values('03/06/2016 00:00:00','Inglaterra','Wembley','Londres',15);
insert into "Concierto" values('04/01/2017 19:30:00','Inglaterra','Anfield','Liverpool',16);
insert into "Concierto" values('09/06/2017 18:45:00','España','Wizink Center','Madrid',17);

select * from "Concierto";

delete from "muchos_Concierto_tiene_muchos_Grupo";
insert into "muchos_Concierto_tiene_muchos_Grupo" values(1,1);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(2,1);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(3,2);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(4,2);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(5,3);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(6,3);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(7,4);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(8,4);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(9,5);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(10,5);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(11,6);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(12,6);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(13,3);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(14,2);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(15,5);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(16,6);
insert into "muchos_Concierto_tiene_muchos_Grupo" values(17,1);

select * from "muchos_Concierto_tiene_muchos_Grupo";

delete from "Entrada";
insert into "Entrada" values(30,1,1,'23466554K');
insert into "Entrada" values(30,2,1,'23454357Y');
insert into "Entrada" values(25,3,2,'21211384T');
insert into "Entrada" values(25,4,2,'33796554K');
insert into "Entrada" values(40,5,3,'77625433U');
insert into "Entrada" values(40,6,3,'55896544U');
insert into "Entrada" values(20,7,4,'23466932L');
insert into "Entrada" values(20,8,4,'59648755M');
insert into "Entrada" values(60,9,14,'94785411H');
insert into "Entrada" values(60,10,5,'36548455C');
insert into "Entrada" values(55,11,6,'32145633X');
insert into "Entrada" values(55,12,6,'47586547Z');
insert into "Entrada" values(20,13,16,'59648755M');
insert into "Entrada" values(60,14,7,'94785411H');
insert into "Entrada" values(140,15,8,'36548455C');
insert into "Entrada" values(120,16,15,'32145633X');
insert into "Entrada" values(105,17,17,'47586547Z');

select * from "Entrada";


delete from "Usuario";
insert into "Usuario" values('Maria','González', '23466554K','mariaonzalez@gmail.com',22334);
insert into "Usuario" values('Santiago','Herrera', '23454357Y','santi_herrera2590@gmail.com',245523);
insert into "Usuario" values('Iván','Pérez', '21211384T','soy_un_boke_@gmail.com',544323);
insert into "Usuario" values('Juan Carlos','Borras', '33796554K','elmakinadevallekas@gmail.com',345223);
insert into "Usuario" values('Alejandro','Rodríguez', '77625433U','ales_rodri_99@gmail.com',223211);
insert into "Usuario" values('Francisco Javier','Bedmar', '55896544U','francisco_grande@gmail.com',123890);
insert into "Usuario" values('Carlos','Hernández', '23466932L','panchovera@gmail.com',994);
insert into "Usuario" values('Alberto','Mota', '59648755M','albermota@gmail.com',12035);
insert into "Usuario" values('Eduardo','Martín', '94785411H','papitoyatusabe98@gmail.com',2900);
insert into "Usuario" values('Pablo','Madronal', '36548455C','pablo_el_grande00@gmail.com',98765);
insert into "Usuario" values('Javier','Bado', '32145633X','ehquepasajavito@gmail.com',23456);
insert into "Usuario" values('Alvaro','Sebastián', '47586547Z','alvaricoque20099@gmail.com',12345);

select * from "Usuario";



DELETE from "Direccion";
insert into "Direccion" values('Honduras',24,'1B');
insert into "Direccion" values('Avenida de España',56,'3A');
insert into "Direccion" values('Avenida de Madrid',22,'12D');
insert into "Direccion" values('Calle Mayor',246,'4A');
insert into "Direccion" values('Gran Avenida',124,'9B');
insert into "Direccion" values('Segunda Avenida',28,'16C');
insert into "Direccion" values('Boulevard',14,'7B');
insert into "Direccion" values('Calle Real',2,'8A');
insert into "Direccion" values('Calle de la Iglesia',78,'5D');
insert into "Direccion" values('Gran Vía',46,'1A');
insert into "Direccion" values('Calle Alcalá',108,'3D');
insert into "Direccion" values('Calle Las Musas',12,'15D');

select * from "Direccion";


delete from "Opinion";
insert into "Opinion" values(5,6,1,1,1,'23466554K');
insert into "Opinion" values(7,3,2,2,2,'23454357Y');
insert into "Opinion" values(3,5,3,3,3,'21211384T');
insert into "Opinion" values(8,8,4,4,4,'33796554K');
insert into "Opinion" values(9,10,5,5,5,'77625433U');
insert into "Opinion" values(8,9,6,6,6,'55896544U');
insert into "Opinion" values(8,8,7,7,7,'23466932L');
insert into "Opinion" values(10,null,8,null,13,'59648755M');
insert into "Opinion" values(9,null,9,null,14,'94785411H');
insert into "Opinion" values(3,null,10,null,15,'36548455C');
insert into "Opinion" values(7,null,11,null,16,'32145633X');
insert into "Opinion" values(5,null,12,null,17,'47586547Z');

select * from "Opinion";

select "DNI" from "Músico" where "Nombre"='Oscar';

--Ejercicio1
select * from "Grupo"where "Género"='Jazz';

--Ejercicio2
select "Nombre" from "Músico" where "Instrumento"='Batería';

--Ejercicio3

select "Nombre" from "Músico" inner join "Grupo" on 
"Grupo"."Código Grupo"="Músico"."Código Grupo_Grupo" where "Grupo"."Género"='Jazz' and  "Músico"."Instrumento"='Saxofón';

--Ejercicio4

select distinct "Grupo".* from "Grupo" inner join "muchos_Concierto_tiene_muchos_Grupo" on "muchos_Concierto_tiene_muchos_Grupo"."Código Grupo_Grupo"="Grupo"."Código Grupo"
inner join "Concierto" on "muchos_Concierto_tiene_muchos_Grupo"."Código_Concierto"="Concierto"."Código" where "Concierto"."País"='España';

--Ejercicio5
 
select distinct count("Número de referencia_Disco"),"Disco"."Título" from "Disco", "Canción" group by "Número de referencia_Disco","Disco"."Título" having count("Número de referencia_Disco")>10 ;

--Ejercicio6

select "Grupo".* from "Grupo" inner join "Músico" on "Músico"."Código Grupo_Grupo"="Grupo"."Código Grupo" group by "Código Grupo" having count("Código Grupo")>3;

--Ejercicio7

select "Opinion Disco" from "Opinion" where "DNI_Usuario" in(select "DNI_Usuario" from "Opinion" group by "DNI_Usuario" having count("DNI_Usuario")>=3);

--Ejercicio8

select "Disco".* from "Disco" inner join "Canción" on "Canción"."Número de referencia_Disco"="Disco"."Número de referencia" inner join "Grupo" on "Grupo"."Código Grupo"="Disco"."Código Grupo_Grupo" 
where "Duración">='05:00:00' and "Grupo"."Género"='Rock';

--Ejercicio9

select distinct "Nombre" from "Músico" inner join "Grupo" on "Grupo"."Código Grupo"="Músico"."Código Grupo_Grupo" 
inner join "muchos_Concierto_tiene_muchos_Grupo" on "muchos_Concierto_tiene_muchos_Grupo"."Código Grupo_Grupo"="Grupo"."Código Grupo"
inner join "Concierto" on "muchos_Concierto_tiene_muchos_Grupo"."Código_Concierto"="Concierto"."Código" 
inner join "Entrada" on "Entrada"."Código_Concierto"="Concierto"."Código" 
where "Concierto"."Ciudad"='Madrid' and "Entrada"."Precio">'100';

--Ejercicio10

select "Opinion concierto" from "Opinion" inner join "Concierto" on "Opinion"."Código_Concierto"="Concierto"."Código" 
inner join "Entrada" on "Entrada"."Código_Concierto"="Concierto"."Código" 
where "Concierto"."Ciudad"='Madrid' and "Entrada"."Precio">'100';

--Ejercicio11

select "Canción"."Nombre","Músico"."Nombre" from "Canción" inner join "Músico" on "Músico"."DNI"="Canción"."DNI_Músico" 
inner join "Disco" on "Disco"."Número de referencia"="Canción"."Número de referencia_Disco" where "Disco"."Género"='Heavy Metal' and ("Disco"."Fecha"<'31/12/2018 23:59:59' 
or "Disco"."Fecha">'1/1/2018 00:00:00');

--Ejercicio12

select "Nombre","Disco"."Tipo","Disco"."Tamaño (MB)" from "Músico" inner join "Grupo" on "Grupo"."Código Grupo"="Músico"."Código Grupo_Grupo" inner join 
"Disco" on "Disco"."Código Grupo_Grupo"="Grupo"."Código Grupo"
 where "Músico"."Instrumento"='Guitarra' and "Grupo"."Género"='Jazz' and "Disco"."Formato"='Digital';

--Ejercicio13

select "Nombre", "Apellidos" from "Usuario" inner join "Entrada" on "Usuario"."DNI"="Entrada"."DNI_Usuario" 
inner join "Concierto" on "Concierto"."Código"="Entrada"."Código_Concierto" inner join "muchos_Concierto_tiene_muchos_Grupo" on 
"muchos_Concierto_tiene_muchos_Grupo"."Código Grupo_Grupo"="Concierto"."Código"
inner join "Grupo" on "muchos_Concierto_tiene_muchos_Grupo"."Código_Concierto"="Concierto"."Código" inner join "Opinion" on
"Opinion"."Código_Concierto"="Concierto"."Código"  where "Grupo"."Género"='Blues' and
"Concierto"."Fecha"<'31/12/2018 23:59:59' and "Concierto"."Fecha">'1/1/2018 00:00:00';

--Ejercicio14

select "Disco"."Título", "Canción"."Nombre" as Disco from "Disco" inner join "Canción" on "Disco"."Número de referencia"="Canción"."Número de referencia_Disco"
where "Disco"."Título" in (select "Título" from "Disco" inner join "Opinion" on "Opinion"."Número de referencia_Disco"="Disco"."Número de referencia" where "Opinion Disco">8);

--Ejercicio15

select "Grupo".*,"Músico"."Nombre" from "Músico" inner join "Grupo" on "Grupo"."Código Grupo"="Músico"."Código Grupo_Grupo"
inner join "Disco" on "Grupo"."Código Grupo"="Disco"."Código Grupo_Grupo" inner join "muchos_Concierto_tiene_muchos_Grupo" on 
"muchos_Concierto_tiene_muchos_Grupo"."Código Grupo_Grupo"="Grupo"."Código Grupo" inner join "Concierto" on 
"muchos_Concierto_tiene_muchos_Grupo"."Código_Concierto"="Concierto"."Código" where not("País"='España')
and "Disco"."Número de referencia" in (select "Número de referencia_Disco" from "Canción" group by "Número de referencia_Disco" 
having count("Número de referencia_Disco")>10);

--Ejercicio16

select distinct "Canción"."Nombre","Músico"."Nombre" from "Canción" inner join "Músico" on "Músico"."DNI"="Canción"."DNI_Músico" 
inner join "Grupo" on "Grupo"."Código Grupo"="Músico"."Código Grupo_Grupo" inner join "muchos_Concierto_tiene_muchos_Grupo" on 
"muchos_Concierto_tiene_muchos_Grupo"."Código Grupo_Grupo"="Grupo"."Código Grupo" inner join "Concierto" on
"Concierto"."Código"="muchos_Concierto_tiene_muchos_Grupo"."Código_Concierto" where "Concierto"."Fecha"<'1/1/2017 00:00:00' or "Concierto"."Fecha">'31/12/2018 23:59:59';


--------ROLES--------------
create role "ADMINISTRADOR" superuser inherit createrole noreplication;
create role "GESTOR" nosuperuser inherit createdb nocreaterole noreplication;
create role "CLIENTE" nosuperuser inherit createdb nocreaterole noreplication;
create role "MUSICO" nosuperuser inherit createdb nocreaterole noreplication;
create role "MANAGER" nosuperuser inherit createdb nocreaterole noreplication;

create user "boss" with password 'boss';
grant "ADMINISTRADOR" to "boss";
grant all on all tables in schema public to "boss";

create user "gestor" with password 'gestor';
grant "GESTOR" to "gestor";
grant select,insert,delete,update on all tables in schema public to "gestor";

create user "mariaonzalez@gmail.com" with password 'pepe99';
grant "CLIENTE" to "mariaonzalez@gmail.com";
grant INSERT("Opinion concierto","Opinion Disco"),update("Opinion concierto","Opinion Disco"),
select("Opinion concierto","Opinion Disco") on "Opinion"  to "mariaonzalez@gmail.com";
grant select on "Disco"  to "mariaonzalez@gmail.com";
grant select on "Entrada"  to "mariaonzalez@gmail.com";
grant update("Nombre", "e-mail"), select on "Usuario"  to "mariaonzalez@gmail.com";-----METER TRIGGER


create user "JavierMartin" with password 'javiermartin';
grant "MUSICO" TO "JavierMartin"; 
grant select on "Músico"  to "JavierMartin";

create user "PacoElFlaco" with password 'pacoelflaco';
grant "MANAGER" to "PacoElFlaco";
grant select on "Concierto", "Músico", "Entrada", "Disco"  to "PacoElFlaco";
grant insert on "Concierto"  to "PacoElFlaco";

create user "feo" with password  'feo';

select * from role;
















