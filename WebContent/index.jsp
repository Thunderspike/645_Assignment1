<%@page import="com.google.gson.Gson" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>SWE 645 - Pol Ajazi</title>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <link rel="icon" href="images/favicon.ico" />
            <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400&display=swap"
                rel="stylesheet" />
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
            <style>
                body,
                h1,
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-family: "Roboto", sans-serif;
                }

                p {
                    margin-top: 16px;
                    margin-bottom: 4px;
                }

                input {
                    width: 100%;
                }

                .divider {
                    margin-top: 24px;
                }

                .error-text {
                    color: #f44336 !important;
                }

                .error-border {
                    border: 1px solid #f44336 !important;
                    outline-color: #f44336;
                }
            </style>
        </head>

        <% Integer hitsCount=(Integer) application.getAttribute("hitCounter"); hitsCount=(hitsCount==null ||
            hitsCount==0 ) ? 1 : ++hitsCount; application.setAttribute("hitCounter", hitsCount);%>


            <script>
                console.log({
                    numPageVisits: <%= hitsCount %>,
                    previousRequest: <%=(new Gson()).toJson(request.getParameterMap()) %>,
                    envVar: <%=(new Gson()).toJson(System.getenv()) %>,
                    HOSTNAME: "<%= System.getenv().get("HOSTNAME") %>"
    });
            </script>

            <body class="w3-light-grey">
                <div class="w3-padding">
                    <div class="w3-white w3-margin">
                        <div class="w3-white w3-margin">
                            <div class="w3-container w3-white">
                                <div class="w3-container w3-padding w3-black">
                                    <h4 class="w3-show-inline-block">Please enter the following info below</h4>
                					<p class="w3-show-inline-block w3-right">node: <%= System.getenv().get("HOSTNAME") %></p>
                                </div>
                                <!-- action="index.jsp" -->
                                <form method="post" onsubmit="return onSubmitFunc(event)">
                                    <div class="w3-container w3-padding">
                                        <h4 class="w3-show-inline-block">Please enter the following info below</h4>
                                        <p class="w3-show-inline-block w3-right">node: <%=
                                                System.getenv().get("HOSTNAME") %>
                                        </p>
                                        <input name="fname" type="text" required placeholder="First Name"
                                            class="w3-input w3-border" />

                                        <p>Last name:</p>
                                        <input name="lname" type="text" required placeholder="Last Name"
                                            class="w3-input w3-border" />

                                        <p>Street address:</p>
                                        <input name="address" type="text" required placeholder="Street address"
                                            class="w3-input w3-border" />

                                        <p>City:</p>
                                        <input name="city" type="text" required placeholder="City"
                                            class="w3-input w3-border" />

                                        <p>State</p>
                                        <select name="state" class="w3-input w3-border">
                                            <option value="Virginia">Virginia</option>
                                            <option value="Maryland">Maryland</option>
                                            <option value="District of Columbia">
                                                District of Columbia
                                            </option>
                                            <option value="Alaska">Alaska</option>
                                            <option value="Alabama">Alabama</option>
                                            <option value="Arkansas">Arkansas</option>
                                            <option value="American Samoa">American Samoa</option>
                                            <option value="Arizona">Arizona</option>
                                            <option value="California">California</option>
                                            <option value="Colorado">Colorado</option>
                                            <option value="Connecticut">Connecticut</option>
                                            <option value="Delaware">Delaware</option>
                                            <option value="Florida">Florida</option>
                                            <option value="Georgia">Georgia</option>
                                            <option value="Guam">Guam</option>
                                            <option value="Hawaii">Hawaii</option>
                                            <option value="Iowa">Iowa</option>
                                            <option value="Idaho">Idaho</option>
                                            <option value="Illinois">Illinois</option>
                                            <option value="Indiana">Indiana</option>
                                            <option value="Kansas">Kansas</option>
                                            <option value="Kentucky">Kentucky</option>
                                            <option value="Louisiana">Louisiana</option>
                                            <option value="Massachusetts">Massachusetts</option>
                                            <option value="Maine">Maine</option>
                                            <option value="Michigan">Michigan</option>
                                            <option value="Minnesota">Minnesota</option>
                                            <option value="Missouri">Missouri</option>
                                            <option value="Mississippi">Mississippi</option>
                                            <option value="Montana">Montana</option>
                                            <option value="North Carolina">North Carolina</option>
                                            <option value="North Dakota">North Dakota</option>
                                            <option value="Nebraska">Nebraska</option>
                                            <option value="New Hampshire">New Hampshire</option>
                                            <option value="New Jersey">New Jersey</option>
                                            <option value="New Mexico">New Mexico</option>
                                            <option value="Nevada">Nevada</option>
                                            <option value="New York">New York</option>
                                            <option value="Ohio">Ohio</option>
                                            <option value="Oklahoma">Oklahoma</option>
                                            <option value="Oregon">Oregon</option>
                                            <option value="Pennsylvania">Pennsylvania</option>
                                            <option value="Puerto Rico">Puerto Rico</option>
                                            <option value="Rhode Island">Rhode Island</option>
                                            <option value="South Carolina">South Carolina</option>
                                            <option value="South Dakota">South Dakota</option>
                                            <option value="Tennessee">Tennessee</option>
                                            <option value="Texas">Texas</option>
                                            <option value="Utah">Utah</option>
                                            <option value="Virgin Islands">Virgin Islands</option>
                                            <option value="Vermont">Vermont</option>
                                            <option value="Washington">Washington</option>
                                            <option value="Wisconsin">Wisconsin</option>
                                            <option value="West Virginia">West Virginia</option>
                                            <option value="Wyoming">Wyoming</option>
                                        </select>

                                        <p>Zip</p>
                                        <input class="w3-input w3-border" type="text" placeholder="Zip" />

                                        <p>Telephone Number</p>
                                        <input name="tel" type="tel" pattern="\(?[0-9]{3}\)?\s?-?[0-9]{3}-?[0-9]{4}"
                                            required placeholder="Telephone Number" class="w3-input w3-border" />

                                        <p>E-mail</p>
                                        <input name="email" type="email" required placeholder="Enter e-mail"
                                            class="w3-input w3-border" />

                                        <div class="nativeDatePicker">
                                            <p>Date of Survey:</p>
                                            <input name="surveyDate" type="date" required class="w3-input w3-border" />
                                        </div>
                                        <p class="fallbackLabel">Date of Survey:</p>
                                        <div class="fallbackDatePicker">
                                            <span>
                                                <label for="day">Day:</label>
                                                <select id="day" name="day"></select>
                                            </span>
                                            <span>
                                                <label for="month">Month:</label>
                                                <select id="month" name="month">
                                                    <option>January</option>
                                                    <option>February</option>
                                                    <option>March</option>
                                                    <option>April</option>
                                                    <option>May</option>
                                                    <option>June</option>
                                                    <option>July</option>
                                                    <option>August</option>
                                                    <option>September</option>
                                                    <option>October</option>
                                                    <option>November</option>
                                                    <option>December</option>
                                                </select>
                                            </span>
                                            <span>
                                                <label for="year">Year:</label>
                                                <select id="year" name="year"></select>
                                            </span>
                                        </div>
                                        <script>
                                            // define variables
                                            var nativePicker = document.querySelector(
                                                ".nativeDatePicker"
                                            );
                                            var fallbackPicker = document.querySelector(
                                                ".fallbackDatePicker"
                                            );
                                            var fallbackLabel = document.querySelector(".fallbackLabel");

                                            var yearSelect = document.querySelector("#year");
                                            var monthSelect = document.querySelector("#month");
                                            var daySelect = document.querySelector("#day");

                                            // hide fallback initially
                                            fallbackPicker.style.display = "none";
                                            fallbackLabel.style.display = "none";

                                            // test whether a new date input falls back to a text input or not
                                            var test = document.createElement("input");

                                            try {
                                                test.type = "date";
                                            } catch (e) { }

                                            // if it does, run the code inside the if() {} block
                                            if (test.type === "text") {
                                                // hide the native picker and show the fallback
                                                nativePicker.style.display = "none";
                                                fallbackPicker.style.display = "block";
                                                fallbackLabel.style.display = "block";

                                                // populate the days and years dynamically
                                                // (the months are always the same, therefore hardcoded)
                                                populateDays(monthSelect.value);
                                                populateYears();
                                            }

                                            function populateDays(month) {
                                                // delete the current set of <option> elements out of the
                                                // day <select>, ready for the next set to be injected
                                                while (daySelect.firstChild) {
                                                    daySelect.removeChild(daySelect.firstChild);
                                                }

                                                // Create variable to hold new number of days to inject
                                                var dayNum;

                                                // 31 or 30 days?
                                                if (
                                                    (month === "January") |
                                                    (month === "March") |
                                                    (month === "May") |
                                                    (month === "July") |
                                                    (month === "August") |
                                                    (month === "October") |
                                                    (month === "December")
                                                ) {
                                                    dayNum = 31;
                                                } else if (
                                                    (month === "April") |
                                                    (month === "June") |
                                                    (month === "September") |
                                                    (month === "November")
                                                ) {
                                                    dayNum = 30;
                                                } else {
                                                    // If month is February, calculate whether it is a leap year or not
                                                    var year = yearSelect.value;
                                                    var isLeap = new Date(year, 1, 29).getMonth() == 1;
                                                    isLeap ? (dayNum = 29) : (dayNum = 28);
                                                }

                                                // inject the right number of new <option> elements into the day <select>
                                                for (i = 1; i <= dayNum; i++) {
                                                    var option = document.createElement("option");
                                                    option.textContent = i;
                                                    daySelect.appendChild(option);
                                                }

                                                // if previous day has already been set, set daySelect's value
                                                // to that day, to avoid the day jumping back to 1 when you
                                                // change the year
                                                if (previousDay) {
                                                    daySelect.value = previousDay;

                                                    // If the previous day was set to a high number, say 31, and then
                                                    // you chose a month with less total days in it (e.g. February),
                                                    // this part of the code ensures that the highest day available
                                                    // is selected, rather than showing a blank daySelect
                                                    if (daySelect.value === "") {
                                                        daySelect.value = previousDay - 1;
                                                    }

                                                    if (daySelect.value === "") {
                                                        daySelect.value = previousDay - 2;
                                                    }

                                                    if (daySelect.value === "") {
                                                        daySelect.value = previousDay - 3;
                                                    }
                                                }
                                            }

                                            function populateYears() {
                                                // get this year as a number
                                                var date = new Date();
                                                var year = date.getFullYear();

                                                // Make this year, and the 100 years before it available in the year <select>
                                                for (var i = 0; i <= 100; i++) {
                                                    var option = document.createElement("option");
                                                    option.textContent = year - i;
                                                    yearSelect.appendChild(option);
                                                }
                                            }

                                            // when the month or year <select> values are changed, rerun populateDays()
                                            // in case the change affected the number of available days
                                            yearSelect.onchange = function () {
                                                populateDays(monthSelect.value);
                                            };

                                            monthSelect.onchange = function () {
                                                populateDays(monthSelect.value);
                                            };

                                            //preserve day selection
                                            var previousDay;

                                            // update what day has been set to previously
                                            // see end of populateDays() for usage
                                            daySelect.onchange = function () {
                                                previousDay = daySelect.value;
                                            };
                                        </script>

                                        <div class="divider">
                                            <p>Select what you liked most about the campus:</p>
                                            <div class="w3-cell-row">
                                                <input type="checkbox" name="most_liked" value="students"
                                                    class="w3-check" />
                                                <label> The students</label>
                                            </div>
                                            <div class="w3-cell-row">
                                                <input type="checkbox" name="location" value="true" class="w3-check" />
                                                <label for="location"> The location</label>
                                            </div>
                                            <div class="w3-cell-row">
                                                <input type="checkbox" name="most_liked" value="campus"
                                                    class="w3-check" />
                                                <label> The campus</label>
                                            </div>
                                            <div class="w3-cell-row">
                                                <input type="checkbox" name="most_liked" value="atmosphere"
                                                    class="w3-check" />
                                                <label> The atmosphere</label>
                                            </div>
                                            <div class="w3-cell-row">
                                                <input type="checkbox" name="most_liked" value="dorms"
                                                    class="w3-check" />
                                                <label> The dorms</label>
                                            </div>
                                            <div class="w3-cell-row">
                                                <input type="checkbox" name="most_liked" value="sports"
                                                    class="w3-check" />
                                                <label> The sports</label>
                                            </div>
                                        </div>

                                        <div class="divider">
                                            <p>How did you become interested in the university?</p>
                                            <input class="w3-radio" type="radio" name="referenced_thru"
                                                value="friends" />
                                            <label>Friends</label>
                                            <br />
                                            <input class="w3-radio" type="radio" name="referenced_thru" value="tv" />
                                            <label>Television</label>
                                            <br />
                                            <input class="w3-radio" type="radio" name="referenced_thru"
                                                value="internet" />
                                            <label>Internet</label>
                                            <br />
                                            <input class="w3-radio" type="radio" name="referenced_thru" value="other" />
                                            <label>Other</label>
                                        </div>

                                        <p>
                                            How likely are you to recomned this school to other
                                            prospective students?
                                        </p>
                                        <select name="recomendToOthers" class="w3-input w3-border">
                                            <option value="very_likely">Very Likely</option>
                                            <option value="likely">Likely</option>
                                            <option value="unlikely">Unlikely</option>
                                        </select>

                                        <p>
                                            <span id="raffleInstructions">
                                                Please enter at least 10 comma separated numbers ranging
                                                from 1 through 100.</span><br />
                                            This information will be used to announce whether you will win
                                            a free movie ticket.
                                        </p>
                                        <input name="raffle" type="text" required
                                            placeholder="Please enter at least 10 comma separated numbers ranging from 1 through 100"
                                            class="w3-input w3-border" />

                                        <p>Comments</p>
                                        <textarea name="comments" placeholder="Enter any comments you might have"
                                            class="w3-input w3-border"></textarea>
                                    </div>

                                    <script>
                                        function onSubmitFunc(e) {
                                            const validRaffleLength = document
                                                .querySelector('input[name="raffle"]')
                                                .value.split(",")
                                                .filter(function (el) {
                                                    return !isNaN(el) && el > 0 && el < 101;
                                                }).length;

                                            if (validRaffleLength < 10) {
                                                document
                                                    .getElementById("raffleInstructions")
                                                    .classList.add("error-text");
                                                document
                                                    .querySelector('input[name="raffle"]')
                                                    .classList.add("error-border");
                                                return false;
                                            }

                                            setMonthField();
                                            return true;
                                        }

                                        function setMonthField() {
                                            // set month to current month
                                            var currMonth = "January";
                                            switch (
                                            new Date(
                                                document.querySelector("[name=surveyDate]").value
                                            ).getMonth()
                                            ) {
                                                case 1:
                                                    currMonth = "February";
                                                    break;
                                                case 2:
                                                    currMonth = "March";
                                                    break;
                                                case 3:
                                                    currMonth = "April";
                                                    break;
                                                case 4:
                                                    currMonth = "May";
                                                    break;
                                                case 5:
                                                    currMonth = "June";
                                                    break;
                                                case 6:
                                                    currMonth = "July";
                                                    break;
                                                case 7:
                                                    currMonth = "August";
                                                    break;
                                                case 8:
                                                    currMonth = "September";
                                                    break;
                                                case 9:
                                                    currMonth = "October";
                                                    break;
                                                case 10:
                                                    currMonth = "November";
                                                    break;
                                                case 11:
                                                    currMonth = "December";
                                                    break;
                                                default:
                                                    currMonth = "January";
                                            }
                                            document.getElementById("month").value = currMonth;
                                        }
                                    </script>

                                    <button type="submit" class="w3-button w3-block w3-amber divider">
                                        Submit Survey
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </body>

        </html>