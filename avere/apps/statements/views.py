from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView
from django.views.generic.list import ListView

from statements.forms import StatementForm
from statements.models import Statement


class StatementDetailView(DetailView):
    model = Statement


class StatementCreateView(CreateView):
    form_class = StatementForm
    fields = [
        'first_name',
        'last_name',
        'position',
        'position_location'
    ]


class StatementUpdateView(UpdateView):
    form_class = StatementForm
    fields = [
        'first_name',
        'last_name',
        'position',
        'position_location'
    ]


class StatementListView(ListView):
    model = Statement
