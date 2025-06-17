# Airbnb Sample Database Project

A sample database project modeling Airbnb-like functionality using Prisma ORM and PostgreSQL.

## 🏗️ Tech Stack

- **Database**: PostgreSQL 15
- **ORM**: Prisma
- **Runtime**: Node.js
- **Containerization**: Docker & Docker Compose

## 📋 Prerequisites

- Node.js (v16 or higher)
- Docker and Docker Compose
- Git

## 🚀 Quick Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd airbnb-sample-db-project
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Start the Database
```bash
docker-compose up -d
```

### 4. Set Environment Variables
Create a `.env` file in the root directory:
```env
DATABASE_URL="postgresql://admin:admin@localhost:5432/staybnb"
```

### 5. Run Database Migrations
```bash
npx prisma migrate dev
```

### 6. Generate Prisma Client
```bash
npx prisma generate
```

## 📊 Database Schema

The database includes the following main entities:

- **User**: User accounts with guest/host capabilities
- **Property**: Listings with details, amenities, and location
- **Amenity**: Property features (Wi-Fi, Pool, etc.)
- **Reservation**: Booking records
- **Review**: Guest reviews tied to specific reservations
- **Picture**: Property images

### Key Relationships
- Users can host multiple properties and make multiple reservations
- Properties belong to hosts and can have multiple reservations/reviews
- Reviews are linked to specific reservations (only guests who booked can review)
- Properties have many-to-many relationships with amenities

## 🛠️ Available Scripts

```bash
# Start the database
docker-compose up -d

# Stop the database
docker-compose down

# View database in Prisma Studio
npx prisma studio

# Reset database and re-run migrations
npx prisma migrate reset

# Generate Prisma client after schema changes
npx prisma generate
```

## 📁 Project Structure

```
airbnb-sample-db-project/
├── prisma/
│   ├── schema.prisma          # Database schema definition
│   ├── migrations/            # Database migration files
│   └── full_schema.sql        # Complete schema SQL
├── generated/                 # Generated Prisma client
├── docker-compose.yml         # PostgreSQL container setup
├── package.json              # Dependencies and scripts
└── README.md                 # This file
```

## 🔧 Development

### Accessing the Database
- **Host**: localhost
- **Port**: 5432
- **Database**: staybnb
- **Username**: admin
- **Password**: admin

### Making Schema Changes
1. Edit `prisma/schema.prisma`
2. Run `npx prisma migrate dev --name your-migration-name`
3. Run `npx prisma generate` to update the client

### Viewing Data
Use Prisma Studio for a web-based database browser:
```bash
npx prisma studio
```

## 🌟 Features

- Complete Airbnb-like data model
- Proper relationships and constraints
- Migration system for schema versioning
- Type-safe database operations with Prisma
- Docker-based PostgreSQL setup

## 📝 Notes

- The generated Prisma client is output to `generated/prisma/` directory
- All migrations are tracked in `prisma/migrations/`
- The database container persists data in a Docker volume 