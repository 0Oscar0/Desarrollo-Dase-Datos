
DROP TABLE DETALLE_FACTURA ;
DROP TABLE CLIENTE ;
DROP TABLE  FACTURAPRODUCTO  ;
DROP TABLE ITEMXRPTO_AUTO  ;
DROP TABLE DESCUENTO ;
DROP TABLE REPUESTO ;
DROP TABLE AUTOM ;
DROP TABLE MARCA ;




CREATE TABLE  MARCA  (
  CodigoMarca       CHAR(100) primary key, 
  nombre   CHAR(100) NOT NULL 
);


CREATE TABLE  AUTOM  (
  Codigo_Auto       CHAR(20) primary key, 
  Modelo   CHAR(100) NOT NULL , 
  CodigoMarca   CHAR(100) NOT NULL ,
  Pais_Fabricacion CHAR(30)  NOT NULL,
  PrecioVenta   NUMBER(10,0) NOT NULL,
  CONSTRAINT     FK_CodigoMarca    FOREIGN KEY (CodigoMarca) REFERENCES  MARCA (CodigoMarca)
);

CREATE TABLE  REPUESTO  (
  Codigorpto       CHAR(20) primary key, 
  Nombrerep   CHAR(100) NOT NULL , 
  Descripcion   CHAR(100) NOT NULL ,
  Precio NUMBER(10,0) NOT NULL,
  Codigo_Auto   CHAR(20) ,
  CONSTRAINT     FK_CodigoAuto    FOREIGN KEY (Codigo_Auto) REFERENCES  AUTOM (Codigo_Auto)
);



CREATE TABLE  DESCUENTO  (
   Codigorpto       CHAR(20) NOT NULL, 
  Valor_Descuento   NUMBER(10,0) NOT NULL,
  CONSTRAINT     FK_Codigorpto    FOREIGN KEY (Codigorpto) REFERENCES  REPUESTO (Codigorpto)

);


CREATE TABLE  ITEMXRPTO_AUTO  (
   Codigorpto       CHAR(20) NOT NULL, 
  CodigoAuto    CHAR(20) NOT NULL,
  CONSTRAINT     FK_Codigorpto1    FOREIGN KEY (Codigorpto) REFERENCES  REPUESTO (Codigorpto),
   CONSTRAINT     FK_CodigoAuto1    FOREIGN KEY (CodigoAuto) REFERENCES  AUTOM (Codigo_Auto)

);


CREATE TABLE  FACTURAPRODUCTO  (
  CodigoFac       CHAR(100) primary key, 
  FechaCompra   DATE NOT NULL 
);

CREATE TABLE  CLIENTE  (
  Cliente       CHAR(100) primary key, 
  Nombre    CHAR(25) NOT NULL, 
  Direccion    CHAR(100) NOT NULL
  
  
);




CREATE TABLE  DETALLE_FACTURA  (
  Codigo_prod   CHAR(100) primary key, 
  CodigoFac     CHAR(100) NOT NULL,
  Cliente  CHAR(100) NOT NULL,
  CONSTRAINT     FK_CodigoFac    FOREIGN KEY (CodigoFac) REFERENCES  FACTURAPRODUCTO (CodigoFac),
  CONSTRAINT     FK_Cliente    FOREIGN KEY (Cliente) REFERENCES  CLIENTE (Cliente)
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into MARCA values('1','BMW');
insert into MARCA values('2','Dacia');
insert into MARCA values('3','Infiniti');
insert into MARCA values('4','Kia');
insert into MARCA values('5','KTM');

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Insert into AUTOM values
('1','modelo1','1','ALEMANIA',150000);
Insert into AUTOM values
('2','modelo2','2','JAPON',190000);
Insert into AUTOM values
('3','modelo3','3','RUSIA',270000);
Insert into AUTOM values
('4','modelo4','4','EEUU',200000);
Insert into AUTOM values
('5','modelo5','5','HOLANDA',290000);


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Insert into REPUESTO values
('1','bujia','de dos  entradas',15000,'1');
Insert into REPUESTO values
('2','LED faro gu�a de tubo flexible suave','2X 60 cm---Luz Diurna',15000,'2');
Insert into REPUESTO values
('3','manija de puerta de coche de carreras','TRD calcoman�as decorativas estilo creativo de coche',18000,'3');
Insert into REPUESTO values
('4','Tronco Racing Filtro de entrada de aire fr�o Limpiador de cono c�nico','3" pulgadas de alto caudal ',10000,'4');
Insert into REPUESTO values
('5','Manivela Ventana De Coche Mango Aluminio Billet 3 Adaptadores','2x Negro Enrollador De Vidrio',11000,'5');



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Insert into DESCUENTO values
('1',5000);
Insert into DESCUENTO values
('2',1000);
Insert into DESCUENTO values
('3',100);
Insert into DESCUENTO values
('4',2000);
Insert into DESCUENTO values
('5',6000);


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



Insert into ITEMXRPTO_AUTO values
('1','1');
Insert into ITEMXRPTO_AUTO values
('2','2');
Insert into ITEMXRPTO_AUTO values
('3','3');
Insert into ITEMXRPTO_AUTO values
('4','4');
Insert into ITEMXRPTO_AUTO values
('5','5');


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Insert into FACTURAPRODUCTO values
('1',TO_DATE('2013/10/11', 'yyyy/mm/dd'));
Insert into FACTURAPRODUCTO values
('2',TO_DATE('2013/10/12', 'yyyy/mm/dd'));
Insert into FACTURAPRODUCTO values
('3',TO_DATE('2013/10/13', 'yyyy/mm/dd'));
Insert into FACTURAPRODUCTO values
('4',TO_DATE('2013/10/14', 'yyyy/mm/dd'));
Insert into FACTURAPRODUCTO values
('5',TO_DATE('2013/10/15', 'yyyy/mm/dd'));


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Insert into CLIENTE values
('1','paula','	CALLE AGUSTIN LARA NO. 69-B');

Insert into CLIENTE values
('2','andres','AV. 5 DE MAYO NO. 1652');

Insert into CLIENTE values
('3','luis','	AV. 20 DE NOVIEMBRE NO 1046');

Insert into CLIENTE values
('4','oscar','	AV. LIBERTAD NO. 34');

Insert into CLIENTE values
('5','anguie','	AV. INDEPENDENCIA NO. 1639');


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  
 Insert into  DETALLE_FACTURA values
('1','1','1');
Insert into  DETALLE_FACTURA values
('2','2','2');
Insert into  DETALLE_FACTURA values
('3','3','3');
Insert into  DETALLE_FACTURA values
('4','4','4');
Insert into  DETALLE_FACTURA values
('5','5','5');


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----Cree un SP para mostrar una lista de repuestos con su nombre, precio, porcentaje de---------------------------------
-----descuento y el valor que tuviera si se aplica dicho descuento.------------------------------------------------------
set serveroutput on;

create or replace procedure repuestos
as
cursor ver_repuesto is
select  Nombrerep, Precio from REPUESTO;
reg_repuesto  ver_repuesto%ROWTYPE;

cursor descuento is
select Valor_Descuento  from DESCUENTO ;
desct number(10);
preciofinal number(12);
begin
   OPEN ver_repuesto;
   OPEN descuento;
   preciofinal:=0;
   LOOP 
        FETCH descuento into desct;
           EXIT WHEN descuento%NOTFOUND;
        FETCH ver_repuesto into reg_repuesto;
        EXIT WHEN ver_repuesto%NOTFOUND;
     preciofinal:=reg_repuesto.Precio-desct;
        dbms_output.put_line('nombre '||reg_repuesto.Nombrerep||' Precio original '||reg_repuesto.Precio ||' descuento ' || desct ||' precio final ' || preciofinal); 
        
   END LOOP;
   
   CLOSE ver_repuesto;
    CLOSE descuento;       
end repuestos;

set serveroutput on;

execute repuestos;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------Elabore un SP que tenga un par�metro que me pida el modelo del auto, y que me muestre-----------------------
-------------------------------todos los repuestos que pertenecen a ese modelo de auto. ----------------------------------------------------
set serveroutput on;

create or replace procedure busca_modelo(modelo1 CHAR)
as
cursor ver_codigo is
select Codigo_Auto from AUTOM where Modelo=modelo1;
codg CHAR(20);

cursor ver_repuesto is
select Nombrerep,DESCRIPCION  from REPUESTO where Codigo_Auto=codg;
reg_repuesto ver_repuesto%ROWTYPE;


begin
   OPEN ver_codigo; 
   LOOP 
        FETCH ver_codigo into codg;
        EXIT WHEN ver_codigo%NOTFOUND;        
   END LOOP;
   
   OPEN ver_repuesto;
    LOOP 
        FETCH ver_repuesto into reg_repuesto;
        EXIT WHEN ver_repuesto%NOTFOUND;
        dbms_output.put_line('Codigo '||codg || 'nombre repuesto: ' ||reg_repuesto.Nombrerep || 'descripcion repuesto: ' ||reg_repuesto.DESCRIPCION ); 
        END LOOP;
    CLOSE ver_repuesto;   
    CLOSE ver_codigo;
   
end busca_modelo;


set serveroutput on;
execute busca_modelo('modelo4');


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------Ahora elabore un SP (si quiere aplique cursores) que muestre la marca, el pa�s, el nombre
------------------del modelo y el precio, pero que me pida dos par�metros, pa�s y precio, para usarlo en la
------------------b�squeda. 


create or replace procedure busca_marca(pai CHAR, preci NUMBER )
as
cursor ver_modelo is
select Modelo,Pais_Fabricacion,PRECIOVENTA from AUTOM where Pais_Fabricacion=pai AND PRECIOVENTA=preci;
reg_modelo ver_modelo%ROWTYPE;

cursor ver_codgmar is
select CodigoMarca from AUTOM where Pais_Fabricacion=pai AND PRECIOVENTA=preci;
codgM CHAR(100);

cursor ver_marca is
select nombre from MARCA where CodigoMarca=codgM;
reg_marca ver_marca%ROWTYPE;



begin
   OPEN ver_modelo; 
   LOOP 
        FETCH ver_modelo into reg_modelo;
        EXIT WHEN ver_modelo%NOTFOUND;    
   END LOOP;
   
   OPEN ver_codgmar;
   LOOP
      FETCH ver_codgmar into codgM;
      EXIT WHEN ver_codgmar%NOTFOUND; 
   END LOOP;
   
   OPEN ver_marca;
   LOOP 
        FETCH ver_marca into reg_marca;
        EXIT WHEN ver_marca%NOTFOUND;
        dbms_output.put_line('MARCA ES: '|| reg_marca.nombre || 'PAIS DE FABRICACION: ' || reg_modelo.Pais_Fabricacion || 'MODELO DEL AUTO: ' || reg_modelo.Modelo || 'PRECIO DE VENTA: ' || reg_modelo.PRECIOVENTA ); 
    END LOOP;
    
    CLOSE ver_marca; 
    CLOSE ver_codgmar;
    CLOSE ver_modelo;
   
end busca_marca;


set serveroutput on;
execute busca_marca('ALEMANIA',150000);




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----Tambi�n elabore un SP (si quiere aplique cursores) que me muestre los datos del repuesto,
----modelo y marca del auto, a partir de que el precio de los repuestos, este entre dos valores. 

create or replace procedure busca_precio
as

cursor ver_precio is
select Precio from REPUESTO ;
prec NUMBER(10);

cursor ver_codgA is
select CODIGO_AUTO from AUTOM ;
codgA CHAR(20);


cursor ver_datosR is
select * from REPUESTO where CODIGO_AUTO=codgA ;
reg_datosR ver_datosR%ROWTYPE;

cursor ver_codgmar is
select CodigoMarca from AUTOM ;
codgM CHAR(100);

cursor ver_marca is
select nombre from MARCA where CodigoMarca=codgM;
reg_marca ver_marca%ROWTYPE;

cursor ver_modelo is
select modelo from AUTOM where CodigoMarca=codgM;
reg_modelo ver_modelo%ROWTYPE;

begin
  
  OPEN ver_precio;
  LOOP 
        FETCH ver_precio into prec;
        EXIT WHEN ver_precio%NOTFOUND;
       if prec > 17000 and prec<20000  then 
   dbms_output.put_line('Su precio es: '|| prec ); 
 

   OPEN ver_codgA; 
   LOOP 
        FETCH ver_codgA into codgA;
        EXIT WHEN ver_codgA%NOTFOUND; 
         
   END LOOP;
   
   
   
   OPEN ver_datosR;
   LOOP
      FETCH ver_datosR into reg_datosR;
      EXIT WHEN ver_datosR%NOTFOUND; 
      
   END LOOP;
   
   OPEN ver_codgmar; 
   LOOP 
        FETCH ver_codgmar into codgM;
        EXIT WHEN ver_codgmar%NOTFOUND;    
   END LOOP;
   
   
   OPEN ver_marca;
   LOOP 
        FETCH ver_marca into reg_marca;
        EXIT WHEN ver_marca%NOTFOUND;
        
    END LOOP;
    
     OPEN ver_modelo;
   LOOP 
        FETCH ver_modelo into reg_modelo;
        EXIT WHEN ver_modelo%NOTFOUND;
      
    END LOOP;
    
     dbms_output.put_line('codigo de repuesto: '|| reg_datosR.Codigorpto  || 'nombre de repuesto: ' || reg_datosR.Nombrerep || 'descripcion de repuesto: ' || reg_datosR.Descripcion || 'PRECIO DE repuesto: ' || reg_datosR.Precio ); 
    dbms_output.put_line('codigo del auto: '|| reg_datosR.Codigo_Auto || 'marca: ' || reg_marca.nombre || 'MODELO DEL AUTO: ' || reg_modelo.modelo  ); 
    
    CLOSE ver_modelo;
    CLOSE ver_marca;
    CLOSE ver_codgmar; 
    CLOSE ver_datosR;
    CLOSE ver_codgA;
    
   
    end if;
    END LOOP;
    
     CLOSE ver_precio;
    
   
end busca_precio;

set serveroutput on;
execute busca_precio;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---Cree una lista de precios de veh�culos. Aquellos veh�culos cuyo precio sobrepase los
---10.000.000, aplicar incremento del 5% e imprimir su precio real

--Actualizar a trav�s de un SP o funci�n, los precios de los autos con el precio m�s incremento
--del punto anterior.



create or replace procedure caros
as
cursor c_precios is
select PrecioVenta from AUTOM;
prec number(10);
total number(10);
begin
   OPEN c_precios;
   total:=0;
   LOOP 
        FETCH c_precios into prec;
        EXIT WHEN c_precios%NOTFOUND;
        dbms_output.put_line('precio  '||prec); 
        if prec > 210000  then
        total:=prec+prec*0.05;
        dbms_output.put_line('precio real ' ||prec ||'precio nuevo ' || total );
        UPDATE AUTOM SET PrecioVenta = total;
        end if;
   END LOOP;
   CLOSE c_precios;
           
end caros;

execute caros;



select * from AUTOM; 