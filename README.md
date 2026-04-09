# PT Best

A Flutter mobile application connecting workers with job opportunities. Users can browse available jobs, apply for them, and post new ones. Built with Clean Architecture and Supabase as the backend.

---

## Tech Stack

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management (BLoC + Cubit) |
| `supabase_flutter` | Auth & PostgreSQL database |
| `get_it` | Dependency injection / service locator |
| `fpdart` | Functional error handling (`Either`) |
| `go_router` | Declarative routing with auth redirect |
| `uuid` | UUID generation for job IDs |
| `intl` | Currency & date formatting (Indonesian Rupiah) |

---

## Architecture

The project follows **Clean Architecture** with a feature-first folder structure:

```
lib/
├── core/
│   ├── common/
│   │   ├── cubit/         # AppUserCubit — global auth state
│   │   ├── entities/      # User, Job (pure Dart)
│   │   └── widgets/       # Loader, MainShell (bottom nav)
│   ├── constants/         # Job types, icons, colors
│   ├── error/             # Failure, ServerException
│   ├── router/            # GoRouter with auth redirect guard
│   ├── theme/             # AppTheme, AppPalette
│   ├── usecase/           # Base UseCase interface, NoParams
│   └── utils/             # showSnackBar, formatAsCurrency, timeAgo
├── features/
│   ├── auth/
│   │   ├── data/          # UserModel, AuthRemoteDataSourceImpl, AuthRepositoryImpl
│   │   ├── domain/        # AuthRepository (interface), UserSignUp, UserLogin, CurrentUser
│   │   └── presentation/  # AuthBloc, LoginPage, SignupPage, widgets
│   └── jobs/
│       ├── data/          # JobModel, JobRemoteDataSourceImpl, JobRepositoryImpl
│       ├── domain/        # JobRepository (interface), AddJob, GetJob, ApplyForJob
│       └── presentation/  # JobBloc, JobListingPage, AddJobPage, JobInfoPage, widgets
└── init_dependencies.dart  # GetIt wiring for all layers
```

Each layer has a clear responsibility:
- **Data** — talks to Supabase, maps raw JSON to models
- **Domain** — pure Dart; defines use cases and repository contracts
- **Presentation** — BLoC events/states, Flutter UI

---

## Features

- [x] User Sign Up (email, password, name)
- [x] User Login
- [x] Persistent session — auto-login on app launch via `currentUser`
- [x] Auth redirect guard — unauthenticated users sent to `/login`
- [x] Job listing — browse all unassigned available jobs
- [x] Job cards — shows payout (Rp), company, type badge, posted by, deadline
- [x] Apply for a job — assigns the current user to a job
- [x] Post a new job — supports Delivery (with pickup/dropoff), Cleaning, and Repair types
- [x] Job info page — detailed view of a single job
- [x] Orders page — view your own active/completed jobs 

---

## Routing

| Route | Page | Auth Required |
|---|---|---|
| `/login` | `LoginPage` / `SignupPage` | No |
| `/` | `JobListingPage` | Yes |
| `/orders` | `OrderPage` | Yes |
| `/add-job` | `AddJobPage` | Yes |
| `/job-info` | `JobInfoPage` | Yes |

Navigation uses `go_router` with a redirect guard that checks `AppUserCubit` state on every route change.

---

## State Management

### AuthBloc

| Event | Description |
|---|---|
| `AuthIsUserLoggedIn` | Checks for an existing session on app start |
| `AuthSignUp` | Registers a new user |
| `AuthLogin` | Signs in an existing user |

| State | Description |
|---|---|
| `AuthInitial` | Default startup state |
| `AuthLoading` | Async operation in progress |
| `AuthSuccess` | Authenticated — carries the `User` entity |
| `AuthFailure` | Error — carries a message string |

### JobBloc

| Event | Description |
|---|---|
| `JobFetchAllJobs` | Loads all jobs from Supabase |
| `JobUpload` | Posts a new job |
| `JobApply` | Assigns the current user to a job |

| State | Description |
|---|---|
| `JobInitial` | Default state |
| `JobLoading` | Async operation in progress |
| `JobDisplaySuccess` | Carries `List<Job>` for rendering |
| `JobUploadSuccess` | Job posted successfully |
| `JobApplySuccess` | Application submitted successfully |
| `JobFailure` | Error — carries a message string |

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.10.1`
- A [Supabase](https://supabase.com) project

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-org/pt_best.git
   cd pt_best
   ```

2. **Add your Supabase credentials**

   Create `lib/core/secrets/app_secrets.dart` (gitignored):
   ```dart
   abstract final class AppSecrets {
     static const String supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```

3. **Set up Supabase tables**

   ```sql
   -- User profiles (linked to Supabase Auth)
   create table profiles (
     id uuid references auth.users on delete cascade primary key,
     name text not null,
     email text
   );

   -- Jobs
   create table jobs (
     id uuid primary key,
     created_at timestamptz not null,
     title text not null,
     description text not null,
     payout int not null,
     job_type text not null,
     posted_by uuid references profiles(id),
     assigned_to uuid references profiles(id),
     company_name text not null,
     pickup_location text,
     dropoff_location text,
     status text not null default 'pending',
     complete_by timestamptz not null
   );
   ```

4. **Install dependencies & run**
   ```bash
   flutter pub get
   flutter run
   ```

---

## Contributing

Pull requests are welcome. Please follow the existing Clean Architecture patterns and keep layers decoupled.

---

*This README is a work in progress and will be updated as the project grows.*