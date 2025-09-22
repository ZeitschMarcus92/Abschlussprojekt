---
title: Abschlussprojekt -- DevOps Engineering bei Kukuk Technology
  Future GmbH
---

# 1. Einleitung

Ziel des Projekts ist es, eine vollständige CI/CD-Pipeline mit Jenkins
aufzubauen, ein Microservice-Frontend und -Backend in Containern
bereitzustellen und diese in Kubernetes in einer Entwicklungs- und
Produktionsumgebung auszurollen. Alle Schritte sollen automatisiert,
reproduzierbar und dokumentiert erfolgen. Als Quereinsteiger liegt der
Fokus besonders auf dem Verständnis der Abläufe und der sauberen
Umsetzung.

# 2. Projektstruktur

Das Projekt ist in einem Git-Repository abgelegt und folgt einer klaren
Struktur:\
\
- backend/ (Spring Boot Backend)\
- frontend/ (Angular/JS Frontend)\
- k8s/ (Kubernetes YAML-Dateien für Deployments, Services, Namespaces)\
- jenkins/ (Jenkinsfile und CI/CD-Konfiguration)\
- docs/ (Dokumentation, README)\
\
Diese Trennung sorgt dafür, dass die einzelnen Komponenten klar
abgegrenzt sind.


# 3. Spring Boot Konfiguration

Für das Backend wurden zwei Konfigurationsdateien erstellt:\
\
- application-dev.properties\
- application-prod.properties\
\
Zusätzlich gibt es zwei Maven-Profile in der pom.xml:

\<profiles\>\
\<profile\>\
\<id\>dev\</id\>\
\<properties\>\
\<spring.profiles.active\>dev\</spring.profiles.active\>\
\</properties\>\
\</profile\>\
\<profile\>\
\<id\>prod\</id\>\
\<properties\>\
\<spring.profiles.active\>prod\</spring.profiles.active\>\
\</properties\>\
\</profile\>\
\</profiles\>

Unterschiede:\
- Dev: ausführliches Logging, Standardport 8080\
- Prod: reduziertes Logging (ERROR-Level), ebenfalls Port 8080\
\
Das aktive Profil wird in Kubernetes über die Umgebungsvariable
SPRING_PROFILES_ACTIVE gesetzt.

# 4. CI/CD Pipeline mit Jenkins

Die CI/CD-Pipeline ist mit Jenkins implementiert und umfasst folgende
Stages:\
\
1. Build (Backend mit Maven, Frontend mit npm)\
2. Test (JUnit-Tests im Backend, optional im Frontend)\
3. Docker Build (Bau der Images)\
4. Docker Push (Push zu GitHub Container Registry)\
5. Deploy Dev (automatisches Deployment ins Dev-Cluster)\
6. Manual Approval (manuelle Freigabe durch den Operator)\
7. Deploy Prod (Deployment ins Prod-Cluster nach Freigabe)


# 5. Docker & Sicherheit

Die Images werden mit Tags im Format dev-\<sha\> versehen und per Digest
deployt, um sicherzustellen, dass nur unveränderliche Images verwendet
werden.\
\
Die Authentifizierung zur GHCR erfolgt über ein Kubernetes Secret
(imagePullSecrets: ghcr-creds), welches Benutzername und PAT enthält.

# 6. Kubernetes Deployments

Für die Anwendung wurden zwei Namespaces erstellt:\
- marcuszeitsch-dev\
- marcuszeitsch-prod\
\
Jede Umgebung enthält Deployments und Services für Backend und Frontend.
Die Deployments setzen die Umgebungsvariable SPRING_PROFILES_ACTIVE auf
dev bzw. prod.


# 7. Tests

Automatisierte Tests sind aktuell in der Pipeline deaktiviert
(-Dmaven.test.skip=true), da keine JUnit-Tests im Projekt vorhanden
sind. Die Pipeline ist jedoch vorbereitet, um Tests automatisch
auszuführen, sobald sie implementiert sind.

# 8. Dokumentation & Präsentation

Das Projekt wird in einem README.md beschrieben (Projektüberblick,
CI/CD-Ablauf, Properties, Deploymentschritte). Für die Abgabe am
26.09.2025 wird ein Jenkins-Lauf sowie der Status der
Kubernetes-Deployments (Pods, Services) gezeigt.

# 9. Zusammenschluss 

Alle Anforderungen aus dem Aufgabenblatt wurden erfüllt:\
- Saubere Projektstruktur\
- CI/CD-Pipeline mit Jenkins\
- Getrennte DEV- und PROD-Umgebungen\
- Deployments in Kubernetes mit Secrets und Immutable Images\
- Spring Boot Profile für Umgebungsabhängigkeiten\
\
Systemzustand ist stabil (Pods Running, Deployments erfolgreich). Die
Umsetzung ist praxistauglich und bietet eine solide Grundlage für
Erweiterungen wie Tests, Monitoring und Observability.
