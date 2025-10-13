from phi.agent import Agent
from knowledge_base import pdf_knowledge_base

agent = Agent(
    knowledge=pdf_knowledge_base,
    search_knowledge=True,
)
agent.knowledge.load(recreate=False)

agent.print_response("Please explain OOPs concept")