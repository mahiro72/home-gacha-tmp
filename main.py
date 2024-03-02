from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    openapi_url="/openapi.json",
)

capsule_toy_queue = []

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # すべてのオリジンを許可
    allow_credentials=True,
    allow_methods=["*"],  # すべてのHTTPメソッドを許可
    allow_headers=["*"],  # すべてのHTTPヘッダーを許可
)

@app.get("/health")
def health():
    return {"health": "ok"}

@app.post("/gacha/start")
def gacha_start():
    capsule_toy_queue.append("capsule_toy")
    return {"message":"queue append"}

@app.get("/gacha/draw")
def gacha_draw():
    global capsule_toy_queue
    if len(capsule_toy_queue) == 0:
        raise HTTPException(status_code=400, detail="queueが見つかりません")

    capsule_toy_queue.pop(0)
    return {"message":"queue pop"}

@app.get("/gacha/status")
def gacha_status():
    global capsule_toy_queue
    if len(capsule_toy_queue) == 0:
        raise HTTPException(status_code=400, detail="queueが見つかりません")

    return {"status": "waiting"}
