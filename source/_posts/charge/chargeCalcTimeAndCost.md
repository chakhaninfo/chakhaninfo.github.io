---
title: 전기차 충전 시간, 금액 계산기
date: 2024-03-31 08:00:00
index_img: /images/chargeCalcTimeAndCost/thumbnail.jpg
tags:
  - tesla
  - 테슬라
  - 모델y
  - 모델3
  - modely
  - model3
  - models
  - modelx
  - 현대
  - 코나
  - 니로
  - 아이오닉
  - 아이오닉5
  - 아이오닉6
  - 기아
  - ev6
  - ev9
  - 폴스타
  - 폴스타2
  - bmw
  - i3
  - i4
  - i5
  - i7
  - ix
  - ix1
  - ix3
  - ix5
  - benz
  - 벤츠
  - eqa
  - eqb
  - eqe
  - eqs
  - eqg
  - 아우디
  - q4 e-tron
  - q8 e-tron
  - 이트론
  - e-tron
  - 포르쉐
  - taycan
  - 타이칸
  - 폭스바겐
  - id4
  - 험머
  - 전기차
  - 충전
  - 시간
  - 계산
  - 금액
  - 급속
  - 완속
  - 충전기
  - 배터리
  - 용량
  - 충전량
  - 충전량 계산
  - 충전기 속도
  - 충전 시간
  - 충전 금액
  - 충전 시간 계산
  - 충전 금액 계산
  - 충전 시간 계산기
  - 충전 금액 계산기
  - calc
  - calculator
  - cost
  - referral
  - 레퍼럴
category:
  - Charge
---

## 차종 별 배터리 용량

차종별 배터리 용량은 다르고 차량 종류도 300여대 이상으로 다양합니다.  
[여기](https://ev-database.org/)는 `ev-database`라는 사이트인데 왠만한 전기차 정보가 있습니다.  
참고하시면 좋을 것 같습니다.  
제가 타는 `테슬라 모델Y Long Range`의 사용 가능한 배터리 용량은 `75kWh`입니다.

## 계산기 사용 방법

`배터리 용량(kWh)`에는 차종별 배터리 용량을 입력하시면 됩니다.  
`충전기 속도(kW)`는 충전기의 속도를 입력하시면 됩니다. (급속, 완속 충전기 속도 7kW, 22kW, 50kW, 100kW, 150kW, 350kW 등)  
`충전 퍼센트(%)`는 충전하고 싶은 배터리 용량의 퍼센트를 입력하시면 됩니다.  
`kW당 금액(원)`은 전기요금을 입력하시면 됩니다. (전기요금은 1kWh당 200원, 350원 등)

<script type="text/javascript">
function calculateChargingTime() {
    // 입력값 가져오기
    var batteryCapacity = parseFloat(document.getElementById("batteryCapacity").value); // 배터리 용량(kWh)
    var chargerSpeed = parseFloat(document.getElementById("chargerSpeed").value); // 충전기 속도(kW)
    var percent = parseFloat(document.getElementById("percent").value); // 충전 퍼센트
    var kwPerWon = parseFloat(document.getElementById("kwPerWon").value); // kW당 금액(원)
    var chargingBatteryCapacity = batteryCapacity * percent / 100;
    // 시간 계산
    function chargingTime(chargingBatteryCapacity, chargerSpeed) {
      if(!isFinite(chargingBatteryCapacity / chargerSpeed)) {
        return '';
      }
      var chargingTimeHours = Math.floor(chargingBatteryCapacity / chargerSpeed);
      var chargingTimeMinutes = Math.round((chargingBatteryCapacity / chargerSpeed - chargingTimeHours) * 60);
      return chargingTimeHours + " 시간 " + chargingTimeMinutes + " 분";
    }

    function calculateChargingCost(chargingBatteryCapacity, kwPerWon) {
        if(!isFinite(chargingBatteryCapacity * kwPerWon)) {
          return '';
        }
        return chargingBatteryCapacity * kwPerWon + " 원";
    }

    // 결과 표시
    document.getElementById("result").innerHTML = chargingTime(chargingBatteryCapacity, chargerSpeed)
    document.getElementById("chargingCost").innerHTML = calculateChargingCost(chargingBatteryCapacity, kwPerWon);
}
</script>
<style>
    .input-label {
        width: 200px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
    p > input {
        display: inline-block;
        width: 300px;
        margin-right: 10px;
    }
</style>
<p><span class="input-label">배터리 용량(kWh): </span><input type="number" id="batteryCapacity" oninput="calculateChargingTime()"></p>
<p><span class="input-label">충전기 속도(kW): </span><input type="number" id="chargerSpeed" oninput="calculateChargingTime()"></p>
<p><span class="input-label">충전 퍼센트(%): </span><input type="number" id="percent" oninput="calculateChargingTime()"></p>
<p><span class="input-label">kW당 금액(원): </span><input type="number" id="kwPerWon" oninput="calculateChargingTime()"></p>

<p><span class="input-label">충전에 걸리는 시간: </span><span id="result"></span></p>
<p><span class="input-label">충전 금액: </span><span id="chargingCost"></span></p>

위 충전기는 `충전손실`과 `배터리 히팅`을 고려하지 않았습니다.  
충전기 속도가 빠를수록 충전 시간이 짧아지고, kW당 금액이 낮을수록 충전 금액이 적어집니다.  
<br>
레퍼럴코드: [https://www.tesla.com/ko_kr/referral/jungwon51749](https://www.tesla.com/ko_kr/referral/jungwon51749)
