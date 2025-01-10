from pydantic import BaseModel, EmailStr
from datetime import date, datetime
from typing import Optional

class UserBase(BaseModel):
    name: str
    age: int
    email: EmailStr
    birth_date: date
    gender: str
    is_student: bool = False

class UserCreate(UserBase):
    pass

class UserUpdate(UserBase):
    pass

class UserInDBBase(UserBase):
    id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class User(UserInDBBase):
    pass

class UserInDB(UserInDBBase):
    hashed_password: str
