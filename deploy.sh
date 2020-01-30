docker build -t phfldocker/multi-client:latest -t phfldocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phfldocker/multi-server:latest -t phfldocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phfldocker/multi-worker:latest -t phfldocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push phfldocker/multi-client:latest
docker push phfldocker/multi-server:latest
docker push phfldocker/multi-worker:latest
docker push phfldocker/multi-client:$SHA
docker push phfldocker/multi-server:$SHA
docker push phfldocker/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phfldocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=phfldocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phfldocker/multi-worker:$SHA