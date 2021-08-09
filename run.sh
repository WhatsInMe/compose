docker-compose down
docker rmi -f $(docker images -f "dangling=true" -q)
pushd ../api
./mvnw clean package
docker build -t yw/whatsinme-api .
popd
pushd ../app
npm run build
docker build -t yw/whatsinme-app-dev -f Dockerfile-dev .
popd
docker-compose -f docker-compose-dev.yml up -d
