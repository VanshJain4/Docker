docker network create -d overlay backend
docker network create -d overlay frontend
docker service create --name vote -p 80:80 --network frontend --replicas 2 bretfisher/examplevotingapp_vote

docker service create --name redis --network frontend redis:3.2

docker service create --name db --network backend -e POSTGRES_HOST_AUTH_METHOD=trust --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker

docker service create --name result --network backend -p 5001:80 bretfisher/examplevotingapp_result

docker service ls
docker service ps vote
docker service ps redis
docker service ps db
docker service ps worker
docker service ps result
docker service logs worker

# go to the ip address you will see a dialogue for voting
# and if you go to port 5001 you will see the results
docker service logs result
docker service logs vote
docker service logs redis
docker service logs db
docker service logs worker