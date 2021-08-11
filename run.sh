docker-compose down

pushd ../api
./mvnw clean package
docker build -t yw/whatsinme-api .
popd

pushd ../app
npm run build-local
docker build -t yw/whatsinme-app-dev -f Dockerfile-dev .
popd

docker-compose -f docker-compose-dev.yml up -d
docker rmi -f $(docker images -f "dangling=true" -q)

chromium http://localhost:8080
