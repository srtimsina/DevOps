# Steps to setup kubernetes cluster
### Make sure, overlay network and bridge netfilter turned on
```bash
    cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
    overlay
    br_netfilter
    EOF

    sudo modprobe overlay 
    sudo modprobe br_netfilter
```
### Make sure swap is turned off

### Immediately turn off swap - until reboot
```bash
  sudo swapoff -a 
```
### Turn off swap after restart
```bash
   sudo sed -i 's|^/swap.img|#/swap.img|g' /etc/fstab
```

### You need to make sure kubernetes can do IPv4 forwarding.

```bash
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
```
### Reboot sysctl
```bash
 sudo sysctl --system
```

### Setup docker engine as container runtime
[Official Documentation](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) on setting up [docker](https://docs.docker.com/engine/install/ubuntu/)
```bash
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update

    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
### Setting up cri-dockerd
Official documentation [docker](https://github.com/Mirantis/cri-dockerd)

### Clone cri-dockerd repo
```bash
    git clone https://github.com/Mirantis/cri-dockerd.git
```

### Run following commands as root
```bash
    ###Install GO###
    wget https://storage.googleapis.com/golang/getgo/installer_linux
    chmod +x ./installer_linux
    ./installer_linux
    source ~/.bash_profile

    cd cri-dockerd
    mkdir bin
    go build -o bin/cri-dockerd
    mkdir -p /usr/local/bin
    install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
    cp -a packaging/systemd/* /etc/systemd/system
    sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
    systemctl daemon-reload
    systemctl enable cri-docker.service
    systemctl enable --now cri-docker.socket
```

## Install kubeadm kubectl, kubelet
Official documentation [docker](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-runtime)
```bash
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
```

#### Now run the following on control plane only
```bash
    sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --cri-socket unix:///var/run/cri-dockerd.sock
```
#### Run following as a normal user
```bash
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
#### As a normal user to list nodes
```bash
    kubectl get nodes
```
#### Install calico
```bash
    kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```
#### As a normal user to list nodes
```bash
    kubectl get nodes
```

#### Run the below command on the control plane to print join command
```bash
kubeadm token create --print-join-command
```
### On the worker nodes, run the join command, add cri-socket in the join command "--cri-socket unix:///var/run/cri-dockerd.sock" to join the worker node to k8s cluster.

### After sometimes, on the control plane
#### As a normal user to list nodes
```bash
    kubectl get nodes
```
### To describe node
```bash
    kubectl describe node {node_name}
```


### To setup docker containerd as the container runtime.
#### Follow the below steps.
Instead of installing docker, install containerd.
```bash
    sudo apt-get update && sudo apt-get install -y containerd

    sudo mkdir -p /etc/containerd

    sudo containerd config default | sudo tee /etc/containerd/config.toml

    sudo systemctl restart containerd

    sudo systemctl status containerd
```