from django import forms

from statements.models import Statement


class StatementForm(forms.ModelForm):
    model = Statement
    fields = [
        'first_name',
        'last_name',
        'position',
        'position_location',
    ]
