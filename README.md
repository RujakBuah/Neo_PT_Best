# PT Best

A Flutter mobile application connecting workers with job opportunities, built with Clean Architecture and Supabase as the backend.

---

## Tech Stack

- **Flutter** — UI framework
- **Supabase** — Authentication & database (PostgreSQL)
- **flutter_bloc** — State management
- **get_it** — Dependency injection / service locator
- **fpdart** — Functional programming utilities (`Either`, `Option`)

---

## Architecture

The project follows **Clean Architecture** with a feature-first folder structure:

```
lib/
├── core/
│   ├── common/          # Shared entities & widgets (User, Loader)
│   ├── error/           # Failures & Exceptions
│   ├── theme/           # AppTheme, AppPalette
│   ├── usecase/         # Base UseCase interface
│   └── utils/           # Helpers (showSnackBar, etc.)
├── features/
│   └── auth/
│       ├── data/        # Models, remote data sources, repository impl
│       ├── domain/      # Entities, repository interface, use cases
│       └── presentation/ # BLoC, pages, widgets
└── init_dependencies.dart  # GetIt service locator setup
```

Each feature layer has a clear responsibility:
- **Data** — talks to Supabase, maps raw JSON to models
- **Domain** — pure Dart; defines use cases and repository contracts
- **Presentation** — BLoC events/states, Flutter UI

---

## Features

- [x] User Sign Up (email & password)
- [x] User Login
- [x] Persistent session — auto-login on app launch via `currentUser`
- [ ] Home / Dashboard *(coming soon)*

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- A [Supabase](https://supabase.com) project

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-org/pt_best.git
   cd pt_best
   ```

2. **Add your Supabase credentials**

   Create `lib/core/secrets/app_secrets.dart`:
   ```dart
   abstract final class AppSecrets {
     static const String supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```

3. **Set up the `profiles` table in Supabase**

   ```sql
   create table profiles (
     id uuid references auth.users on delete cascade primary key,
     name text not null,
     email text
   );
   ```

4. **Install dependencies & run**
   ```bash
   flutter pub get
   flutter run
   ```

---

## State Management

Authentication state is managed by `AuthBloc`:

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

---

## Contributing

Pull requests are welcome. Please follow the existing architecture patterns and keep layers decoupled.

---

*This README is a work in progress and will be updated as the project grows.*