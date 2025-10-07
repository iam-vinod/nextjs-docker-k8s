# Next.js App Deployment on Kubernetes using Docker and Minikube

This project demonstrates how to containerize a **Next.js application** using Docker and deploy it to a **Kubernetes cluster** running on **Minikube** inside an **AWS EC2 instance**.

---

## 🧰 Tools & Technologies Used

- **AWS EC2 (Ubuntu)**
- **Docker**
- **GitHub Container Registry (GHCR)**
- **Kubernetes (Minikube)**
- **kubectl**

---

## 📁 Project Structure

```
nextjs-docker-k8s/
├── .github/
│ └── workflows/
│ └── ci-cd.yml # GitHub Actions workflow file
│
├── app/ # Next.js app source code
├── k8s/
│ ├── deployment.yaml # Kubernetes Deployment
│ └── service.yaml # Kubernetes Service
│
├── public/ # Static assets
├── .gitignore
├── Dockerfile # Docker image build configuration
├── README.md
├── next.config.ts
├── package.json
├── package-lock.json
├── postcss.config.mjs
└── tsconfig.json

```


---

## ⚙️ Step-by-Step Setup

### 1. Clone the Repository

```bash
git clone https://github.com/iam-vinod/nextjs-docker-k8s.git
cd nextjs-docker-k8s

2. Build & Push the Docker Image to GHCR

docker build -t ghcr.io/iam-vinod/my-nextjs-app:latest .
echo "<YOUR_GITHUB_PAT>" | docker login ghcr.io -u iam-vinod --password-stdin
docker push ghcr.io/iam-vinod/my-nextjs-app:latest

3. Start Minikube

minikube start

4. Deploy to Kubernetes

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

5. Verify Deployment

kubectl get pods
kubectl get svc
kubectl logs -l app=nextjs

6. Access the Application

If using Minikube on EC2, access via NodePort:

curl ifconfig.me  # Get your EC2 Public IP

Then open in browser:

http://<EC2_PUBLIC_IP>:30080

🚀 Deployment Summary

| Component        | Description                              |
| ---------------- | ---------------------------------------- |
| **App Name**     | Next.js App                              |
| **Image**        | `ghcr.io/iam-vinod/my-nextjs-app:latest` |
| **Cluster**      | Minikube on AWS EC2                      |
| **Service Type** | NodePort (30080 → 3000)                  |
| **Pods**         | 2 replicas                               |
| **Access URL**   | `http://<EC2_PUBLIC_IP>:3000`           |

📸 Logs Snapshot

▲ Next.js 15.5.4
- Local:    http://localhost:3000
✓ Ready in 1242ms

