from phi.tools.yfinance import YFinanceTools
from phi.model.groq import Groq
from phi.agent import Agent
# Stock Price Agent 
stock_price_agent = Agent(
    name = "Stock Price Agent",
    model = Groq(id = "llama-3.3-70b-versatile"),
    tools = [YFinanceTools()],
    instructions = [
        "Fetch the latest stock price for the given company",
        "Provide the current stock price along with any relevant market data.",
        "Provide insights and predictions for the next trading day."
    ],

    show_tool_calls= True,
    markdown = True,
    debug_mode = True,
)
stock_price_agent.print_response(
    "Fetch the latest stock price for Tesla",
    stream = True
)