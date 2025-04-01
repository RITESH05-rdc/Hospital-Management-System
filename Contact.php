<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Dotor.com |❤️</title>
    <link rel="stylesheet" href="css/contactus.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Contact Us</h1>
            <p>If you have any questions, concerns, or feedback, please reach out to us using the information below.</p>
        </header>

        <section class="contact-info">
            <h2>Contact Information</h2>
            <p><strong>Phone:</strong> (123) 456-7890</p>
            <p><strong>Email:</strong> <a href="mailto:support@doctorappointmentsystem.com">support@doctorappointmentsystem.com</a></p>
            <p><strong>Address:</strong> 123 Health St., Medical City, State, 12345</p>
        </section>

        <section class="contact-form">
            <h2>Send Us a Message</h2>
            <form action="/submit_contact" method="POST">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="phone">Phone (optional):</label>
                <input type="tel" id="phone" name="phone">

                <label for="subject">Subject:</label>
                <select id="subject" name="subject" required>
                    <option value="">Select a subject</option>
                    <option value="general inquiry">General Inquiry</option>
                    <option value="technical support">Technical Support</option>
                    <option value="feedback">Feedback</option>
                </select>

                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="5" required></textarea>

                <button type="submit">Submit</button>
            </form>
        </section>

        <section class="social-media">
            <h2>Follow Us</h2>
            <p>Stay connected through our social media channels:</p>
            <ul>
                <li><a href="https://facebook.com"><i class="fab fa-facebook-square"></i> Facebook</a></li>
                <li><a href="https://twitter.com"><i class="fab fa-twitter-square"></i> Twitter</a></li>
                <li><a href="https://instagram.com"><i class="fab fa-instagram-square"></i> Instagram</a></li>
                <li><a href="https://linkedin.com"><i class="fab fa-linkedin"></i> LinkedIn</a></li>
            </ul>
        </section>

        <section class="office-hours">
            <h2>Office Hours</h2>
            <p>Monday to Friday: 9 AM - 5 PM</p>
        </section>

        <div class="back-home">
            <a href="index.html" class="home-button">Home</a>
        </div>
    </div>
</body>
</html>
