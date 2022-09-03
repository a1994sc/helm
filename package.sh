#!/bin/sh

for package in sources/*; do
    helm schema-gen $package/values.yaml > $package/values.schema.json;

    helm lint $package/.

    helm package $package
done

helm repo index --url https://a1994sc.github.io/helm-repo/ --merge index.yaml .