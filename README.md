# iOS_VariousFuncAPP

# 음악,게임,웹 기능 가진 어플입니다
---
## 목차
1. [실행화면](#실행화면)

- [앱 아이콘](#앱-아이콘)
- [실행 화면](#실행-화면)
- [홈 화면](#홈-화면)
- [게임 화면](#게임-화면)
- [영상 뷰](#영상-뷰)
- [음악 플레이어](#음악-플레이어)
- [웹 페이지](#웹-페이지)

2. [특징](#특징)

- [뷰 전환](#뷰 전환)
- [API](#API)
- [포인트 처리](#포인트 처리)
- [썸네일 만들기](#썸네일 만들기)
- [클릭 기능 추가](#클릭 기능 추가)

3. [주의점](#주의점)


---

## 실행화면

### - 앱 아이콘

![앱 아이콘](https://user-images.githubusercontent.com/76652929/126124287-28f3ffbd-00c2-4b8f-81d3-a5d089228ca0.PNG)

### - 실행 화면 

![실행화면](https://user-images.githubusercontent.com/76652929/126124419-e96025ce-028f-4ff0-826d-7bf592222ead.PNG)


### - 홈 화면 

아래는 홈 화면입니다. 각 뷰에 들어가기 위해선 포인트가 필요합니다. 포인트를 얻기 위해선 게임을 통해 얻어야 합니다. 포인트 얻기 버튼을 누르면 게임을 할 수 있는 뷰로 이동합니다.

![홈화면](https://user-images.githubusercontent.com/76652929/126124531-8ef97611-f8e5-4f9b-a441-e10b5098c3ae.PNG) ![홈화면2포인트변화](https://user-images.githubusercontent.com/76652929/126124993-202dc9ef-2b2d-42f0-b09f-e30e8daff90b.PNG) ![홈화면3포인트부족](https://user-images.githubusercontent.com/76652929/126125014-ac26dabf-7c48-4ec9-82c7-5c143435a463.PNG)

### - 게임 화면 

게임 내용은 코인이 있는 방을 예상하는 것입니다.

![게임 화면1](https://user-images.githubusercontent.com/76652929/126125544-f7cbd314-0cb6-4433-b9b8-3f3a864b8fa5.PNG) ![게임화면2](https://user-images.githubusercontent.com/76652929/126125561-c56a182f-f349-48f7-9c72-f4f45823d338.PNG) 
![게임화면3이김](https://user-images.githubusercontent.com/76652929/126126045-c810fbb2-d721-4c99-bc2b-655166d7b94a.PNG) ![게임화면5loose](https://user-images.githubusercontent.com/76652929/126126194-6525cbf1-65e2-425e-ab4f-bbaf92c9a728.PNG)

### - 영상 뷰 

홈 화면을 통해서 들어간 뷰는 다음과 같이 구성 했습니다. 

![서울드라이브화면1](https://user-images.githubusercontent.com/76652929/126143872-c08a9302-b803-45eb-85d8-eb6dacc3f5e7.PNG) ![뉴욕홈화면1](https://user-images.githubusercontent.com/76652929/126143911-f92fbb3f-1eb5-4612-aa75-2e3db775a6fe.PNG)

![도쿄드라이브화면](https://user-images.githubusercontent.com/76652929/126143939-aed74c76-6638-4069-bbf7-74a8af683779.PNG) ![파리드라이브화면](https://user-images.githubusercontent.com/76652929/126143954-f6008738-e2ce-4db9-8e5c-e8b648244fec.PNG)


### - 음악 플레이어

![노래창1](https://user-images.githubusercontent.com/76652929/126144165-4253f9a3-ca67-4927-8f92-768517cdb378.PNG) ![노래창2](https://user-images.githubusercontent.com/76652929/126144249-5e8b17c6-b66f-4ba4-8f31-cddcc44950b8.PNG)

### - 웹 페이지 

![사파리창](https://user-images.githubusercontent.com/76652929/126144582-aca3fd5f-69f9-4de4-a555-b0ef53c20273.PNG)



---

## 특징 

### - API

아래 사이트의 Current Weather Data를 이용했습니다.
( 주소 : https://openweathermap.org/home/sign_up ) 

![api소개1](https://user-images.githubusercontent.com/76652929/126145900-124bfa62-72cf-4c53-a841-bf29bc663a16.PNG)

해당 API 는 아래와 같이 따로 날씨 이미지를 제공하여 이를 이용해서 날씨를 어플 내에 시각적으로 표현했습니다.

<img width="400" alt="스크린샷 2021-07-19 오후 7 25 57" src="https://user-images.githubusercontent.com/76652929/126146637-fc2a4f38-789b-4304-8111-b37c1d88e28d.png">



해당 API는 아래와 같은 JSON구조로 구성되었습니다.

![날씨api](https://user-images.githubusercontent.com/76652929/126145957-7225b4db-b4b9-4aae-98b0-cbb61d8b94b9.PNG)

### - 뷰 전환

아래는 뷰를 불러오는 코드입니다. 

<img width="581" alt="뷰전환1" src="https://user-images.githubusercontent.com/76652929/126151022-b00899cb-b7b9-4882-96f6-08c6da336cb0.png">

아래는 불러와진 뷰를 없애면서 원래 있던 뷰로 돌아가는 코드입니다.


<img width="388" alt="뷰전환뒤로가기" src="https://user-images.githubusercontent.com/76652929/126151027-0e0d3687-e063-4d81-a3fb-780a4f74215b.png">





### - 포인트 처리 
 
아래와 같은 방식으로 기기 내부에 값을 저장하고 꺼내오면서 포인트를 처리해 줬습니다. 
 
<img width="537" alt="포인트처리" src="https://user-images.githubusercontent.com/76652929/126147974-931782b8-9ec3-46fa-b72c-b64689ee6089.png">

아래는 포인트 사용시 코드 입니다.


<img width="972" alt="포인트처리2사용" src="https://user-images.githubusercontent.com/76652929/126150664-830f297e-9bab-4e98-bc78-03e483974003.png">

아래는 게임에서 이겼을 때 포인트 추가해 주는 코드입니다.


<img width="526" alt="포인트처리3적립" src="https://user-images.githubusercontent.com/76652929/126150809-8cd570e1-243f-4aa6-9c11-efc2b4e8bda8.png">





### - 썸네일 만들기 

아래와 같은 방식으로 영상 파일내의 특정 부분(시간)에서 이미지를 뽑아 썸네일을 만듭었습니다. 

<img width="731" alt="썸네일만들기" src="https://user-images.githubusercontent.com/76652929/126148609-faeb23c7-2f2e-4de8-9ea8-44cf423f2d5e.png"> 

### - 클릭 기능 추가 

클릭시 인식을 할 수 있도록 하였고, 이 인식에 함수를 넣어주어 이미지에 클릭 기능을 추가 했습니다. 

<img width="650" alt="기능추가1" src="https://user-images.githubusercontent.com/76652929/126149549-903bcfde-b20c-42eb-a2b2-219db6de89f7.png">
<img width="576" alt="기능추가2" src="https://user-images.githubusercontent.com/76652929/126149554-a139df6e-4ce4-4671-bb4c-1b347b3023a3.png">

---
## 주의점

**미디어 파일은 용량의 관계상 업로드하지 못 했습니다. 따로 추가해 줘야 정상 작동이 됩니다.
그리고 화면을 돌리면 오류가 발생할 수 있으니 돌리지 않은 상태로 사용해야합니다.**






