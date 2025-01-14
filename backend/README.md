# Backend API

A FastAPI backend with PostgreSQL database and Alembic migrations.

## Project Structure

```
backend/
├── alembic/              # Database migrations
├── app/                  # Application package
│   ├── api/             # API routes
│   ├── core/            # Core modules (config, security, etc.)
│   ├── db/              # Database models and sessions
│   ├── schemas/         # Pydantic models
│   └── services/        # Business logic
├── tests/               # Test files
├── alembic.ini          # Alembic configuration
├── .env                 # Environment variables
└── README.md           # Project documentation
```

## Setup

1. Install dependencies:
```bash
poetry install
```

2. Activate virtual environment:
```bash
poetry shell
```

3. Create .env file with database configuration:
```
DATABASE_URL=postgresql://user:password@localhost:5432/db_name
```

4. Run migrations:
```bash
alembic upgrade head
```

5. Start the server:
```bash
uvicorn app.main:app --reload
```

## Development

- API documentation available at: http://localhost:8000/docs
- ReDoc documentation at: http://localhost:8000/redoc

<!-- Testing  -->
