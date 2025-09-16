# HospitalTrack ➕🍸
HospitalTrack is a PL/SQL system for managing patients, doctors, appointments, and prescriptions in a unified schema. It automates scheduling with cursors, records prescriptions with stock control, and ensures performance through optimized queries, indexes, and materialized views.

---

## Features

* **Relational schema** with four core entities: `Patients`, `Doctors`, `Appointments`, and `Prescriptions`.
* **Cursor-driven scheduling** (`Auto_Schedule`) that books patients with the first available doctor.
* **Prescription procedure** (`Record_Prescription`) that assigns medications and reduces stock levels.
* **Indexes and materialized view** to accelerate appointment queries and reporting.
* **Sample dataset** of patients, doctors, and stock.
* **End-to-end test script** validating scheduling, prescription, and stock updates.

---

## Project Structure

```
HospitalTrack/
├── sql/
│   ├── tables.sql        # Schema definitions
│   ├── cursors.sql       # Auto-schedule cursor
│   ├── procedures.sql    # Prescription with stock tracking
│   ├── triggers.sql      # Optimizations and materialized view
│   ├── seed.sql          # Sample data
│   └── test.sql          # End-to-end validation
├── LICENSE               # MIT License
└── README.md             # Project documentation
```

---

## Quick Start

### 1. Create Schema

Run the schema definition script in [Oracle Live SQL](https://livesql.oracle.com/) or an Oracle XE instance:

```sql
@sql/tables.sql
```

### 2. Load Procedures, Cursors, and Views

```sql
@sql/cursors.sql
@sql/procedures.sql
@sql/triggers.sql
```

### 3. Insert Sample Data

```sql
@sql/seed.sql
```

### 4. Execute Tests

Run the validation workflow:

```sql
@sql/test.sql
```

---

## Example Output

```
Appointment scheduled for patient 1.
Prescription recorded for patient 1.
```

Queries confirm patient appointments are scheduled and pharmaceutical stock levels are updated accordingly.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Author
Created by Rico Aprilla Nanda


