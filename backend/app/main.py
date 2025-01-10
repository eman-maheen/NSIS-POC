from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.api import api_router

app = FastAPI(
    title="Backend API",
    description="FastAPI Backend with PostgreSQL",
    version="1.0.0"
)

# CORS middleware configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_router)

@app.get("/")
async def root():
    return {"message": "Welcome to the API"}
