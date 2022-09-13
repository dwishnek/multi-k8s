docker build -t donwishnek/multi-client-k8s:latest -t donwishnek/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t donwishnek/multi-server-k8s-pgfix:latest -t donwishnek/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t donwishnek/multi-worker-k8s:latest -t donwishnek/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push donwishnek/multi-client-k8s:latest
docker push donwishnek/multi-server-k8s-pgfix:latest
docker push donwishnek/multi-worker-k8s:latest

docker push donwishnek/multi-client-k8s:$SHA
docker push donwishnek/multi-server-k8s-pgfix:$SHA
docker push donwishnek/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=donwishnek/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=donwishnek/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=donwishnek/multi-worker-k8s:$SHA