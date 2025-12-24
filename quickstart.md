## Quick Start (로컬 실행 / 백엔드 확인용)

### 1. 환경 준비
```bash
# Python 3.10 권장
conda create -n reskin-ai python=3.10 -y
conda activate reskin-ai

pip install -r requirements.txt
2. 서버 실행
CPU 강제 실행 (GPU 없는 환경에서도 가능)
bash
코드 복사
RESKIN_DEVICE=cpu python -m uvicorn api.app:app --reload
GPU 사용 (가능한 환경)
bash
코드 복사
RESKIN_DEVICE=cuda python -m uvicorn api.app:app --reload
3. 테스트
Swagger UI: http://127.0.0.1:8000/docs

Health check:

bash
코드 복사
curl http://127.0.0.1:8000/api/health
분석 API 테스트:

bash
코드 복사
curl -X POST "http://127.0.0.1:8000/api/skin/analyze" \
  -F "front=@front.jpg" \
  -F "left=@left.jpg" \
  -F "right=@right.jpg"