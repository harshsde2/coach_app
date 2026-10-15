# CoachApp — Requirements

Source: HTML prototype at https://storyxuk.github.io/core_web_app/ ("FORM Dark — Powered by fibodo").
FORM is the coaching business (tenant); fibodo is the platform. The app is a member-facing
(client) app for a coaching business. All data in the prototype is mock/demo.

---

## 1. Navigation

**Bottom tab bar (mobile)** — 5 tabs:

| Tab | Root screen |
|---|---|
| Home | `home` |
| Wallet | `wallet` |
| Messages | `messages` (badge: unread count) |
| Contacts | `contacts` |
| Profile | `profileHub` |

**Top bar (all tab roots):** date eyebrow + greeting ("Hello Alex."), notification bell (unread dot),
avatar → account. Non-root screens show a "← Back" button.

**Auth screens** (`login`, `signup`, `forgotPassword`) are outside the tab shell.

---

## 2. Screen inventory (37 screens)

### 2.1 Auth
| Screen | Content / behaviour |
|---|---|
| Login | Email, password, "Forgot password?", "Log in", link to signup |
| Sign up | Full name, email, password (min 8), accept terms checkbox, "Create account" |
| Forgot password | 3 steps on one screen: email → request OTP → enter code → verify → new + confirm password → save → back to login. "Request another code" |

### 2.2 Home (dashboard)
- Business card (coach headshot, "FORM", tagline) → **About**
- "Upcoming Bookings" CTA → **Bookings**
- **Services** grid: Performance Session (1:1), Strength Lab (small group), Movement Review → **Product groups**; HYROX Performance Day → **Event detail**
- **Additional services** grid: OnDemand, Memberships, Vouchers, Fitness Plans
- Today's session hero: week/category, title, duration, exercise count, intensity, readiness %, "View workout"
- "Book Class" / "Book 1:1" buttons → Product groups
- "Your day" cards: next booking (status, time, coach + message button), weekly progress (x of y sessions, % bar), meal of the day (protein, kcal)

### 2.3 Bookings & catalogue
| Screen | Content / behaviour |
|---|---|
| Bookings | Status filter chips: All, Booked, Wishlist, Waitlisted, Selected, Available. Collapsible month calendar (prev/next month, Mon-first week, day cells show status symbols ✓ ♡ ◷ ● +). Tap day → filter list to that date. Session list. Active course card (week x of y, % complete) → Course detail. Upcoming event card → Event detail |
| Product groups | List of bookable services: category, name, description, price ("From £65"), "Book now" → Checkout journey |
| Course detail | Multi-week course: enrolled status, progress %, next session (date, time, location, notes), week-by-week accordion (Completed / Current / Upcoming, sessions per week), "Before you arrive", message coach |
| Event detail | One-day event: date, time, location, level, description, coaches, timeline agenda (time · title · description), what to bring, "Join event waitlist" |

### 2.4 Checkout journey (shared flow)
4-step stepper: **1 Choose → 2 Select → 3 Participants → 4 Checkout**.
Used by 3 kinds of purchase; step 2 changes by kind:

| Kind | Step 2 |
|---|---|
| Booking | Pick an available date/time slot (with coach) |
| Voucher | Pick voucher type/amount |
| Membership | Pick membership tier |

Step 3: who it's for (self or family member). Step 4: order summary (product, member, total) → pay.
"Secure checkout · Cancel anytime".

### 2.5 Shop
| Screen | Content |
|---|---|
| Membership shop | Current active membership banner; tiers Essential £39 / Premium £89 (Most popular) / Elite £149 with features list; "Choose X" → journey |
| Voucher shop | Digital gift card (from £25), 1:1 session £65, 3-session pack £175 → journey |
| Vouchers (gift) | Amount cards £50/£100/£200, selection summary, "Purchase securely" |

### 2.6 Training & progress
| Screen | Content |
|---|---|
| My plan | Week navigator (Week 6 of 8, ‹ ›), today's workout summary, ordered exercise list (name, sets · reps · rest, "Demo" video) |
| Achievements | Level + XP progress bar, day streak, total XP, badge count. Weekly challenges (progress, XP reward, action button: Log session / Check in / Log meals). Badge collection (locked/unlocked) |

### 2.7 Content
| Screen | Content |
|---|---|
| Video library | Search, category chips (All, Strength, Technique, Mobility, Nutrition), featured video, grid (duration, category, title, author), empty state "No videos found" |
| OnDemand | Hero series, tabs Featured / Playlists / Continue watching, video cards with duration + series/episode, playlists (count, title, description) |
| Playlist (e.g. Build strength) | Ordered video list |
| Video player | YouTube embed, title, description, "Watch on YouTube", link to playlist |
| Watchlist | Saved videos (title, category, duration) |
| News | Articles: category · date, title, summary, "Read article" |

### 2.8 Messaging & people
| Screen | Content |
|---|---|
| Messages | Conversation list (avatar initials, name, last message, time) + chat thread (header with role + online status, bubbles in/out with times, composer input) |
| Contacts | Coaches & family (role, "Message" / "Details"), "Add contact", groups (stacked avatars, member count, activity) |

### 2.9 Profile & account
| Screen | Content |
|---|---|
| Profile hub | Avatar, name, "Edit profile"; links: Bookings, Memberships, Vouchers, Contacts, Wallet, Messages (badge), Notifications |
| Account | Links: Password, Cards, Family members, QR code, Settings |
| Edit profile | First/last name, email, mobile, DOB, pronouns (They/them, She/her, He/him), primary goal (Build strength, Improve fitness, Lose body fat, Move better), notes for coach, "Last updated", Save |
| Change password | Current, new (min 8), confirm |
| Cards | Empty state, saved card (brand, last 4), remove, "Add card" |
| Add card | Placeholder for payment-provider secure card form |
| Family members | List (initials, name, relation, emergency contact flag), "Add member", Details |
| QR code | Member pass: name, member number, QR for reception check-in |
| Settings | Notification toggles: Booking reminders, Coach messages, Progress updates |
| Help & support | Message support, Call us (hours), Help centre, FAQ accordion |

### 2.10 Wallet & billing
| Screen | Content |
|---|---|
| Wallet | Payment methods (saved cards, add), account credit, active pass (e.g. 10-session pack, remaining, expiry, progress) |
| Membership | Active plan, price/month, next payment date, included benefits, Change membership, View billing history |
| Billing history | Current plan summary, invoice list (date, plan, invoice no., amount, status, View receipt) |
| Receipt | Date, member, item, amount, status |

### 2.11 Business (tenant) info
| Screen | Content |
|---|---|
| About | Business story, head coach (name, specialities) |
| Reviews | Average rating, total count, star distribution 5→1, review list (stars, time ago, quote, initials, name, tenure, verified) |

### 2.12 Notifications
Dropdown/panel from bell: "x new", latest news (2 items + View all), notification items
(icon by type: booking / plan / message; title, body, time ago) → deep-link to the relevant screen;
"Notification settings" → Settings.

---

## 3. Domain entities (from the screens)

`User/Member` (name, email, phone, DOB, pronouns, goal, notes, member no., avatar) ·
`FamilyMember` · `Coach` · `Service/Product` (category, type 1:1/group/recovery, price) ·
`Session/Slot` (date, time, coach, status: booked/wishlist/waitlisted/selected/available) ·
`Booking` · `Course` (weeks → sessions, progress) · `Event` (agenda items) ·
`MembershipTier` / `Membership` (active, next payment, benefits) · `Voucher` ·
`Pass` (sessions total/remaining, expiry) · `PaymentCard` · `Invoice` ·
`TrainingPlan` (weeks → workouts → exercises with sets/reps/rest/demo video) ·
`Achievement/Badge`, `Challenge`, `XP/Level/Streak` · `Video` (category, duration, author, YouTube id) ·
`Playlist` · `Article` · `Conversation`, `Message` · `Contact`, `Group` · `Review` · `Notification` ·
`NotificationPreferences`

---

## 4. Integrations implied

| Need | Notes |
|---|---|
| Backend API | Not specified — **TBD** |
| Auth | Email + password, email OTP for reset |
| Payments | "Your provider's secure card form" — likely Stripe (**TBD**) |
| Chat | Real-time messaging with coach (websocket / Firebase / Stream — **TBD**) |
| Push notifications | Booking reminders, coach messages, progress updates (FCM / APNs) |
| Video | YouTube embeds |
| QR code | Generate member pass QR |
| Calls | "Call us" → phone dialer |

---

## 5. Design tokens (from `app.css`)

**Theme:** dark ("FORM Dark"). Light greys in CSS (#edf2e9 etc.) suggest a light variant may exist.

| Token | Value | Use |
|---|---|---|
| ink | `#090B0B` | app background |
| panel | `#121515` | cards |
| panel2 | `#191D1C` | raised surfaces |
| text | `#F5F7F5` | primary text |
| muted | `#8D9692` | secondary text |
| eyebrowGrey | `#727B77` | eyebrow labels |
| line | `rgba(255,255,255,.09)` | borders/dividers |
| lime (brand) | `#C8FF36` | primary buttons, pills, active nav, badges |
| lime2 | `#95D813` | brand secondary |
| accentGreen | `#347B64` | ambient glow |
| error | `#E27676` | errors |
| onBrand | `#111111` | text on lime |

**Fonts:** Manrope (headings, 700–800, tight negative letter-spacing) · DM Sans (body, 400–700).

| Style | Spec |
|---|---|
| Eyebrow | 11.5px, 700, letter-spacing 0.16em, UPPERCASE, `#727B77` |
| Page title | Manrope 700, 26px (20px small phones), letter-spacing −0.035em |
| Section title | Manrope 700, 26px, letter-spacing −0.04em, ends with "." |
| Hero title | Manrope 700, 42–76px, line-height 0.96, letter-spacing −0.065em |
| Body | DM Sans 16px / 1.5 |
| Pill / status | 9–10px, 800, letter-spacing 0.12em, lime bg, dark text, radius 6 |

**Shape:** card radius 22, padding 24 (20 on mobile), 1px `line` border · button radius 11,
padding 14×20, weight 800 · bottom nav height 68, blurred translucent background.

**Repeated components:** Eyebrow + title section heading · Primary (lime) button · Outline button ·
Text button with arrow · Card · Icon chip · Status pill · Initials avatar · Stacked avatars ·
Filter chips · Progress bar / segmented bars · List tile with chevron · Accordion · Stepper ·
Price/tier card · Video card · Empty state · Toggle row · Form field with label · Toast/snackbar · Modal.

---

## 6. Open questions

1. **White-label?** Is CoachApp one app for FORM only, or a fibodo template rebranded per coaching business (logo, colours, name, bundle id per tenant)?
2. **Backend:** existing fibodo API (docs/Swagger)? Auth method (JWT)?
3. **Payments:** Stripe? Apple/Google Pay?
4. **Chat:** which real-time provider?
5. **Platforms:** phone only, or tablet/web too? (prototype has a desktop sidebar layout)
6. **Light theme** needed?
7. **Localisation:** UK English/GBP only?
8. **Scope for first deadline:** UI with mock data first, or integrated features?
