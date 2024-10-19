#!/usr/bin/


echo "Arranca todo , papa!!"
docker compose up -d --build


# Wait until MySQL is ready
until docker exec -it mysql mysql -u root -pcoderhouse -e "\q"
do
    echo "Waiting for MySQL to be ready..."
    sleep 1
done

echo "MySQL is ready."

echo "volvemos a arrancar"

echo "Que empiece el juego!"
echo "Generamos arquitectura base"
docker exec -it mysql mysql -u root -pcoderhouse -e "source /sql_code/1.BaseCode.sql"
echo "Generamos ingesta de datos"
docker exec -it mysql mysql -u root -pcoderhouse -e "source /sql_code/2.Population.sql"
echo "Generamos Objetos de la base de datos"
docker exec -it mysql mysql -u root -pcoderhouse -e "source /sql_code/3.Objects.sql"

echo "Se ha concluido la carga --> listo para romper codigo SQL"


