---
title: sk일렉링크 충전 크레딧 혜택 계산기 (신한ev, 삼성idev 등)
date: 2024-04-02 08:00:00
index_img: /images/chargeSkElectlinkCreditCalc/thumbnail.jpg
tags:
  - 전기차
  - 크레딧
  - 크레딧 판매
  - 크레딧 쌓기
  - 판매
  - 구입
  - 충전
  - 쌓기
  - 신한ev
  - 삼성idev
  - sk일렉링크
  - skelectlink
  - electlink
  - 일렉링크
  - sk
  - 할인한도
  - 할인
category:
  - Charge
---

# sk일렉링크 크레딧

sk일렉링크는 크레딧 충전 시 5% 할인 혜택을 제공합니다.  
따라서 잔여 할인 금액과 할인율을 입력하면 크레딧 구매 가격을 계산 할 수 있습니다.  
계산 된 `크레딧 구매 가격`을 아래 사진처럼 직접 입력하여 구매하시면 됩니다.  
![](/images/chargeSkElectlinkCreditCalc/chargeSkElectlinkCreditCalc-1.jpeg)
sk일렉링크는 고속도로 휴게소 급속 충전기가 많아 미리 크레딧을 구매해두시면 장거리 여행 시 아주 유용합니다.  
![](/images/chargeSkElectlinkCreditCalc/chargeSkElectlinkCreditCalc-2.png)
집밥이 sk일렉링크 충전기라면 카드 할인 계산하며 쓰는 것 보다 매달 초에 크레딧 충전하여 사용하는 것이 좋습니다.

## 카드 별 할인 구간

| 할인율 | 이용한도 | 할인한도 | 실제 결제 금액 | 비고                         |
| ------ | -------- | -------- | -------------- | ---------------------------- |
| 30%    | 66,670원 | 20,000원 | 46,670원       | 신한EV 1구간                 |
| 50%    | 40,000원 | 20,000원 | 20,000원       | 신한EV 2구간, 삼성idev 1구간 |
| 70%    | 42,860원 | 30,000원 | 12,860원       | 삼성idev 2구간               |

## sk일렉링크 크레딧 구매 및 판매 방법

[여기](https://www.chakhan.info/charge/chargeSkElectlinkCredit/)를 클릭하셔서 크레딧 구매 방법을 확인하실 수 있습니다.

## 할인 금액 입력

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

<p><span class="input-label">잔여 할인 금액:</span> <input type="text" id="discount-price" placeholder="잔여 할인 금액 입력(ex: 30000 or 20000)" oninput="calculateDiscount()"></p>
<p><span class="input-label">할인율:</span> <input type="text" id="discount-rate" placeholder="할인율 입력(ex: 70 or 50)" oninput="calculateDiscount()"></p>

## 구매시 할인 계산

<p><span class="input-label">크레딧 구매 가격: </span><span id="buying-price"></span></p>
<p><span class="input-label">실제 구매 가격: </span><span id="real-price"></span></p>

## 판매시 할인 계산

판매 시 받을 가격은 현재 시세가 구매 가격의 75%로 책정되어 계산하였습니다.  
크레딧이 이미 많다면 카페 장터에 크레딧을 판매하여 일부를 수익으로 만들 수 있습니다.  
개인적으로 50~70% 할인 가능한 금액이 남아있을 경우에만 판매하는 것을 추천합니다.

<p><span class="input-label">크레딧 구매 가격: </span><span id="buying-price-1"></span></p>
<p><span class="input-label">판매 시 받을 가격<br>(크레딧 구매 가격의 75%): </span><span id="receive-price"></span></p>

레퍼럴코드: [https://www.tesla.com/ko_kr/referral/jungwon51749](https://www.tesla.com/ko_kr/referral/jungwon51749)
