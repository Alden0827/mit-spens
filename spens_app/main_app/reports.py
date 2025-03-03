# views.py
from django.http import HttpResponse
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Paragraph, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import inch  # Import inch here

def generate_pdf(request):
    # Create an HTTP response object with the appropriate content type
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="sample_report_with_colspan.pdf"'

    # Create a PDF document
    document = SimpleDocTemplate(response, pagesize=letter)

    # Add a sample title and paragraph
    styles = getSampleStyleSheet()
    title = Paragraph("Sample PDF Report with Column Span", styles['Title'])
    intro_text = Paragraph("This report includes a table with a column-spanning header.", styles['Normal'])

    # Define the data for the table, including a column-span example
    data = [
        ['ID', 'Name', 'Age', 'City'],
        ['001', 'Alice', 30, 'New York'],
        ['002', 'Bob', 25, 'San Francisco'],
        ['003', 'Charlie', 35, 'Los Angeles'],
        ['004', 'David', 28, 'Chicago'],
    ]

    # Create a table with column-span for the header
    table_data = [
        ['Header Row (Spanning All Columns)', '', '', ''],  # This will span all columns
        data[0],  # The second row will be the actual table header
    ] + data[1:]  # Rest of the table data

    # Define the table
    table = Table(table_data, colWidths=[1.5 * inch, 2 * inch, 1.5 * inch, 2 * inch])

    # Set table style, including colspan for the header row
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        # Define column span for the first header row
        ('SPAN', (0, 0), (-1, 0)),  # Span the first header row across all columns
    ]))

    # List of content (Title, Intro, and Table)
    content = [title, intro_text, table]

    # Build the document
    document.build(content)

    # Return the response which will generate the PDF dynamically
    return response
