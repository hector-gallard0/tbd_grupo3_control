# tbd_grupo3_control
Repositorio que contiene el diagrama ER, el diccionario de datos y los scripts relacionados con la resolución del Control 1 del Laboratorio de Taller de Bases de Datos de la Universidad de Santiago de Chile.


<h2>Alumnos:</h2>

Fabrizio Montuschi
Hector Gallardo
Nicolas Rojas Gonzalez
Clemente Aguilar
Felipe Diaz

\br
\br


<h2>Para ejecutar los scripts de creación, poblado y consultas a la base de datos se deben ejecutar los siguientes comandos en orden:</h2>

1. Se abre la cmd y se situa en la carpeta del repositorio.

2. Se inicia sesión en postgres, donde el flag -U indica el usuario con el cual se desea conectar, por ejemplo, para iniciar sesión con el usuario postgres:

psql -U postgres

3. Después de ingresar correctamente la contraseña, se ejecutará una shell SQL, acá se utilizará el comando \i para ejecutar órdenes SQL desde un archivo.

4. Se crea la base de datos con sus tablas:

\i dbCreate.sql

5. Se pobla la base de datos:

\i loadData.sql

6. Se ejecutan las queries correspondientes con cada pregunta:

\i runStatements.sql





