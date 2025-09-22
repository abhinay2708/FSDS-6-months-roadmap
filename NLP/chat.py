import streamlit as st
from nltk.chat.util import Chat, reflections

# Extended pairs with emojis & friendly replies
pairs = [
    [r"(.*)my name is (.*)", ["Hello %2 👋, nice to meet you!"]],
    [r"(hi|hey|hello|hola|holla)(.*)", ["Hello 👋", "Hey there!", "Hi, nice to meet you!"]],
    [r"how are you(.*)", ["I'm doing well 😊, how about you?", "I’m great! 🚀 How are you doing?"]],
    [r"what is your name ?", ["I’m ChatBot 🤖, your virtual friend!"]],
    [r"who created you ?", ["I was created by Abhinay using Python 💻"]],
    [r"(.*) your age ?", ["I don’t have an age, but I’m young at heart ❤️"]],
    [r"(.*) (location|city) ?", ["I’m based in Hyderabad, India 🌏"]],
    [r"(.*) your hobbies ?", ["I love chatting with awesome people like you 🧑", "Learning new things 💡"]],
    [r"tell me a joke", ["😂 Why don’t skeletons fight? Because they don’t have the guts!", 
                         "🤣 Why did the computer go to the doctor? It caught a virus!"]],
    [r"tell me a fun fact", ["🤔 Did you know honey never spoils? 🍯", "🐙 Octopuses have three hearts!"]],
    [r"(.*)thank you(.*)", ["You're most welcome 🙏", "Happy to help 😃"]],
    [r"(.*)bye(.*)|quit", ["Bye 👋, see you soon!", "It was nice chatting with you 🙂"]],
    [r"(.*)", ["Hmm 🤔, I’m not sure about that. Can you ask me something else?"]]
]

chat = Chat(pairs, reflections)

# Streamlit app
st.set_page_config(page_title="ChatBot 🤖", page_icon="💬", layout="centered")
st.title("💬 ChatBot - Powered by NLTK")

# Chat history stored in session
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display messages like chat bubbles
for msg in st.session_state.messages:
    if msg["role"] == "user":
        st.markdown(f"<div style='text-align:right; background:#DCF8C6; padding:10px; border-radius:15px; margin:5px 0; display:inline-block;'>🙋 {msg['content']}</div>", unsafe_allow_html=True)
    else:
        st.markdown(f"<div style='text-align:left; background:#F1F0F0; padding:10px; border-radius:15px; margin:5px 0; display:inline-block;'>🤖 {msg['content']}</div>", unsafe_allow_html=True)

# Input box at bottom
user_input = st.text_input("Type your message here 👇", key="input")

if user_input:
    # Save user message
    st.session_state.messages.append({"role": "user", "content": user_input})

    # Get bot reply
    bot_reply = chat.respond(user_input)

    # Save bot reply
    st.session_state.messages.append({"role": "bot", "content": bot_reply})

    # Clear input after submit
    st.session_state.input = ""
    st.experimental_rerun()
