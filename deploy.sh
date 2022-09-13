docker build -t donwishnek/multi-client:latest -t donwishnek/multi-client:$SHA -f /client/Dockerfile ./client
docker build -t donwishnek/multi-server:latest -t donwishnek/multi-server:$SHA -f /server/Dockerfile ./server
docker build -t donwishnek/multi-worker:latest -t donwishnek/multi-worker:$SHA -f /worker/Dockerfile ./worker

docker push donwishnek/multi-client:latest
docker push donwishnek/multi-server:latest
docker push donwishnek/multi-worker:latest

docker push donwishnek/multi-client:$SHA
docker push donwishnek/multi-server:$SHA
docker push donwishnek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=donwishnek/multi-server:$SHA
kubectl set image deployments/client-deployment client=donwishnek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=donwishnek/multi-worker:$SHA