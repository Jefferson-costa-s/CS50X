import os

from cs50 import SQL
from flask import Flask, flash, jsonify, redirect, render_template, request, session

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///birthdays.db")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/", methods=["GET", "POST"])
def index():
    birthdays = db.execute("SELECT * FROM birthdays")
    if request.method == "POST":
        expeted_fields = ["name", "month", "day"]
        for field in expeted_fields:
            if not request.form.get(field):
                return render_template(
                    "index.html", birthdays=birthdays, error=f"Missing {field}"
                )

            # TODO: Add the user's entry into the database
        name = request.form.get("name")
        month = request.form.get("month")
        day = request.form.get("day")
        try:
            month = int(month)
            if month < 1 or month > 12:
                raise ValueError
        except ValueError:
            return render_template(
                "index.html",
                birthdays=birthdays,
                error=f"Month must be a valid number!",
            )
        try:
            day = int(day)
            if day < 1 or day > 31:
                raise ValueError
        except ValueError:
            return render_template(
                "index.html", birthdays=birthdays, error=f"Day must be a valid number!"
            )
        db.execute(
            "INSERT INTO birthdays (name, month, day) VALUES (?, ?, ?)",
            name,
            month,
            day,
        )
        return redirect("/")
    else:

        # TODO: Display the entries in the database on index.html

        return render_template("index.html", birthdays=birthdays)
