# The Knowledge Graveyard

---

### Problem
We all save links that we never look at again. No re-visit, no cleaning and no lookback. I also forget all the links I have bookmarked and never look them back again.

### Solution
Manage those "links", resurface them to user and then the user decides whether to keep that link saved again or it should be removed and be given freedom.

### Goal
The goal here is to manage the "links" and "reminders".

---

#### Schema
- Link: url string, title string, note text, last resurfaced at datetime, archived / deleted boolean

- Tags: (Use the acts-as-taggable-on gem or a simple Tag model join).

---

### Teach Stack
Ruby on Rails
Active Job + Sidekiq/Solid Queue - create a job that runs every morning, picks 3 random links that haven't been resurfaced in 30 days, and emails them to you.
Action Mailer - build a daily digest template.

---

### Work plan

- [x] make link schema model
- [x] setup Link model routes
- [ ] create controller for link model CRUD operations

### Things I've learned from this project
- Model schema
- Migration generation with database rollback
- Routing
