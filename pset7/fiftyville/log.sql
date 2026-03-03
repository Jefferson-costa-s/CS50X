-- Keep a log of any SQL queries you execute as you solve the mystery.
-- All you know is that the theft took place on July 28, 2025 and that it took place on Humphrey Street.

-- First, need to look at the crime report.
SELECT description
FROM crime_scene_reports
WHERE year = 2025 AND month = 7 AND day = 28;
-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
-- Interviews were conducted today with three witnesses who were present at the time
-- each of their interview transcripts mentions the bakery.

-- Investigating the interviews
SELECT transcript, name
FROM interviews
WHERE year = 2025 AND month = 7 AND day = 28;
-- Ruth: Check bakery security logs 10 minutes post-theft
-- Raymond: Query earliest flight from Fiftyville (next day AM), and they called someone
-- who talked to them for less than a minute
-- Eugene: Search ATM transactions on Leggett Street (morning)


-- Investigating the bakery security logs
SELECT license_plate
FROM bakery_security_logs
WHERE activity='exit' AND year = 2025 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 15 AND 25;
-- Got all cars leaving the bakery between 10:15 and 10:25
-- +----------+---------------+
-- | activity | license_plate |
-- +----------+---------------+
-- | exit     | 5P2BI95       |
-- | exit     | 94KL13X       |
-- | exit     | 6P58WS2       |
-- | exit     | 4328GD8       |
-- | exit     | G412CB7       |
-- | exit     | L93JTIZ       |
-- | exit     | 322W7JE       |
-- | exit     | 0NTHK55       |
-- +----------+---------------+


-- Investigating ATM transactions on Leggett Street
SELECT id, account_number
FROM atm_transactions
WHERE atm_location = 'Leggett Street' AND transaction_type = 'withdraw' AND
year = 2025 AND month = 7 AND day = 28;
-- Got the account numbers and IDs that made a withdrawal on the theft day
-- +-----+----------------+
-- | id  | account_number |
-- +-----+----------------+
-- | 246 | 28500762       |
-- | 264 | 28296815       |
-- | 266 | 76054385       |
-- | 267 | 49610011       |
-- | 269 | 16153065       |
-- | 288 | 25506511       |
-- | 313 | 81061156       |
-- | 336 | 26013199       |
-- +-----+----------------+


-- Investigating phone calls with duration less than 60 seconds
SELECT id, caller
FROM phone_calls
WHERE duration < 60 AND year = 2025 AND month = 7 AND day = 28;
-- Got the callers and IDs that made a call with less than a minute of duration
-- +-----+----------------+
-- | id  |     caller     |
-- +-----+----------------+
-- | 221 | (130) 555-0289 |
-- | 224 | (499) 555-9472 |
-- | 233 | (367) 555-5533 |
-- | 251 | (499) 555-9472 |
-- | 254 | (286) 555-6063 |
-- | 255 | (770) 555-1861 |
-- | 261 | (031) 555-6622 |
-- | 279 | (826) 555-1652 |
-- | 281 | (338) 555-6650 |
-- +-----+----------------+

--discover the fiftyville airport name
SELECT full_name FROM airports;
-- the name is Fiftyville Regional Airport

-- now gettin id and abbreviation
SELECT id, abbreviation
FROM airports
WHERE full_name='Fiftyville Regional Airport';
-- +----+--------------+
-- | id | abbreviation |
-- +----+--------------+
-- | 8  | CSF          |


--with that information, now i can look up for the earliest flight for the next day
SELECT id, destination_airport_id, hour
FROM flights
WHERE origin_airport_id=(
    SELECT id
    FROM airports
    WHERE city = 'Fiftyville') AND
    year=2025 AND month=7 AND day=29
ORDER BY hour ASC
LIMIT 1;
-- Got the flight id and destination airport ID and hour of the flight
-- +----+------------------------+------+
-- | id | destination_airport_id | hour |
-- +----+------------------------+------+
-- | 36 | 4                      | 8    |
-- +----+------------------------+------+

--  Gettin destination citty name
SELECT city,
FROM airports
WHERE id=4;
-- Destination is New York City

SELECT name
FROM people
WHERE passport_number IN (SELECT passport_number FROM passengers WHERE flight_id=36);
--  Got the name of the passengers in the first flight out of fiftyville
-- | Kenny  |
-- | Sofia  |
-- | Taylor |
-- | Luca   |
-- | Kelsey |
-- | Edward |
-- | Bruce  |
-- | Doris  |


SELECT name
FROM people
WHERE id IN (
    SELECT person_id
    FROM bank_accounts
    WHERE account_number IN(
        SELECT account_number
        FROM atm_transactions
        WHERE atm_location = 'Leggett Street' AND
        transaction_type = 'withdraw' AND
        year = 2025 AND
        month = 7 AND
        day = 28
        )
    );

-- getting the name of the people that mande a withdraw on the day and hour the witness discribes

-- | Kenny   |
-- | Iman    |
-- | Benista |
-- | Taylor  |
-- | Brooke  |
-- | Luca    |
-- | Diana   |
-- | Bruce   |


SELECT name
FROM people
WHERE id IN (
    SELECT person_id
    FROM bank_accounts
    WHERE account_number IN(
        SELECT account_number
        FROM atm_transactions
        WHERE atm_location = 'Leggett Street' AND
        transaction_type = 'withdraw' AND
        year = 2025 AND
        month = 7 AND
        day = 28))
INTERSECT
SELECT name
FROM people
WHERE license_plate IN (
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2025 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 15 AND 25
        )
INTERSECT

SELECT name
FROM people
WHERE phone_number IN(
    SELECT caller
    FROM phone_calls
    WHERE duration < 60 AND year = 2025 AND month = 7 AND day = 28)

INTERSECT

SELECT name
FROM people
WHERE passport_number IN(
    SELECT passport_number
    FROM passengers
    WHERE flight_id=36
);
-- Using interset to cross data from all the querrys and find out who the thief is: Bruce

SELECT name
FROM people
WHERE phone_number IN(
    SELECT receiver
    FROM phone_calls
    WHERE duration < 60 AND year = 2025 AND month = 7 AND day = 28 AND
    caller=(
        SELECT phone_number
        FROM people
        WHERE name='Bruce'
        ));
-- Crossing the number of the thief (caller) and the date and time of the phone call i can isolate the name of the ACCOMPLICE
