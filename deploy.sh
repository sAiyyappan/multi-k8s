docker build -t sswaminath/multi-client-k8s:latest -t sswaminath/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t sswaminath/multi-server-k8s-pgfix:latest -t sswaminath/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t sswaminath/multi-worker-k8s:latest -t sswaminath/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push sswaminath/multi-client-k8s:latest
docker push sswaminath/multi-server-k8s-pgfix:latest
docker push sswaminath/multi-worker-k8s:latest

docker push sswaminath/multi-client-k8s:$SHA
docker push sswaminath/multi-server-k8s-pgfix:$SHA
docker push sswaminath/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sswaminath/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=sswaminath/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=sswaminath/multi-worker-k8s:$SHA