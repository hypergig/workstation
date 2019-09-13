echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

apts+=' google-cloud-sdk kubectl'
tests['gcloud']="gcloud --version"
tests['kubectl']="kubectl version --client"

(
    cd /tmp && curl -fLO https://github.com/istio/istio/releases/download/1.1.14/istio-1.1.14-linux.tar.gz
)&

posts['istioctl']+="tar xzvf /tmp/istio-1.1.14-linux.tar.gz -C /usr/local/bin --strip-components=2 istio-1.1.14/bin/istioctl"
tests['istioctl']+="istioctl version"
