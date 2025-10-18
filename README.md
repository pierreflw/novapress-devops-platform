# Novapress DevOps Platform

**Plateforme DevOps complète et automatisée** déployée sur **Google Cloud Platform (GCP)**.  
Elle démontre ma capacité à concevoir, déployer et superviser une infrastructure cloud moderne en appliquant les bonnes pratiques du DevOps.

---

## 🎯 Objectif du projet

Mettre en place une **infrastructure automatisée** permettant :
- le **provisionnement** des ressources cloud avec **Terraform**  
- la **configuration** des serveurs avec **Ansible**  
- le **déploiement continu** d’une application web (frontend, backend, base de données) via **GitLab CI/CD** et **Helm**  
- la **supervision complète** de la plateforme avec **Prometheus** et **Grafana**

Ce projet illustre l’ensemble du cycle DevOps : **Infrastructure as Code, CI/CD, containerisation, orchestration et monitoring**.

---

## 🧱 Architecture

- **Infrastructure** : Terraform (GCP), Ansible, NGINX (reverse proxy HTTPS)
- **CI/CD** : GitLab hébergé sur la plateforme, pipelines automatiques et runners
- **Orchestration** : Kubernetes (K3s), Traefik, Helm
- **Supervision** : Prometheus, Grafana, Alertmanager

---

## 📂 Structure du projet

novapress-devops-platform/
- novapress-infra/ # Terraform + Ansible (provisionnement et configuration)
─ novapress-back/ # API (Node.js) avec Dockerfile
─ novapress-front/ # UI (React) avec Dockerfile
─ novapress-chart/ # Helm chart pour le déploiement complet

---

## ⚙️ Exemple de workflow

1. **Provisioning** de l’infrastructure avec Terraform  
2. **Configuration automatique** des serveurs via Ansible  
3. **Mise en place de GitLab** et de ses runners  
4. **Déploiement applicatif** sur Kubernetes via Helm  
5. **Supervision et alerting** avec Prometheus / Grafana  

---

## 🧰 Stack utilisée

| Domaine | Outils |
|----------|--------|
| Infrastructure | Terraform, Ansible, GCP |
| CI/CD | GitLab, Helm, Docker |
| Orchestration | Kubernetes (K3s), Traefik, Certbot |
| Supervision | Prometheus, Grafana, Alertmanager, Rancher |

---

## 👤 Auteur

Projet réalisé par **Pierre-Gilles Flauw**  

Ce projet a été conçu dans le cadre de ma préparation au **Titre Professionnel Administrateur Système DevOps (niveau 6)**.
