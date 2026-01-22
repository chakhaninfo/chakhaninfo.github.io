---
title: TeslaMate 설치 완벽 가이드 - AWS EC2와 Docker로 데이터 로거 구축하기
date: 2023-08-21 08:00:00
index_img: /images/teslamateAwsEc2/thumbnail.jpg
description: AWS EC2 t4g.micro 인스턴스(Ubuntu, ARM)에 Docker를 사용하여 TeslaMate를 설치하고 설정하는 완벽 가이드입니다. 비용 효율적인 테슬라 데이터 수집 서버 구축 방법을 단계별로 설명합니다.
tags:
  - tesla
  - 테슬라
  - teslamate
  - 테슬라메이트
  - docker
  - docker-compose
  - aws
  - ec2
  - arm
  - t4g.micro
  - ubuntu
  - Grafana
  - Postgres
  - 데이터로거
  - 테슬라 데이터
category:
  - Tesla
---

## TeslaMate란 무엇이고 왜 필요한가?

TeslaMate는 주행, 충전, 배터리 상태 등 테슬라 차량의 모든 데이터를 수집하고, Grafana 대시보드를 통해 시각화하여 보여주는 강력한 오픈소스 데이터 로거입니다. 내 차의 모든 기록을 직접 소유하고 분석하고 싶다면, TeslaMate는 최고의 선택입니다.

이 가이드에서는 월 약 1만원의 저렴한 비용으로 AWS(Amazon Web Services)의 EC2 인스턴스에 Docker를 사용하여 TeslaMate 서버를 구축하는 모든 과정을 단계별로 안내합니다.

### 필요 사항

- **AWS 계정**: 없다면 [여기](https://aws.amazon.com/ko/)에서 생성하세요.
- **Tesla 계정 및 토큰**: 데이터 수집을 위해 Tesla 계정이 필요합니다. API 토큰은 아래 앱을 통해 얻을 수 있습니다.
  - iOS: [Auth app for Tesla](https://apps.apple.com/kr/app/auth-app-for-tesla/id1552058613)
  - Android: [Tesla Tokens](https://play.google.com/store/apps/details?id=net.leveugle.teslatokens)
- **기본 지식**: AWS EC2 생성 및 SSH 접속 등 기본적인 서버 관련 지식이 있다면 따라오기 더 쉽습니다.

## 1. AWS EC2 서버 준비하기

### 1.1. 인스턴스 사양 선택 (t4g.micro)

![AWS EC2 인스턴스 요금표](/images/teslamateAwsEc2/teslamateAwsEc2-1.png "가장 저렴한 t4g.micro 인스턴스 선택")
TeslaMate는 최소 1GB의 RAM을 필요로 합니다. 서울 리전(ap-northeast-2)에서 가장 저렴하게 조건을 만족하는 인스턴스는 ARM 기반의 `t4g.micro`입니다. 월 비용은 약 $7.5, 한화로 1만원 내외입니다.

### 1.2. 인스턴스 생성

![AWS EC2 인스턴스 시작 버튼](/images/teslamateAwsEc2/teslamateAwsEc2-2.png "EC2 대시보드에서 인스턴스 시작")

1.  **이름 설정**: 'teslamate'와 같이 식별하기 쉬운 이름을 입력합니다.
    ![인스턴스 이름 설정](/images/teslamateAwsEc2/teslamateAwsEc2-8.png "인스턴스 이름 및 태그 입력")
2.  **OS 및 사양 선택**:
    - 애플리케이션 및 OS 이미지: `Ubuntu Server 20.04 LTS`
    - 아키텍처: `64비트(Arm)`
    - 인스턴스 유형: `t4g.micro`
      ![OS 및 인스턴스 유형 선택](/images/teslamateAwsEc2/teslamateAwsEc2-3.png "Ubuntu, arm, t4g.micro 선택")
3.  **키 페어 생성**: SSH 접속에 사용할 키 페어를 생성합니다. 'teslamate'라는 이름으로 키 페어를 생성하면 `teslamate.pem` 파일이 다운로드됩니다. 이 파일은 안전한 곳에 잘 보관해야 합니다.
    ![키 페어 생성 버튼](/images/teslamateAwsEc2/teslamateAwsEc2-4.png "새 키 페어 생성")
    ![키 페어 이름 입력](/images/teslamateAwsEc2/teslamateAwsEc2-5.png "키 페어 이름 'teslamate'로 설정")
4.  **스토리지 설정**: 최소 `30GB` 이상으로 설정하는 것을 권장합니다.
    ![스토리지 볼륨 설정](/images/teslamateAwsEc2/teslamateAwsEc2-6.png "스토리지를 30GB로 설정")
5.  **인스턴스 시작**: 우측 하단의 '인스턴스 시작' 버튼을 누릅니다.
    ![인스턴스 시작 버튼](/images/teslamateAwsEc2/teslamateAwsEc2-7.png "설정 완료 후 인스턴스 시작")

### 1.3. 방화벽 설정 (포트 개방)

생성된 인스턴스 상세 페이지로 이동하여, [보안] 탭 -> 보안 그룹 이름을 클릭합니다.
![인스턴스 상세 페이지](/images/teslamateAwsEc2/teslamateAwsEc2-9.png "생성된 인스턴스 확인")
![보안 그룹 링크](/images/teslamateAwsEc2/teslamateAwsEc2-11.png "보안 탭에서 보안 그룹으로 이동")

'인바운드 규칙 편집' 페이지에서 TeslaMate 접속에 필요한 포트를 열어줍니다.
![인바운드 규칙 편집](/images/teslamateAwsEc2/teslamateAwsEc2-12.png "인바운드 규칙 편집 페이지")

아래와 같이 `규칙 추가`를 눌러 포트 2개를 추가하고 저장합니다.
![규칙 추가 버튼](/images/teslamateAwsEc2/teslamateAwsEc2-13.png "규칙 추가")

- `포트 3000`: Grafana 대시보드 접속용
- `포트 4000`: TeslaMate 웹 인터페이스 접속용
  ![포트 설정 완료](/images/teslamateAwsEc2/teslamateAwsEc2-14.png "3000, 4000 포트를 Anywhere-IPv4로 개방")

## 2. 서버 접속 및 기본 환경 설정

### 2.1. SSH로 EC2 인스턴스 접속

먼저, 아까 다운로드한 `.pem` 키 파일의 권한을 변경해야 합니다.

```bash
chmod 400 teslamate.pem
```

인스턴스 상세 페이지에서 '퍼블릭 IPv4 주소'를 복사합니다.
![퍼블릭 IP 주소 복사](/images/teslamateAwsEc2/teslamateAwsEc2-10.png "연결에 필요한 퍼블릭 IP 주소 복사")

아래 명령어를 터미널에 입력하여 서버에 접속합니다.

```bash
ssh -i "teslamate.pem" ubuntu@<퍼블릭_IP_주소>
```

### 2.2. Docker 및 Docker-Compose 설치

서버에 접속한 상태에서, 아래 코드를 터미널에 그대로 붙여넣어 Docker와 Docker-Compose를 한번에 설치하는 쉘 스크립트 파일을 생성합니다.

```bash
cat > setup_docker_and_compose_arm.sh << EOF
#!/bin/bash
# Docker 및 Docker-Compose 설치 스크립트 (ARM64)
set -e
echo "Updating package lists..."
sudo apt-get update
echo "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Adding Docker repository for ARM64..."
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Updating package lists again..."
sudo apt-get update
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "Installation complete. Please log out and log back in for group changes to take effect."
docker --version
docker-compose --version
EOF
```

스크립트 파일을 만들었다면, 아래 명령어로 실행하여 설치를 진행합니다.

```bash
bash setup_docker_and_compose_arm.sh
```

설치가 완료되면 `exit`로 로그아웃했다가 **다시 SSH로 접속**하여 그룹 권한을 활성화합니다.

## 3. TeslaMate 설치 및 실행

`teslamate` 디렉토리를 만들고, 그 안에 `docker-compose.yml` 파일을 생성합니다.

```bash
mkdir teslamate && cd teslamate
```

아래 내용을 복사하여 `docker-compose.yml` 파일을 생성합니다.

```bash
cat > docker-compose.yml << EOF
version: "3.8"

services:
  teslamate:
    image: teslamate/teslamate:latest
    restart: always
    environment:
      - ENCRYPTION_KEY= # 강력한 비밀번호로 변경하세요
      - DATABASE_USER=teslamate
      - DATABASE_PASS=secret
      - DATABASE_NAME=teslamate
      - DATABASE_HOST=database
      - MQTT_HOST=mosquitto
    ports:
      - 4000:4000
    volumes:
      - ./import:/opt/app/import
    cap_drop:
      - all

  database:
    image: postgres:15
    restart: always
    environment:
      - POSTGRES_USER=teslamate
      - POSTGRES_PASSWORD=secret
      - POSTGRES_DB=teslamate
    volumes:
      - teslamate-db:/var/lib/postgresql/data

  grafana:
    image: teslamate/grafana:latest
    restart: always
    environment:
      - DATABASE_USER=teslamate
      - DATABASE_PASS=secret
      - DATABASE_NAME=teslamate
      - DATABASE_HOST=database
    ports:
      - 3000:3000
    volumes:
      - teslamate-grafana-data:/var/lib/grafana

  mosquitto:
    image: eclipse-mosquitto:2.0
    restart: always
    command: "mosquitto -c /mosquitto-no-auth.conf"
    ports:
      - 1883:1883
    volumes:
      - mosquitto-conf:/mosquitto/config
      - mosquitto-data:/mosquitto/data

volumes:
  teslamate-db:
  teslamate-grafana-data:
  mosquitto-conf:
  mosquitto-data:
EOF
```

**중요**: `ENCRYPTION_KEY`의 기본값을 반드시 자신만의 강력한 비밀번호로 변경하세요.

이제 아래 명령어로 TeslaMate를 실행합니다.

```bash
docker-compose up -d
```

## 4. TeslaMate 초기 설정 및 대시보드 접속

TeslaMate 설정은 4000번 포트, 데이터 시각화(Grafana)는 3000번 포트로 접속합니다.

- **TeslaMate 설정**: `http://<퍼블릭_IP_주소>:4000`
- **Grafana 대시보드**: `http://<퍼블릭_IP_주소>:3000`

`http://<퍼블릭_IP_주소>:4000`으로 접속하여 `Auth for Tesla` 앱에서 발급받은 API 토큰을 입력합니다.
![TeslaMate 설정 화면](/images/teslamateAwsEc2/teslamateAwsEc2-17.png "TeslaMate 웹 인터페이스")
![API 토큰 입력](/images/teslamateAwsEc2/teslamateAwsEc2-18.png "Auth for Tesla 앱에서 발급받은 토큰 입력")
토큰이 정상적으로 인증되면, 아래와 같이 차량 정보가 표시됩니다.
![차량 정보 확인](/images/teslamateAwsEc2/teslamateAwsEc2-19.png "슬립 상태의 차량 정보")

이제 `http://<퍼블릭_IP_주소>:3000`으로 접속하여 Grafana 대시보드를 설정합니다.
초기 아이디/비밀번호는 `admin` / `admin` 입니다.
![Grafana 로그인 화면](/images/teslamateAwsEc2/teslamateAwsEc2-15.png "Grafana 초기 로그인")
로그인 후 새 비밀번호를 설정하면 모든 준비가 끝납니다.
![Grafana 새 비밀번호 설정](/images/teslamateAwsEc2/teslamateAwsEc2-16.png "보안을 위해 새 비밀번호 설정")

이제 차량을 운행하거나 충전하면 데이터가 자동으로 수집되고, Grafana 대시보드를 통해 화려한 시각 자료로 확인할 수 있습니다.

## 문제 해결 (Troubleshooting)

- **`502 Bad Gateway` 오류**: `http://<퍼블릭_IP_주소>:4000` 접속 시 이 오류가 발생하면 대부분 서버의 메모리(RAM) 부족 문제입니다. TeslaMate는 최소 1GB의 RAM을 필요로 하므로, `t4g.nano`(0.5GB RAM) 등 더 낮은 사양의 인스턴스를 사용했다면 `t4g.micro`로 업그레이드해야 합니다.
- **Docker 명령어 권한 오류**: `docker` 명령어 실행 시 `permission denied` 오류가 발생하면, 로그아웃 후 다시 접속하여 사용자 그룹 변경사항을 적용했는지 확인하세요.

## 마무리

이제 AWS EC2에 나만의 TeslaMate 서버를 성공적으로 구축했습니다. 이 가이드를 통해 수집된 데이터를 활용하여 당신의 드라이빙 패턴과 차량 상태를 더 깊이 이해하는 데 도움이 되길 바랍니다.

레퍼럴코드: [https://www.tesla.com/ko_kr/referral/jungwon51749](https://www.tesla.com/ko_kr/referral/jungwon51749)
