docker build -t maximam2014/multi-client:latest -t maximam2014/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maximam2014/multi-server:latest -t maximam2014/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maximam2014/multi-worker:latest -t maximam2014/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push maximam2014/multi-client:latest
docker push maximam2014/multi-server:latest
docker push maximam2014/multi-worker:latest

docker push maximam2014/multi-client:$SHA
docker push maximam2014/multi-server:$SHA
docker push maximam2014/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maximam2014/multi-server:$SHA
kubectl set image deployments/client-deployment client=maximam2014/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maximam2014/multi-worker:$SHA