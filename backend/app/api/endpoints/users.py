from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.schemas.user import UserCreate, User
from app.db.models import User as UserModel

router = APIRouter()

@router.post("/users/", response_model=User)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    try:
        db_user = UserModel(
            name=user.name,
            age=user.age,
            email=user.email,
            birth_date=user.birth_date,
            gender=user.gender,
            is_student=user.is_student
        )
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
