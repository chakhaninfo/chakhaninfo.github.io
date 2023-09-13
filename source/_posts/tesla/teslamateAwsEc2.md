---
title: AWS EC2에서 TeslaMate 시작하기 (ubuntu, arm)
date: 2023-08-21 08:00:00
index_img: /images/teslamateAwsEc2/thumbnail.jpg
tags:
  - tesla
  - teslamate
  - docker
  - docker-compose
  - aws
  - ec2
  - arm
  - t4g.micro
  - 레퍼럴코드
  - referral
  - ubuntu
  - 우분투
category:
  - Tesla
---

## 소개

TeslaMate는 테슬라 차량의 데이터를 수집하고 시각화하는 데 사용되는 오픈 소스 솔루션입니다. 이 블로그 포스트에서는 AWS(Amazon Web Services)에서 TeslaMate를 설치하는 단계를 상세히 안내합니다. 아직 AWS에 익숙하지 않은 분들도 함께 따라와서 간단한 몇 가지 단계로 TeslaMate를 구축해보세요.

## 필요 사항

AWS 계정: AWS 계정이 없다면 [여기](https://aws.amazon.com/ko/)에서 계정을 생성하세요.
Tesla 계정: 테슬라 차량을 가지고 있어야 하며, 테슬라 계정에 로그인해야 합니다.
Tesla token: 테슬라 계정의 token을 생성하기 위해 [Auth app for Tesla(apple)](https://apps.apple.com/kr/app/auth-app-for-tesla/id1552058613) / [Tesla Tokens
(google)](https://play.google.com/store/apps/details?id=net.leveugle.teslatokens&pcampaignid=web_share)앱을 설치해야 합니다.
기본 지식: AWS EC2 인스턴스를 생성하고 기본적인 커맨드 라인 명령을 사용하는 데에 기본 지식이 필요합니다.

## AWS 인스턴스 선택

![](/images/teslamateAwsEc2/teslamateAwsEc2-1.png)
서울 인스턴스 중 `t4g.micro`인스턴스가 시간당 `$0.0104`로 가장 저렴합니다. 1달에 `$7.49` 정도의 비용이 듭니다. 원화로 `10,000원` 전후가 될 것 같아요. 인스턴스 가격은 [여기](https://aws.amazon.com/ko/ec2/pricing/on-demand/)에서 확인할 수 있습니다.

## 인스턴스 시작

![](/images/teslamateAwsEc2/teslamateAwsEc2-2.png)

1. `인스턴스 시작`을 클릭합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-8.png)

2. 이름 및 태그에서 인스턴스 이름을 `teslamate`로 설정합니다. 태그는 필수는 아니지만 나중에 인스턴스를 찾기 쉽도록 설정합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-3.png)

3. Amazon Machine Image(AMI) 선택 단계에서 원하는 운영체제를 `Ubuntu`로 선택하고 버전은 `Ubuntu Server 20.04 LTS (HVM), SSD Volume Type`로 선택합니다. 아키텍처는 `64비트(Arm)`으로 선택하고 인스턴스 유형은 `t4g.micro`로 선택합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-4.png)

4. 키패어(로그인)에서 `키페어 생성`을 클릭합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-5.png)

5. 키패어 생성 탭에서 키페어 이름을 `teslamate`로 생성합니다. 키페어 이름은 다른것으로 해도 되고 기존에 사용하던 키패어를 사용해도 됩니다. 키 패어 생성을 클릭하면 `teslamate.pem` 파일이 다운로드 됩니다. 이 파일은 나중에 SSH로 접속할 때 사용됩니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-6.png)

6. 원하는 스토리지 크기를 설정합니다. (추천: 최소 30GB)

![](/images/teslamateAwsEc2/teslamateAwsEc2-7.png)

7. `인스턴스 시작`을 클릭하면 인스턴스가 생성 됩니다.

## 인스턴스 포트 설정

![](/images/teslamateAwsEc2/teslamateAwsEc2-9.png)

1. 인스턴스의 디테일 페이지로 이동합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-11.png)

2. 디테일 페이지 아래쪽 보안탭에서 보안그룹 디테일페이지로 이동합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-12.png)

3. 보안그룹 디테일 페이지 아래의 `인바운드 규칙 편집`을 클릭합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-13.png)

4. 인바운드 규칙에서 `규칙 추가`를 두 번 클릭합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-14.png)

5. 포트 범위는 각각 3000, 4000으로 설정하고 소스는 Anywhere-IPv4로 설정합니다. 그리고 `규칙 저장`을 클릭합니다.

## 인스턴스 접속

```sh
chmod 400 teslamate.pem
```

1. 키패어 생성에서 다운로드 받은 `teslamate.pem` 파일의 권한을 변경합니다. 해당 파일의 위치로 이동하여 위 명령어를 실행합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-9.png)

2. 인스턴스 디테일 페이지로 이동합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-10.png)

3. 복사 아이콘을 클릭하여 해당 인스턴스의 ipv4 퍼블릭 IP를 복사합니다.

```sh
ssh -i "teslamate.pem" ubuntu@<퍼블릭 IP>
```

4. 위 명령어를 실행하여 인스턴스에 접속합니다. 퍼블릭 IP는 위에서 복사한 퍼블릭 IP로 대체합니다. `yes`를 입력하고 엔터를 누르면 접속이 됩니다.

## Docker, Docker Compose 설치

```sh
cat > setup_docker_and_compose_arm.sh << EOF
#!/bin/bash

# Check if the script is running with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

# Update package lists
apt-get update

# Install required dependencies
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository for ARM64 (aarch64)
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

# Update package lists (again) with the new repository
apt-get update

# Install Docker
apt-get install -y docker-ce

# Add the current user to the 'docker' group to run Docker without sudo
usermod -aG docker $USER

# Enable and start the Docker service
systemctl enable docker
systemctl start docker

# Output Docker version
docker --version

# Install docker-compose
echo 'move /usr/bin'
cd /usr/bin

echo 'install docker-compose'
wget https://github.com/linuxserver/docker-docker-compose/releases/download/1.29.2-ls51/docker-compose-arm64

# docker-compose 이름으로 명명
echo 'rename docker-compose-arm64 to docker-compose'
mv docker-compose-arm64 docker-compose

# 실행 권한 부여
echo 'grant execute permission'
chmod +x docker-compose

# 심볼릭 링크 설정
# /usr/bin/docker-compose를 삭제하면 자동적으로 심볼릭 링크도 삭제됨
echo 'set symbolic link'
ln -s /usr/bin/docker-compose /usr/local/bin

# 설치 확인
echo 'check docker-compose version'
docker-compose --version

# Done!
echo "Docker and docker-compose have been successfully installed and configured."
EOF
```

1. 위 코드를 그대로 복사하여 터미널에 붙여넣기 하면 `setup_docker_and_compose_arm.sh` 파일이 생성됩니다.

```sh
sudo bash setup_docker_and_compose_arm.sh
```

2. `setup_docker_and_compose_arm.sh` 파일을 실행하여 도커 컴포즈를 설치합니다.

```sh
sudo chmod 777 /var/run/docker.sock
```

3. Docker의 권한 문제로 인해 위 명령어를 실행하여 권한을 부여합니다.

## TeslaMate 설치

```sh
mkdir teslamate
```

1. `teslamate` 폴더를 생성합니다.

```sh
cd teslamate
```

2. `teslamate` 폴더로 이동합니다.

```sh
cat > docker-compose.yml << EOF
version: "3"

services:
  teslamate:
    image: teslamate/teslamate:latest
    restart: always
    environment:
      - ENCRYPTION_KEY=tTes@#mastejdksa
      - DATABASE_USER=teslamate
      - DATABASE_PASS=secret
      - DATABASE_NAME=teslamate
      - DATABASE_HOST=database
      - MQTT_HOST=mosquitto
    ports:
      - 4000:4000
    volumes:
      - ./import:/opt/app/import
    depends_on:
      - database
    cap_drop:
      - all

  database:
    image: postgres:15
    restart: always
    environment:
      - POSTGRES_USER=teslamate
      - POSTGRES_PASSWORD=secret
      - POSTGRES_DB=teslamate
    ports:
      - 5432:5432
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
    image: eclipse-mosquitto:1.6
    restart: always
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

3. 위 코드를 그대로 복사하여 터미널에 붙여넣기 하면 `teslamate`폴더 안에 `docker-compose.yml` 파일이 생성됩니다.

```sh
docker-compose up -d
```

4. `docker-compose.yml` 파일을 실행하여 TeslaMate를 설치 후 실행합니다.

## Teslamate 설정

```
http://<퍼블릭 IP>:3000
```

위 주소를 통해 TeslaMate에 접속합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-17.png)

위와 같은 화면이 나오면 정상적으로 설치가 완료된 것입니다. teslamate에서는 Tesla API의 `access token`과 `refresh token`이 필요합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-18.png)

아이폰의 경우 `Auth for Tesla`앱에서 `access token`과 `refresh token`을 확인할 수 있습니다. 두 개의 토큰을 복사하여 위 화면에 붙여넣기 합니다. (안드로이드의 경우 `Tesla Tokens`앱을 사용합니다.)

![](/images/teslamateAwsEc2/teslamateAwsEc2-19.png)
토큰을 입력하면 위와같이 차량 리스트들이 나옵니다. 차량이 온라인 상태면 바로 지도에 위치가 나오는데 차량이 슬립상태이면 절전상태 표시만 뜨게됩니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-15.png)

위 화면에서 `admin` / `admin`으로 로그인합니다.

![](/images/teslamateAwsEc2/teslamateAwsEc2-16.png)

위 화면이 시작되는데 새로운 비밀번호를 설정합니다.

추후 차량을 움직이거나 충전하게 되면 데이터가 수집되고 시각화됩니다.

## 주의사항

teslamate의 서버는 최소 1gb램을 필요로 합니다. t4g.nano 인스턴스는 0.5gb램이기 때문에 t4g.nano 인스턴스에서는 teslamate를 실행할 수 없습니다. 낮은 램을 사용하게되면 설치는 되지만 도커 중 teslamate가 무한 재부팅 됩니다. 4000번 포트로 접속 시 `502 Bad Gateway` 에러가 발생하면 램이 부족한 것이니 인스턴스를 변경하거나 램을 늘려야 합니다.

## 마무리

이제 AWS 인스턴스에서 TeslaMate를 성공적으로 설치하였습니다. Tesla 차량의 데이터를 수집하고 시각화하여 차량 성능 및 사용 정보를 쉽게 파악할 수 있습니다. 추가적인 설정 및 기능 확장을 위해서는 TeslaMate 문서를 참조하세요.

레퍼럴코드: [https://www.tesla.com/ko_kr/referral/jungwon51749](https://www.tesla.com/ko_kr/referral/jungwon51749)
