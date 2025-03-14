# CLA Learning Portal API

## Overview
The CLA Learning Portal API is a backend service built with Ruby on Rails to support the CLA Learning Portal. This API facilitates user authentication, course management, assignments, and progress tracking for students, facilitators, and administrators.

## Features
- User authentication (JWT-based authentication)
- Role-based access control (Students, Facilitators, Admins)
- Course and cohort management
- Assignment creation and submission tracking
- Live class scheduling and notifications
- Reporting and progress tracking

## Installation
### Prerequisites
Ensure you have the following installed:
- Ruby (>= 3.0)
- Rails (>= 7.0)
- PostgreSQL
- Redis (for background jobs, if required)
- Bundler

### Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/cla-learning-api.git
   cd cla-learning-api
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Configure database:
   ```sh
   rails db:create db:migrate db:seed
   ```
4. Start the server:
   ```sh
   rails server
   ```

## API Endpoints
### Authentication
- `POST /api/v1/signup` - Register a new user
- `POST /api/v1/login` - Authenticate user and return a token
- `POST /api/v1/logout` - Log out the current user

### Course Management
- `GET /api/v1/courses` - Fetch all courses
- `POST /api/v1/courses` - Create a new course (Admin/Facilitator only)
- `PUT /api/v1/courses/:id` - Update course details
- `DELETE /api/v1/courses/:id` - Remove a course (Admin only)

### Assignments
- `GET /api/v1/assignments` - List all assignments
- `POST /api/v1/assignments` - Create an assignment (Facilitator only)
- `POST /api/v1/assignments/:id/submit` - Submit an assignment (Student only)

## Environment Variables
Create a `.env` file and configure the following:
```
DATABASE_URL=postgres://user:password@localhost:5432/cla_learning_db
SECRET_KEY_BASE=your_secret_key
REDIS_URL=redis://localhost:6379/0
```

## Deployment
### Docker
1. Build and run the container:
   ```sh
   docker-compose up --build
   ```

### Heroku
1. Deploy the app:
   ```sh
   git push heroku main
   heroku run rails db:migrate
   ```

## Testing
Run the test suite using:
```sh
rspec
```

## Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature-name`)
3. Commit changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Create a Pull Request

## License
This project is licensed under the MIT License.

