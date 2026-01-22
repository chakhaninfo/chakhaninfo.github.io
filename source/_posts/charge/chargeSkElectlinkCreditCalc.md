---
title: SK일렉링크 크레딧 계산기 - 신한EV, 삼성iDeV 카드 할인 완벽 활용법
date: 2024-04-02 08:00:00
index_img: /images/chargeSkElectlinkCreditCalc/thumbnail.jpg
description: SK일렉링크 충전 크레딧 구매 시 신한EV, 삼성iDeV 카드의 복잡한 할인율을 쉽게 계산해주는 계산기입니다. 카드별 월 할인 한도를 확인하고, 5% 추가 할인을 포함한 최적의 크레딧 구매 금액을 찾아 전기차 충전 비용을 절약하는 방법을 알아보세요.
tags:
  - 전기차
  - 전기차 충전
  - SK일렉링크
  - skelectlink
  - 충전 크레딧
  - 크레딧 계산기
  - 신한EV카드
  - 삼성iDeV카드
  - 충전카드 할인
  - 충전비 절약
  - 알뜰 팁
category:
  - Charge
---

전기차 오너라면 매달 지출되는 충전 비용을 어떻게 하면 더 아낄 수 있을지 항상 고민하게 됩니다. 특히 **SK일렉링크(skelectlink)** 충전기를 자주 이용하신다면, '크레딧 충전'과 '신용카드 할인'을 동시에 활용하는 것이 중요한 절약 포인트입니다.

SK일렉링크는 크레딧을 미리 충전할 때 **5% 추가 할인** 혜택을 제공하는데, 여기에 `신한EV`나 `삼성 iD EV` 카드 같은 충전 할인 카드의 혜택을 더하면 할인 효과를 극대화할 수 있습니다. 하지만 매월 달라지는 카드 할인 한도 때문에 최적의 충전 금액을 계산하기가 번거롭습니다.

이 글에서는 여러분의 고민을 덜어드리기 위해, 남은 카드 할인 한도와 할인율만 입력하면 최적의 크레딧 구매 금액을 바로 알려주는 **'SK일렉링크 크레딧 계산기'**를 준비했습니다.

## SK일렉링크 크레딧 최적 구매가 계산기

아래 계산기에 현재 사용 중인 카드의 **'잔여 할인 금액'**과 **'할인율'**을 입력해 보세요. 5% 추가 할인을 고려하여 최적으로 구매해야 할 크레딧 금액을 즉시 계산해 드립니다.

계산된 `크레딧 구매 가격`을 아래 사진처럼 SK일렉링크 앱에서 '직접입력'하여 구매하시면 됩니다.

![SK일렉링크 앱에서 크레딧 직접 입력하여 구매하는 화면](/images/chargeSkElectlinkCreditCalc/chargeSkElectlinkCreditCalc-1.jpeg "SK일렉링크 크레딧 구매 화면")

### 계산기 입력

<script type="text/javascript">
function roundToNearest100(num) {
  return Math.floor(num / 100) * 100;
}

function addCommasToNumber(number) {
    if (!isFinite(number)) {
        return '';
    }
    let numString = String(number);
    let parts = numString.split('.');
    let integerPart = parts[0];
    let decimalPart = parts[1] || '';
    integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    return integerPart + (decimalPart ? '.' + decimalPart : '') + '원';
}

function calculateDiscount() {
    var discountedPrice = parseFloat(document.getElementById('discount-price').value) || 0;
    var discountRate = parseFloat(document.getElementById('discount-rate').value) || 0;

    var buyingPrice = roundToNearest100(discountedPrice / (0.95 * discountRate / 100 ));
    var receivePrice = roundToNearest100(buyingPrice * (75 / 100));
    var realPrice = buyingPrice * 0.95;

    document.getElementById('buying-price').innerText = addCommasToNumber(buyingPrice);
    document.getElementById('buying-price-1').innerText = addCommasToNumber(buyingPrice);
    document.getElementById('receive-price').innerText = addCommasToNumber(receivePrice);
    document.getElementById('real-price').innerText = addCommasToNumber(realPrice);
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

<p><span class="input-label">잔여 할인 금액:</span> <input type="text" id="discount-price" placeholder="예: 30000 또는 20000" oninput="calculateDiscount()"></p>
<p><span class="input-label">카드 할인율(%):</span> <input type="text" id="discount-rate" placeholder="예: 70 또는 50" oninput="calculateDiscount()"></p>

### 계산 결과

<p><span class="input-label">최적 크레딧 구매 가격: </span><span id="buying-price"></span></p>
<p><span class="input-label">실제 카드 결제 금액: </span><span id="real-price"></span></p>

## 주요 충전 할인 카드별 정보

| 할인율  | 카드사/구간        | 월 이용한도 | 월 할인한도 | 최적 충전 시 실제 결제액 |
| :-----: | ------------------ | :---------: | :---------: | :----------------------: |
| **70%** | 삼성 iD EV (2구간) |  42,860원   |  30,000원   |         12,860원         |
| **50%** | 신한 EV (2구간)    |  40,000원   |  20,000원   |         20,000원         |
| **50%** | 삼성 iD EV (1구간) |  40,000원   |  20,000원   |         20,000원         |
| **30%** | 신한 EV (1구간)    |  66,670원   |  20,000원   |         46,670원         |

집밥(자택 충전기)이 SK일렉링크이거나, 고속도로 주행이 잦아 휴게소 충전기를 자주 이용하신다면 매월 초에 카드 할인 한도에 맞춰 크레딧을 충전해두는 것이 가장 효율적인 충전 방법입니다.

![전국 고속도로 휴게소에 설치된 SK일렉링크 급속 충전기](/images/chargeSkElectlinkCreditCalc/chargeSkElectlinkCreditCalc-2.png "SK일렉링크 급속 충전기")

## 남는 크레딧, 판매하여 수익 만들기

만약 계산된 `크레딧 구매 가격`으로 충전 후 크레딧이 남는다면, 온라인 전기차 커뮤니티 장터 등에서 판매하여 부가 수익을 얻을 수도 있습니다.

아래는 현재 시세(구매가의 약 75%)를 기준으로 계산한 예상 판매 금액입니다.

<p><span class="input-label">크레딧 구매 가격: </span><span id="buying-price-1"></span></p>
<p><span class="input-label">예상 판매 금액 (75%): </span><span id="receive-price"></span></p>

개인적으로는 카드 할인율이 50% 이상일 때 충전한 크레딧을 판매하는 것을 추천합니다.

SK일렉링크 크레딧 구매 및 판매에 대한 더 자세한 방법은 [이전 포스트](https://www.chakhan.info/charge/chargeSkElectlinkCredit/)에서 확인하실 수 있습니다.

---

### Tesla 레퍼럴 코드

제 추천 링크를 통해 Tesla 신차를 구매하거나 시승하면 할인 혜택과 무료 슈퍼차징 크레딧을 받을 수 있습니다.

[https://www.tesla.com/ko_kr/referral/jungwon51749](https://www.tesla.com/ko_kr/referral/jungwon51749)
