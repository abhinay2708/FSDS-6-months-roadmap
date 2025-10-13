from phi.agent import Agent
from phi.model.groq import Groq
# from dotenv import load_dotenv
# import os
# import groq

# load_dotenv()
api_key="gsk..........KqHm"

# if not api_key:
#     raise ValueError("GROQ_API_KEY not found. Check your .env file!")

# groq.api_key = api_key  # Set globally

agent = Agent(
    model=Groq(id="llama-3.3-70b-versatile", api_key=api_key),
    markdown=True
)

agent.print_response("about nvidia stock")