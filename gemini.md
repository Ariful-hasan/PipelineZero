# System Requirements Specification: AI Job Tracker SaaS

## 1. Vision & Architecture
* **Core:** Multi-tenant backend for a private workflow job tracking platform.
* **Assumption:** No scraping. Users manually save jobs or paste text.
* **Tenant Boundary:** Strict data isolation by `workspace_id`. Cross-tenant leaks must be impossible.

## 2. Access Control & Roles
* **Owner:** Full access, workspace configurations, deletion.
* **Admin:** Full asset management except workspace deletion.
* **Member:** Create, read, update jobs, notes, and tasks.
* **Viewer:** Read-only access to workspace metrics and listings.

## 3. Database Schema (Compressed)
* `users`: `id`, `email`, `password_hash`, `name`, `is_active`, `timestamps`
* `workspaces`: `id`, `name`, `slug`, `owner_user_id`, `timezone`, `timestamps`
* `workspace_members`: `id`, `workspace_id`, `user_id`, `role`, `status`, `joined_at`
* `workspace_invitations`: `id`, `workspace_id`, `email`, `role`, `token`, `status`, `expires_at`
* `job_applications`: `id`, `workspace_id`, `created_by_user_id`, `title`, `company_name`, `source`, `source_url`, `location`, `status`, `salary_min`, `salary_max`, `currency`, `timestamps`, `deleted_at` (soft delete)
* `job_status_history`: `id`, `workspace_id`, `job_application_id`, `from_status`, `to_status`, `changed_by_user_id`, `changed_at`
* `job_notes`: `id`, `workspace_id`, `job_application_id`, `author_user_id`, `content`, `timestamps`
* `reminders`: `id`, `workspace_id`, `job_application_id`, `created_by_user_id`, `title`, `due_at`, `status` (pending/sent/done), `channel` (email/in_app)
* `ai_job_insights`: `id`, `workspace_id`, `job_application_id`, `type`, `input_hash`, `output_text`, `model_name`, `status`
* `audit_logs`: `id`, `workspace_id`, `actor_user_id`, `entity_type`, `entity_id`, `action`, `before_json`, `after_json`, `created_at`

## 4. MVP Functional Scope
* **Auth:** Session/JWT-based Sign Up, Login, Logout, Password Reset.
* **Workspaces:** Create workspace, invite members via email token validation.
* **Tracking:** Manual job CRUD, soft-delete archive, timeline tracking via status history.
* **Utilities:** Text/Markdown notes, async email/in-app follow-up reminders.
* **AI Engine:** Async job description text parsing, summary extraction, and insight storage.
* **Dashboard:** Aggregated pipeline counts, pending alerts, and basic activity charts.

## 5. Pipeline State Machine
`Saved` -> `Applied` -> `Screening` -> `Interview` -> `Offer` -> `[Rejected / Withdrawn]`

## 6. Engineering Requirements (NFRs)
* **Security:** Global workspace isolation middleware matching `workspace_id` from token to request resource.
* **Performance:** Cursor pagination for large queries, cached analytics endpoints, rate-limited AI generation.
* **Reliability:** Idempotent background queues for asynchronous tasks (AI workers, email dispatches).
* **Build Order:** `users` -> `workspaces` -> `job_applications` -> `members/notes/reminders` -> `AI integrations`.