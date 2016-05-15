# T2tallerintegracion

Commit data: [![Build Status](https://api.travis-ci.org/eczerega/integrat2enzozerega.png)](https://travis-ci.org/eczerega/T2tallerintegracion)

Coverage: [![Coverage Status](https://coveralls.io/repos/github/eczerega/integrat2enzozerega/badge.svg?branch=master)](https://coveralls.io/github/eczerega/T2tallerintegracion?branch=master)

Corrección:

	FUNCIONAMIENTO
	DE LA API
		La api funciona correctamente: https://integrat2enzozerega.herokuapp.com
	TESTS
		Los test cubren el 88% del código (en la carpeta RESULTADOS Y/O COBERTURAS se encuentran en detalle)
	INTEGRACIÓN
	CONTINUA
		La aplicación hace deploy automatico cuando se aprueba un pull request
	VERSIONAMIENTO
		Se realiza un correcto uso de git de acuerdo a las reglas
		Al momento de mergear se deploya a heroku si solo si pasa todos los tests unitarios. Hay 3 commits iniciales donde se levanto la aplicación inicial, luego de eso se ocupan pull requests. Además la api responde según la versión que está deployada (son número consecutivos cada vez que se acepta el merge de master).
	BADGES DE
	ESTADO
		Las dos badges se encuentran acá arriba en el readme

Debería estar todo implementado y funcionando OK.

Enzo Zerega

