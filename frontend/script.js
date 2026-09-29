const questionInput = document.getElementById("questionInput");
const askButton = document.getElementById("askButton");
const chatBox = document.getElementById("chatBox");
const clearChatButton = document.getElementById("clearChat");
const welcome = document.getElementById("welcome");


// =========================
// ADD MESSAGE
// =========================

function addMessage(message, type) {

    const messageDiv = document.createElement("div");
    messageDiv.className = `message ${type}`;

    const contentDiv = document.createElement("div");
    contentDiv.className = "message-content";

    contentDiv.textContent = message;

    messageDiv.appendChild(contentDiv);
    chatBox.appendChild(messageDiv);

    chatBox.scrollTop = chatBox.scrollHeight;
}


// =========================
// ASK QUESTION
// =========================

async function askQuestion(question = null) {

    if (!question) {
        question = questionInput.value.trim();
    }

    if (!question) {
        return;
    }


    // Hide welcome screen
    if (welcome) {
        welcome.style.display = "none";
    }


    // Show user question
    addMessage(question, "user");


    // Clear input
    questionInput.value = "";


    // Disable button
    askButton.disabled = true;
    askButton.textContent = "..." ;


    // Loading message
    const loadingDiv = document.createElement("div");

    loadingDiv.className = "message assistant";
    loadingDiv.id = "loadingMessage";

    loadingDiv.innerHTML = `
        <div class="message-content">
            Analyzing your data...
        </div>
    `;

    chatBox.appendChild(loadingDiv);

    chatBox.scrollTop = chatBox.scrollHeight;


    try {

        const response = await fetch(
            "http://127.0.0.1:5000/ask",
            {
                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify({
                    question: question
                })
            }
        );


        const data = await response.json();


        // Remove loading message
        const loadingMessage =
            document.getElementById("loadingMessage");

        if (loadingMessage) {
            loadingMessage.remove();
        }


        // Display response
        if (data.error) {

            addMessage(
                "Error: " + data.error,
                "assistant"
            );

        } else {

            addMessage(
                data.answer,
                "assistant"
            );
        }


    } catch (error) {

        const loadingMessage =
            document.getElementById("loadingMessage");

        if (loadingMessage) {
            loadingMessage.remove();
        }

        addMessage(
            "Unable to connect to the AI server.",
            "assistant"
        );

        console.error(error);
    }


    // Enable button
    askButton.disabled = false;
    askButton.textContent = "➤";
}


// =========================
// ANALYZE BUTTON
// =========================

askButton.addEventListener(
    "click",
    () => askQuestion()
);


// =========================
// ENTER KEY
// =========================

questionInput.addEventListener(
    "keydown",
    function(event) {

        if (event.key === "Enter" && !event.shiftKey) {

            event.preventDefault();

            askQuestion();
        }
    }
);


// =========================
// SIDEBAR EXAMPLE QUESTIONS
// =========================

const exampleQuestions =
    document.querySelectorAll(".example-question");


exampleQuestions.forEach(
    function(button) {

        button.addEventListener(
            "click",
            function() {

                const question =
                    button.textContent.trim();

                askQuestion(question);
            }
        );
    }
);


// =========================
// WELCOME SUGGESTIONS
// =========================

const suggestions =
    document.querySelectorAll(".suggestion");


suggestions.forEach(
    function(button) {

        button.addEventListener(
            "click",
            function() {

                const question =
                    button.textContent.trim();

                askQuestion(question);
            }
        );
    }
);


// =========================
// CLEAR CONVERSATION
// =========================

clearChatButton.addEventListener(
    "click",
    function() {

        // Remove all messages
        const messages =
            chatBox.querySelectorAll(".message");

        messages.forEach(
            function(message) {
                message.remove();
            }
        );


        // Show welcome screen again
        if (welcome) {
            welcome.style.display = "block";
        }


        // Clear input
        questionInput.value = "";
    }
);