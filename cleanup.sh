az k8sconfiguration delete -g EphArcTest \
-c griffarctest \
-n cluster-baseline 

kubectl delete ns monitoring falco

kubectl delete psp \
prometheus-operator-alertmanager \
prometheus-operator-grafana \
prometheus-operator-grafana-test \
prometheus-operator-kube-state-metrics \
prometheus-operator-operator \
prometheus-operator-prometheus \
prometheus-operator-prometheus-node-exporter

kubectl delete clusterrole \
prometheus-operator-prometheus \
prometheus-operator-grafana-clusterrole \
prometheus-operator-kube-state-metrics \
prometheus-operator-operator \
prometheus-operator-operator-psp \
prometheus-operator-prometheus-psp \
psp-prometheus-operator-kube-state-metrics \
psp-prometheus-operator-prometheus-node-exporter \

kubectl delete clusterrolebinding \
prometheus-operator-grafana-clusterrolebinding \
prometheus-operator-kube-state-metrics \
prometheus-operator-operator \
prometheus-operator-operator-psp \
prometheus-operator-prometheus \
prometheus-operator-prometheus-psp \
psp-prometheus-operator-kube-state-metrics \
psp-prometheus-operator-prometheus-node-exporter

kubectl delete svc -n kube-system \
prom-prometheus-operator-kubelet \
prometheus-operator-coredns \
prometheus-operator-kube-controller-manager \
prometheus-operator-kube-etcd \
prometheus-operator-kube-proxy \
prometheus-operator-kube-scheduler \
prometheus-operator-kubelet

kubectl delete MutatingWebhookConfiguration prometheus-operator-admission
kubectl delete ValidatingWebhookConfiguration prometheus-operator-admission
