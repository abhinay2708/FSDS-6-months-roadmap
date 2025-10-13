from phi.knowledge.pdf import PDFKnowledgeBase, PDFReader
from phi.vectordb.duckdb import DuckDB

pdf_knowledge_base = PDFKnowledgeBase(
    path="The Ultimate Python Handbooks",
    vector_db=DuckDB(
        path="wip/pdf_vectors.duckdb",
        table_name="pdf_documents",
    ),
    reader=PDFReader(chunk=True),
)
