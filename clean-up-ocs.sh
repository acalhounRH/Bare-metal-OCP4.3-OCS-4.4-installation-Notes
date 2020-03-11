oc delete -f small-scale-ocs-cluster-cr.yaml
sleep 30
oc delete pvc --all
oc delete storagecluster --all -n openshift-storage --wait=true --timeout=5m --cascade=false
oc delete -n openshift-storage cephcluster --all --wait=true --timeout=5m
oc delete project openshift-storage --wait=true --timeout=5m
oc delete crd backingstores.noobaa.io bucketclasses.noobaa.io cephblockpools.ceph.rook.io cephclusters.ceph.rook.io cephfilesystems.ceph.rook.io cephnfses.ceph.rook.io cephobjectstores.ceph.rook.io cephobjectstoreusers.ceph.rook.io noobaas.noobaa.io ocsinitializations.ocs.openshift.io storageclusterinitializations.ocs.openshift.io storageclusters.ocs.openshift.io --wait=true --timeout=5m

ansible -m shell -a "sudo rm -rf /var/lib/rook" -i post_install_inventory_supermicro.yml all -u core

#clean up local storage 
oc delete -f example_localpv_cr.yaml
oc delete --all sc
oc delete pv --all

oc delete -f ./local-storage-operator/examples/olm/catalog-create-subscribe.yaml

echo "Local-storage and OCS are uninstalled, now wipe all devices on storage hosts!!!"
