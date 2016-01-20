CREATE TABLE "contacts"(
  "id" SERIAL PRIMARY KEY,
  "name"  VARCHAR(50),
  "email" VARCHAR(50)
);

CREATE TABLE "phone_numbers"(
  "id" SERIAL PRIMARY KEY,
  "type"  VARCHAR(50),
  "number" VARCHAR(50),
  "contact_id" INTEGER REFERENCES "contacts"("id")
);
