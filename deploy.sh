docker build -t tjgersho/multi-client:latest -t tjgersho/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tjgersho/multi-server:latest -t tjgersho/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tjgersho/multi-worker:latest -t tjgersho/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tjgersho/multi-client:latest
docker push tjgersho/multi-server:latest
docker push tjgersho/multi-worker:latest
docker push tjgersho/multi-client:$SHA
docker push tjgersho/multi-server:$SHA
docker push tjgersho/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tjgersho/multi-client:$SHA
kubectl set image deployments/server-deployment server=tjgersho/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tjgersho/multi-worker:$SHA