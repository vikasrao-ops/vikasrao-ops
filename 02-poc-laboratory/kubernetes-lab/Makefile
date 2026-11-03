.PHONY: apply delete status rollout-status

apply:
	kubectl apply -f manifests/

delete:
	kubectl delete -f manifests/

status:
	kubectl get pods,svc,pdb -l app=resilient-workload

rollout-status:
	kubectl rollout status deployment/lab-resilient-app

