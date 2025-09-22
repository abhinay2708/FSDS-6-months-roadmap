import streamlit as st
from nltk.chat.util import Chat, reflections

# Define chatbot pairs
pairs = [
    # Greetings & Introduction
    [r"(.*)my name is (.*)", ["Hello %2, nice to meet you! How are you today?"]],
    [r"(hi|hey|hello|hola|holla)(.*)", ["Hello 👋", "Hey there!", "Hi, nice to meet you!"]],
    [r"how are you(.*)", ["I'm doing well, thanks for asking! How about you?", "I’m great! How are you doing?"]],
    [r"what is your name ?", ["My name is ChatBot 🤖, but you can just call me your virtual friend!"]],
    [r"who created you ?", ["I was created by Abhinay using Python’s NLTK library!", "That’s a top-secret 🤫"]],
    [r"(.*) your age ?", ["I don’t have an age, but I’m pretty young in computer years!"]],
    [r"who are you ?" , ["I am a Chatbot made by Abhinay"]],
    
    # General Chat
    [r"(.*) (location|city) ?", ["I am based in Hyderabad, India 🌏"]],
    [r"(.*) weather in (.*)", ["Sorry, I can’t check live weather right now, but I hope it’s nice in %2!"]],
    [r"(.*) your hobbies ?", ["I like chatting with people like you 🧑", "My hobby is learning new words 💡"]],
    [r"(.*) your favorite (food|dish)?", ["I don’t eat food, but I’ve heard pizza 🍕 is very popular!", "I like digital cookies 🍪"]],
    [r"(.*) your favorite (color|colour)?", ["I like blue 💙, it feels calm!", "I think green 💚 is refreshing!"]],
    [r"(.*) your favorite movie ?", ["I like science fiction movies 🎬", "I can’t watch movies, but I hear Inception is cool!"]],
    [r"(.*)(sports|game|sport)(.*)", ["I love cricket 🏏", "Football ⚽ is very exciting!", "I enjoy chess ♟ too!"]],
    [r"who is your favorite cricketer ?", ["I think Virat Kohli is amazing 🏏", "MS Dhoni is a true legend!"]],
    [r"do you like music ?", ["Yes 🎶, music makes people happy! Who is your favorite singer?"]],
    [r"(.*) your favorite song ?", ["I like digital beeps 🎵", "I don't have ears, but I hear Shape of You is popular!"]],
    [r"do you like travelling ?", ["I travel through the internet 🌍", "I wish I could visit Paris one day!"]],
    [r"tell me a joke", ["Why don’t skeletons fight? Because they don’t have the guts! 😂", "Why did the computer go to the doctor? It caught a virus! 💻🤒"]],
    [r"tell me a fun fact", ["Did you know honey never spoils? 🍯", "Octopuses have three hearts 🐙"]],
    
    # Help / Support
    [r"(.*)help(.*)", ["Sure! I can chat with you, tell you about sports, movies, food, or just keep you company 🙂"]],
    [r"(.*)thank you(.*)", ["You're most welcome! 🙏", "Happy to help!"]],
    
    # Goodbye
    [r"(.*)bye(.*)|quit", ["Bye for now 👋, see you soon!", "It was nice talking to you. Take care!"]],
    
    # Default response
    [r"(.*)", ["Hmm 🤔, I’m not sure about that. Can you ask me something else?", 
               "Interesting... tell me more!", 
               "Our customer service will reach you."]]
]


# Create chatbot
chat = Chat(pairs, reflections)

# Streamlit UI
st.set_page_config(page_title="NLTK Chatbot", page_icon="🤖", layout="centered")

st.title("🤖  Chatbot")
st.write("Type your message below and chat with the bot!")

# Maintain chat history
if "history" not in st.session_state:
    st.session_state.history = []

# User input
user_input = st.text_input("You:", "")

if st.button("Send") and user_input:
    response = chat.respond(user_input)
    st.session_state.history.append(("You", user_input))
    st.session_state.history.append(("Bot", response))

# Display chat history
for speaker, msg in st.session_state.history:
    if speaker == "You":
        st.markdown(f"🧑 **You:** {msg}")
    else:
        st.markdown(f"🤖 **Bot:** {msg}")
