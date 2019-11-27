docker build -t rstaehli/multi-client:latest -t rstaehli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rstaehli/multi-server:latest -t rstaehli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rstaehli/multi-worker:latest -t rstaehli/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rstaehli/multi-client:latest
docker push rstaehli/multi-server:latest
docker push rstaehli/multi-worker:latest
docker push rstaehli/multi-client:$SHA
docker push rstaehli/multi-server:$SHA
docker push rstaehli/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rstaehli/multi-server:$SHA
kubectl set image deployments/client-deployment client=rstaehli/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rstaehli/multi-worker:$SHA
