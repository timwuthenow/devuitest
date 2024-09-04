echo "Adding Keycloak CR"

oc apply -f keycloak-cr.yaml

echo "Creating secret for Kogito Realm"

oc create secret generic kogito-realm --from-file=realm.json=kogito-realm.json

echo "Creating Realm Custom Resource"

oc apply -f keycloak-realm.yaml

