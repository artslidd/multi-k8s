docker build -t artslidd/multi-client:latest -t artslidd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t artslidd/multi-server:latest -t artslidd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t artslidd/multi-worker:latest -t artslidd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push artslidd/multi-client:latest
docker push artslidd/multi-server:latest
docker push artslidd/multi-worker:latest
docker push artslidd/multi-client:$SHA
docker push artslidd/multi-server:$SHA
docker push artslidd/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=artslidd/multi-client:$SHA
kubectl set image deployments/server-deployment server=artslidd/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=artslidd/multi-worker:$SHA