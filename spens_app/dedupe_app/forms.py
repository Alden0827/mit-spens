from django import forms

class ImportFileForm(forms.Form):
    document_file = forms.FileField(
        required=True,
        label="Upload File",
        help_text="Select a file to upload"
    )
    description = forms.CharField(
        max_length=200,
        required=False,
        widget=forms.TextInput(attrs={'placeholder': 'Enter a description'}),
        help_text="Optional description of the dataset"
    )
