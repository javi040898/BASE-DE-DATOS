-- CREATE DATABASE CONGRESOS;
 SET DATESTYLE TO 'dmy, dmy';
-- CONNECT to CONGRESOS;
  DROP TABLE PONENCIAS;
  DROP TABLE PONENTES;
  DROP TABLE SESIONES;
  DROP TABLE SALAS;

CREATE TABLE SALAS (
	NOMSALA varchar (10) PRIMARY KEY,
	CAPACIDAD int CHECK (CAPACIDAD BETWEEN 25 AND 99),
	PRECIO numeric(10,0) CHECK (PRECIO BETWEEN 100000 AND 200000));

CREATE TABLE PONENTES (
	NOMBRE varchar (10) PRIMARY KEY,
	PAIS varchar (10),
	EMPRESA varchar (10),
        PUESTO varchar (20));

CREATE TABLE PONENCIAS (
	DIA date,
	NUMP int,
	TITULOP varchar (25),
	PONENTE varchar (10),
	DURACION int, 
        CONSTRAINT PK_PONENCIAS PRIMARY KEY (DIA, NUMP, PONENTE),
        CONSTRAINT FK_PONENCIAS_PONENTE FOREIGN KEY (PONENTE) REFERENCES PONENTES (NOMBRE));

CREATE TABLE SESIONES (
	DIA date,
	NUMS int,
	SALA varchar (10),
	NOMPRES varchar (10),
	TITULO varchar (40),
        CONSTRAINT PK_SESIONES PRIMARY KEY (DIA, NUMS, SALA),
        CONSTRAINT FK_SESION_SALA FOREIGN KEY (SALA) REFERENCES SALAS (NOMSALA));

INSERT INTO SALAS VALUES ('C3PO',70,200000);
INSERT INTO SALAS VALUES ('R2D2',50,200000);
INSERT INTO SALAS VALUES ('YEDI',30,125000);
INSERT INTO SALAS VALUES ('LUKE',50,200000);
INSERT INTO SALAS VALUES ('ANAKIN',40,150000);
INSERT INTO SALAS VALUES ('CHEWBACCA',30,125000);

INSERT INTO PONENTES VALUES ('ROBERTO', 'ARGENTINA','SENSA','TECNICO');
INSERT INTO PONENTES VALUES ('DIEGO', 'ARGENTINA','SENSA','GERENTE');
INSERT INTO PONENTES VALUES ('JUAN', 'ARGENTINA','KCOPSA','TECNICO');
INSERT INTO PONENTES VALUES ('FEDERICO', 'ARGENTINA','IKCSA','ANALISTA');
INSERT INTO PONENTES VALUES ('PIERRE', 'FRANCIA','COMPACSA','PROGRAMADOR');
INSERT INTO PONENTES VALUES ('MICHEL', 'FRANCIA','COMPACSA','PROGRAMADOR');
INSERT INTO PONENTES VALUES ('YAKAMOTO', 'JAPON','IKCSA','ANALISTA');
INSERT INTO PONENTES VALUES ('ANIMOTO', 'JAPON','IKCSA','ANALISTA');
INSERT INTO PONENTES VALUES ('FRANCESCO', 'ITALIA','LKM','TECNICO');
INSERT INTO PONENTES VALUES ('CARLOTI', 'ITALIA','LKM','ANALISTA');
INSERT INTO PONENTES VALUES ('ENRICCO', 'ITALIA','LKM','PROGRAMADOR');
INSERT INTO PONENTES VALUES ('JACK', 'EEUU','KCOPSA','GERENTE');
INSERT INTO PONENTES VALUES ('JOE', 'EEUU','KCOPSA','COMERCIAL');
INSERT INTO PONENTES VALUES ('LARRY', 'EEUU','KCOPSA','ANALISTA');
INSERT INTO PONENTES VALUES ('JOHN', 'EEUU','LKM','COMERCIAL');
INSERT INTO PONENTES VALUES ('PIETRO', 'ITALIA','TELITA','COMERCIAL');

INSERT INTO SESIONES VALUES ('01/06/2006 12:00:00',1,'C3PO','ROBERTO','HARDWARE Y SOFTWARE');
INSERT INTO SESIONES VALUES ('01/06/2006 13:00:00',2,'C3PO','JACK','HARDWARE Y SOFTWARE');
INSERT INTO SESIONES VALUES ('02/06/2006 12:00:00',1,'R2D2','PIERRE','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('02/06/2006 13:00:00',2,'R2D2','FRANCESCO','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('02/06/2006 14:00:00',3,'YEDI','YAMAMOTO','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('02/06/2006 16:00:00',4,'C3PO','ROBERTO','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('03/06/2006 12:00:00',1,'YEDI','JACK','BASES DE DATOS');
INSERT INTO SESIONES VALUES ('03/06/2006 17:00:00',2,'C3PO','JACK','INTELIGENCIA ARTIFICIAL');
INSERT INTO SESIONES VALUES ('04/06/2006 12:00:00',1,'LUKE','ROBERTO','OFFICE 2000');
INSERT INTO SESIONES VALUES ('04/06/2006 13:00:00',2,'LUKE','PIERRE','OFFICE 2000');
INSERT INTO SESIONES VALUES ('04/06/2006 15:00:00',3,'R2D2','FRANCESCO','SISTEMAS OPERATIVOS');

/*
INSERT INTO SESIONES VALUES ('01/06/2006',1,'C3PO','ROBERTO','HARDWARE Y SOFTWARE');
INSERT INTO SESIONES VALUES ('01/06/2006',2,'C3PO','JACK','HARDWARE Y SOFTWARE');
INSERT INTO SESIONES VALUES ('02/06/2006',1,'R2D2','PIERRE','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('02/06/2006',2,'R2D2','FRANCESCO','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('02/06/2006',3,'YEDI','YAMAMOTO','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('02/06/2006',4,'C3PO','ROBERTO','COMUNICACIONES EN LA EMPRESA');
INSERT INTO SESIONES VALUES ('03/06/2006',1,'YEDI','JACK','BASES DE DATOS');
INSERT INTO SESIONES VALUES ('03/06/2006',2,'C3PO','JACK','INTELIGENCIA ARTIFICIAL');
INSERT INTO SESIONES VALUES ('04/06/2006',1,'LUKE','ROBERTO','OFFICE 2000');
INSERT INTO SESIONES VALUES ('04/06/2006',2,'LUKE','PIERRE','OFFICE 2000');
INSERT INTO SESIONES VALUES ('04/06/2006',3,'R2D2','FRANCESCO','SISTEMAS OPERATIVOS');
*/



INSERT INTO PONENCIAS VALUES ('01/06/2006 12:00:00', 1, 'PERIFERICOS','DIEGO',5);
INSERT INTO PONENCIAS VALUES ('01/06/2006 12:00:00', 1, 'IMPRESORAS DE TINTA','PIETRO',10);
INSERT INTO PONENCIAS VALUES ('01/06/2006 12:00:00', 2, 'SCANER','JOE',3);
INSERT INTO PONENCIAS VALUES ('01/06/2006 12:00:00', 2, 'PERIFERICOS','YAKAMOTO',1);
INSERT INTO PONENCIAS VALUES ('02/06/2006 12:00:00', 1, 'REDES DE ORDENADORES','PIERRE',1);
INSERT INTO PONENCIAS VALUES ('02/06/2006 12:00:00', 2, 'ARQUITECTURA DE REDES','MICHEL',5);
INSERT INTO PONENCIAS VALUES ('02/06/2006 12:00:00', 2, 'REDES DE AREA LOCAL','ANIMOTO',5);
INSERT INTO PONENCIAS VALUES ('02/06/2006 12:00:00', 3, 'PROTOCOLO TCP/IP','ENRICCO',1);
INSERT INTO PONENCIAS VALUES ('02/06/2006 12:00:00', 4, 'ISO 9000','JUAN',2);
INSERT INTO PONENCIAS VALUES ('02/06/2006 12:00:00', 4, 'CALIDAD','JOHN',3);
INSERT INTO PONENCIAS VALUES ('03/06/2006 12:00:00', 1, 'B.D. DISTRIBUIDAS','FEDERICO',3);
INSERT INTO PONENCIAS VALUES ('03/06/2006 12:00:00', 1, 'B.D. RELACIONALES','FRANCESCO',3);
INSERT INTO PONENCIAS VALUES ('03/06/2006 12:00:00', 2, 'RMI','FEDERICO',2);
INSERT INTO PONENCIAS VALUES ('03/06/2006 12:00:00', 2, 'LENGUAJE PROLOG','LARRY',2);
INSERT INTO PONENCIAS VALUES ('04/06/2006 12:00:00', 1, 'OFFICE','JOE',1);
INSERT INTO PONENCIAS VALUES ('04/06/2006 12:00:00', 2, 'TELETRABAJO','JACK',1);
INSERT INTO PONENCIAS VALUES ('04/06/2006 12:00:00', 3, 'S.O.:MS-DOS','CARLOTI',2);
INSERT INTO PONENCIAS VALUES ('04/06/2006 12:00:00', 3, 'S.O.:UNIX','MICHEL',3);   


select  min(precio) from salas;

select dia from PONENCIAS;

--Ejercicio1
select nomsala,capacidad,precio from salas;

--Ejercicio2
select nombre,empresa from ponentes;

--Ejercicio3
select distinct nompres from sesiones;

--Ejercicio4

select nombre,puesto from ponentes where empresa= 'LKM' order by nombre,puesto;

--Ejercicio5

select nombre from ponentes where empresa='LKM' and pais='ITALIA' order by nombre desc;

--Ejercicio6

select titulop,nump,dia from ponencias where dia='03/06/2006' or dia='04/06/2006/';

--Ejercicio7

select pais,empresa,nombre from ponentes where pais='FRANCIA' or pais='ITALIA' order by pais,empresa,nombre;

--Ejercicio8

select nompres,dia,sala,nums from sesiones where(nums=3 or nums=4) and (dia='02/06/2006' or dia='04/06/2006') order by sala,dia,nums;

--Ejercicio9

select nomsala,capacidad from salas where nomsala like 'C%' except (select nomsala,capacidad from salas where nomsala='C3PO') order by capacidad,nomsala;

--Ejercicio10

select  count(dia) from sesiones group by dia order by dia,count(dia);

--Ejercicio11

select round(avg(precio),2) as media_precio_salas from salas;

--Ejercicio12

select count(nombre),pais from ponentes group by pais order by pais,count(nombre);

--Ejercicio13

select pais,count(pais) from ponentes group by pais having count(pais)>2 order by pais,count(pais) ;

--Ejercicio14

select dia,dia+20 as nueva_fecha,titulop,nump from ponencias;

--Ejercicio15
select nomsala,capacidad+(select capacidad from salas where nomsala='R2D2') as capacidad_union from salas where nomsala='C3PO';

--Ejercicio16

select dia,count(dia) from sesiones  group by  dia having count(dia)>2;

--Ejercicio17

select nomsala,count(nomsala), capacidad from salas where capacidad<40 and nomsala in(select sala from sesiones) group by nomsala;

--Ejercicio18

select ponentes.nombre,titulo from sesiones inner join ponentes on ponentes.nombre=sesiones.nompres;

--Ejercicio19

select ponente,titulop from ponencias where ponente in (select nombre from ponentes);--dudas

--Ejercicio20

select nombre,empresa from ponentes where nombre not in(select ponente from ponencias);

--Ejercicio21

select titulo,count(titulo) from sesiones group by titulo order by titulo,count(titulo);

--Ejercicio22

select precio as coste,nomsala from salas;

--Ejercicio23

select nombre,empresa from ponentes where empresa in (select empresa from ponentes where nombre in (select ponente from ponencias where titulop='SCANER'));

--Ejercicio24

(select titulo,'sesion' as titulo_nuevo from sesiones) union (select titulop,'ponencia' from ponencias) order by titulo_nuevo;

--Ejercicio25

select nomsala,dia,ponente,capacidad from ponencias,salas where (salas.capacidad>30);

--Ejercicio26

select nombre, count(nump) from ponentes,ponencias group by nombre,nump;--dudas

--Ejercicio27

select pais,count(pais) from ponentes group by pais having count(pais)>(select count(pais) from ponentes where pais='JAPON');

--Ejercicio28

select nomsala, round(precio/capacidad,0) as precio_por_plaza from salas;--dudas
alter table salas add preciomenor numeric;
insert into salas (preciomenor) where(precio_por_plaza<(select precio from salas where nomsala='C3PO'));

--Ejercicio29

select dia,titulo,sala,capacidad,precio from sesiones,salas;

--Ejercicio30

select empresa from ponentes;