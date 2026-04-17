# 🧴 2025 TAB PROJECT: RE-Skin(AI) by. 42기 이신비

### Multi-View Facial Skin Analysis AI Server

> 3-view 얼굴 이미지를 기반으로 피부 상태를 정량화하는 AI 분석 엔진
> (Acne · Wrinkle · Pores · Lip Dryness)

---

## 1️⃣ Project Motivation

사용자의 피부 상태 진단을 통한 화장품 추천 서비스에서 가장 중요한 것은 “사용자 피부 상태의 정량화”라고 생각한다.
하지만 기존의 설문 기반 피부 진단은 주관적이며, 이미지 기반 피부 분석은 항목별 세분화가 부족한 경우가 많다.

RE-Skin AI는 다음을 목표로 개발되었다.
* 3-view 이미지 기반 정밀 분석
* 항목별 severity score (0.0 ~ 1.0) 정량화
* Backend와 분리된 독립 AI 서버 구조
* GPU 없는 환경에서도 실행 가능

---

## 2️⃣ What This Project Solves

| 문제               | 해결 방식               |
| ---------------- | ------------------- |
| 단일 이미지 기반 분석의 한계 | 정면 + 좌/우 3-view 분석  |
| 정성적 결과 제공        | 0~1 범위 정량화 severity |
| GPU 의존 서버 구조     | CPU 강제 실행 지원        |
| Backend-AI 결합 구조 | REST 기반 분리 아키텍처     |

---

## 3️⃣ System Architecture

```
Client (Frontend)
        ↓
Backend (Spring Boot)
        ↓
AI Server (FastAPI)
        ↓
Model / CV Pipeline
```

### ✔ 설계 의도

* AI 서버를 독립 프로세스로 분리
* Backend는 HTTP 호출만 수행
* 확장/교체/스케일링 용이한 구조
* 향후 Docker 배포 고려 설계

---

## 4️⃣ Core Features

### 🔹 1. Acne Classification (Deep Learning)

* ResNet50 기반 분류 모델
* 3-class prediction:

  * acne
  * pimple
  * spot
* Softmax 확률 기반 가중합 severity 계산

```text
severity = 1.0 * p_acne
         + 0.6 * p_pimple
         + 0.3 * p_spot
```

→ 단순 분류가 아닌 **정량화 점수 설계**

---

### 🔹 2. Wrinkle Detection (Landmark + Edge 기반)

* Mediapipe FaceMesh
* ROI 추출
* Canny Edge 기반 주름 패턴 비율 계산

→ ML 모델 없이도 robust한 규칙 기반 분석

---

### 🔹 3. Pores Detection (Image Processing Pipeline)

* Median Blur
* CLAHE
* Adaptive Threshold
* Skin Masking (YCrCb)

→ 모공 후보 영역 비율을 severity로 변환

---

### 🔹 4. Lip Dryness Analysis

* FaceMesh Lips 영역 추출
* 밝은 픽셀 비율 기반 건조도 계산

---

## 5️⃣ Technical Stack

* Python 3.10
* FastAPI
* PyTorch
* OpenCV
* Mediapipe
* Uvicorn

---

## 6️⃣ Engineering Highlights 

### 1. CPU/GPU 동적 디바이스 선택 구현

```bash
RESKIN_DEVICE=cpu
RESKIN_DEVICE=cuda
```

* GPU 없는 백엔드 개발 환경 대응
* 추론 환경 분리 설계

---

### 2. Multi-view Aggregation

각 항목은

```json
{
  "front": {...},
  "left": {...},
  "right": {...},
  "overall_severity": 0.0
}
```

→ 단일 이미지가 아닌 평균 기반 종합 판단

---

### 3. 명확한 API Contract 설계

* Swagger 자동 문서화
* 명확한 JSON 응답 구조
* Severity 해석 기준 정의

📄 API 상세 명세:
👉 **[API Specification 보기](./API.md)**

---

### 4. 실행 문서 분리

로컬 실행 방법은 별도 문서로 분리(아래 참조)

👉 **[Quick Start Guide](./quickstart.md)**


👉 **[requirements.txt](./requirement.txt)**

---

## 7️⃣ Example Response

```json
{
  "acne": {
    "overall_severity": 0.77
  },
  "wrinkle": {
    "overall_severity": 0.35
  },
  "pores": {
    "overall_severity": 0.08
  },
  "lip_dryness": {
    "overall_severity": 0.01
  }
}
```

---

## 8️⃣ Performance & Scalability Considerations

* CPU fallback 가능
* Backend와 분리된 구조 → Horizontal Scaling 가능
* 향후
  * 비동기 처리 최적화
  * Batch inference 지원
  * Dockerization 예정

---

## 9️⃣ Lessons Learned

이 프로젝트를 통해서..
* AI 모델과 규칙 기반 CV를 혼합하는 설계 경험
* Backend와 협업을 고려한 API 설계 경험
* 환경 의존성 문제(GPU) 해결 경험
* 문서화의 중요성 체감
* AI 시스템을 “서비스 형태”로 설계하는 사고 확장

---

## 🔟 Future Improvements

* 모델 고도화 (Transformer 기반 acne detection)
* Segmentation 기반 정밀 모공 검출
* 비동기 처리 최적화
* Docker + CI/CD 구축
* 실제 사용자 데이터 기반 재학습

---

