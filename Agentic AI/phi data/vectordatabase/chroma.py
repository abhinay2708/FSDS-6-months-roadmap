import typer
from rich.prompt import Prompt
from typing import Optional
from phi.model.groq import Groq
from phi.agent import Agent
from phi.knowledge.pdf import PDFUrlKnowledgeBase
from phi.vectordb.chroma import ChromaDb
import os
import sys

# -------------------------
# 1️⃣ Setup API key
# -------------------------
api_key = os.getenv("GROQ_API_KEY")
if not api_key:
    print("❌ GROQ_API_KEY is not set. Please set it in your environment.")
    sys.exit(1)

# -------------------------
# 2️⃣ Setup PDF knowledge base
# -------------------------
knowledge_base = PDFUrlKnowledgeBase(
    urls=["https://phi-public.s3.amazonaws.com/recipes/ThaiRecipes.pdf"],
    vector_db=ChromaDb(collection="recipes"),
)

# First run: recreate=True, subsequent runs: recreate=False
knowledge_base.load(recreate=False)

# -------------------------
# 3️⃣ Agent function
# -------------------------
def pdf_agent(user: str = "user"):
    run_id: Optional[str] = None

    agent = Agent(
        model=Groq(id="llama-3.3-70b-versatile", api_key=api_key),
        run_id=run_id,
        user_id=user,
        knowledge_base=knowledge_base,
        use_tools=True,
        show_tool_calls=True,
        debug_mode=True,
    )

    # Get or create run_id
    run_id = agent.run_id
    print(f"✅ Started Run ID: {run_id}\n")

    # -------------------------
    # Interactive chat loop
    # -------------------------
    try:
        while True:
            message = Prompt.ask(f"[bold green]{user}[/bold green]")
            if message.lower() in ("exit", "bye", "quit"):
                print("👋 Goodbye!")
                break
            try:
                agent.print_response(message)
            except Exception as e:
                print(f"❌ Error: {e}")

    except KeyboardInterrupt:
        print("\n👋 Exiting...")

# -------------------------
# 4️⃣ Run with Typer
# -------------------------
if __name__ == "__main__":
    typer.run(pdf_agent)
