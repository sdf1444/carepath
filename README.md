# CarePath

CarePath is a portfolio Ruby on Rails application demonstrating a clinician caseload and patient-care workflow. It provides role-aware caseload management, controlled care-pathway transitions, outcome tracking and an auditable history of workflow changes.

> **Portfolio only:** all names and clinical information are synthetic. CarePath is not a medical device, does not provide medical advice or diagnosis, and must not be used with real patient data.

## Stack

Ruby 3.4.10, Rails 8.1.3, Hotwire/Turbo, PostgreSQL, Sidekiq/Redis, RSpec, Docker and GitHub Actions.

## Features

- Clinician, clinical-lead and admin roles
- Clinician-specific caseload dashboard
- Patient search and stage filtering
- Server-enforced pathway: Referral → Assessment → Treatment → Review → Treatment/Discharged
- Transactional transition service with authorisation and optimistic locking
- Immutable transition audit records
- Synthetic outcome history
- Overdue-action background job
- RSpec service/model/job tests
- Docker Compose development environment and CI workflow

## Run with Docker

```bash
docker compose build
docker compose up
```

Then visit `http://localhost:3000`. On first boot the database is prepared; seed it once with:

```bash
docker compose exec web bin/rails db:seed
```

Demo credentials:

- Clinician: `clinician@example.test` / `password123`
- Clinical lead: `lead@example.test` / `password123`
- Admin: `admin@example.test` / `password123`

## Run locally

Requires Ruby 3.4.10, PostgreSQL and Redis.

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

## Tests

```bash
RAILS_ENV=test bin/rails db:prepare
bundle exec rspec
```

## Architecture

Controllers remain thin. `CarePath::Transition` owns the care-path invariant: it checks actor authorisation, validates the requested state transition, locks the patient row, updates the current state and writes the audit event in one database transaction. A failed operation therefore leaves the workflow unchanged.

The application intentionally uses Rails-rendered views with Turbo rather than a separate SPA/API. This keeps a small workflow application cohesive while still providing responsive navigation and form submissions.

## Possible next steps

- Replace the simple session login with a production identity provider
- Add policy objects for broader authorisation rules
- Add Turbo Stream broadcasts for live caseload updates
- Add appointment/reminder delivery adapters
- Add structured audit-event export
- Add accessibility/system tests
- Add Terraform and an AWS deployment pipeline

## Licence

MIT — demonstration/portfolio use only.
